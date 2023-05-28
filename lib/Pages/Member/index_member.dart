import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gofid_mobile_fix/Bloc/app/app_bloc.dart';
import 'package:gofid_mobile_fix/Components/component.dart';
import 'package:gofid_mobile_fix/Config/theme_config.dart';
import 'package:gofid_mobile_fix/Repository/repo_booking_gym.dart';
import 'package:scroll_loop_auto_scroll/scroll_loop_auto_scroll.dart';
import 'package:gofid_mobile_fix/Models/booking_gym.dart';

//* HomePageMember
class IndexMember extends StatefulWidget {
  const IndexMember({super.key});

  @override
  State<IndexMember> createState() => _IndexMemberState();
}

class _IndexMemberState extends State<IndexMember> {
  BookingGymRepository bookingGymRepository = BookingGymRepository();
  List<BookingGym> bookingGym = [];

  @override
  initState() {
    super.initState();
    getBookingGym();
  }

  getBookingGym() async {
    var appBloc = context.read<AppBloc>();
    var ID_MEMBER = appBloc.state.member?.ID_MEMBER;
    bookingGym = await bookingGymRepository.show(ID_MEMBER ?? '');
    inspect(bookingGym);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          headerHomeMember(),
          Center(child: HeaderTemplate(message: '-Upcoming Booking-')),
          Visibility(
            visible: bookingGym.isNotEmpty,
            child: Expanded(
              child: ListView.builder(
                itemCount: bookingGym.length,
                itemBuilder: (context, index) {
                  var item = bookingGym[index];
                  return classCard(item);
                },
              ),
            ),
          ),
          Visibility(
            visible: bookingGym.isEmpty,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const Text(
                      '~Tidak Ada data yang di booking dalam 1 minggu terakhir~',
                      textAlign: TextAlign.center,
                    ),
                    TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Booking Sekarang',
                          textAlign: TextAlign.center,
                        )),
                    // Icon(Icons.state)
                  ],
                ),
              ),
            ),
          )
          // HeaderTemplate(message: '-Upcoming Reservation-'),
          // HeaderTemplate(message: '-Upcoming Reservation-'),
        ],
      ),
    );
  }

  Widget classCard(BookingGym item) {
    void cancelBooking() async {
      BookingGymRepository bookingGymRepository = BookingGymRepository();
      var Result = await bookingGymRepository
          .cancelBooking(item.ID_BOOKING_PRESENSI_GYM ?? '');
      // showSnackBarMessage(context, Result[0]);
      Navigator.pop(context);
      getBookingGym();
    }

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Card(
        child: ListTile(
          title: Text(
            'BOOKING GYM',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  'Booking Details - No Booking : ${item.ID_BOOKING_PRESENSI_GYM} - Member : ${item.ID_MEMBER} - Date ${item.TANGGAL_GYM}'),
              Text(
                  'Booked For ${item.TANGGAL_GYM} - Session  : ${item.sesi!.waktuMulai} - ${item.sesi!.waktuSelesai}'),
              const Text(
                  'Maximum cancellation is made 1 day before the gym activity'),
            ],
          ),
          isThreeLine: true,
          trailing: ElevatedButton(
              onPressed: () {
                showAlertDialog(context, cancelBooking);
              },
              child: Text('Cancel Booking')),
        ),
      ),
    );
  }
}

class headerHomeMember extends StatelessWidget {
  const headerHomeMember({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      height: MediaQuery.of(context).size.height * 1 / 3.2,
      child: Stack(
        children: [
          SizedBox(
            child: Container(
              width: MediaQuery.of(context).size.width * 1,
              height: MediaQuery.of(context).size.height * 1 / 4,
              decoration: const BoxDecoration(
                color: ColorApp.colorPrimary,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // AnimatedListView(),
                // boxContent(),
                boxContent2(),
              ],
            ),
          ),
          BlocBuilder<AppBloc, AppState>(builder: (context, state) {
            return Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Welcome Back',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            );
          })
        ],
      ),
    );
  }
}

// Container boxContent() {
//   return Container(
//     // width: 100,
//     height: 100,
//     decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.all(Radius.circular(10)),
//         border: Border.all(color: ColorApp.colorButtonPrimary)),
//     child: BlocBuilder<AppBloc, AppState>(builder: (context, state) {
//       return GestureDetector(
//         onTap: () => DetailSaldo(context),
//         child: ScrollLoopAutoScroll(
//           // delay: Duration(seconds: 5 ),
//           // duration: Duration(seconds: 10),
//           // gap: 25,
//           scrollDirection: Axis.vertical,
//           child: Column(
//             children: [
//               Container(
//                 width: 100,
//                 height: 100,
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Center(
//                       child: Text(
//                           'Deposit Uang : Rp  ${state.member?.totalDepositUang}')),
//                 ),
//               ),
//               Container(
//                 width: 100,
//                 height: 100,
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Center(
//                       child: Text(
//                           'Deposit paket : ${state.member?.totalDepositPaket}')),
//                 ),
//               ),
//               // Daftar item di dalam ListView
//             ],
//           ),
//         ),
//       );
//     }),
//   );
// }

Future<void> DetailSaldo(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    builder: (BuildContext context) {
      return Container(
        height: 200,
        color: Colors.amber,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text('Modal BottomSheet'),
              ElevatedButton(
                child: const Text('Close BottomSheet'),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      );
    },
  );
}

Container boxContent2() {
  return Container(
    width: 100,
    height: 100,
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: ColorApp.colorButtonPrimary)),
    child: Container(
        width: 100,
        height: 100,
        child: IconButton(onPressed: () {}, icon: Icon(Icons.add))),
  );
}

showAlertDialog(BuildContext context, VoidCallback continueAction) {
  // set up the buttons
  Widget cancelButton = TextButton(
    child: const Text("Cancel"),
    onPressed: () => Navigator.pop(context),
  );
  Widget continueButton =
      TextButton(child: const Text("Continue"), onPressed: continueAction);
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Cancel Booking"),
    content: const Text("Are you sure to cancel booking ?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
