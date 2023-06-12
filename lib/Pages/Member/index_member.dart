import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gofid_mobile_fix/Bloc/app/app_bloc.dart';
import 'package:gofid_mobile_fix/Components/component.dart';
import 'package:gofid_mobile_fix/Config/theme_config.dart';
import 'package:gofid_mobile_fix/Pages/Member/Booking/booking_kelas_page.dart';
import 'package:gofid_mobile_fix/Repository/repo_booking_kelas.dart';
import 'package:http/http.dart';
import 'package:scroll_loop_auto_scroll/scroll_loop_auto_scroll.dart';
import 'package:gofid_mobile_fix/Models/booking_gym.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' as http_package;

import '../../Bloc/login/login_bloc.dart';
import '../../Config/global.dart';

final http.Client httpClient = http.Client();

//* HomePageMember
class IndexMember extends StatefulWidget {
  const IndexMember({super.key});

  @override
  State<IndexMember> createState() => _IndexMemberState();
}

class _IndexMemberState extends State<IndexMember> {
  // http.Client httpClient = http.Client();
  static String get baseUrl => url;
  List<dynamic> historyBookingKelas = [];
  late String loggedInUserID;
  late String ID_BOOKING;

  get http => null;

  @override
  initState() {
    super.initState();
    loggedInUserID = getLoggedInUserID();
    fetchHistoryData();
  }

  String getLoggedInUserID() {
    String? ID_MEMBER =
        BlocProvider.of<LoginBloc>(context).state.user?.ID_MEMBER;
    return ID_MEMBER ?? '';
  }

  Future<void> fetchHistoryData() async {
    String apiUrl = '$url/ShowBookingByIDMEMBER/$loggedInUserID';
    try {
      var response = await http_package.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        if (jsonData['data'] != null) {
          setState(() {
            historyBookingKelas = List.from(jsonData['data']);
          });
        }
      } else {
        print('Failed to fetch history data');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<void> sendIzinDataToBackend(
      String ID_BOOKING_KELAS, String ID_JADWAL_HARIAN) async {
    final url = '$baseUrl/CancelBooking/$ID_BOOKING_KELAS/$ID_JADWAL_HARIAN';

    try {
      final response = await httpClient.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'ID_BOOKING_KELAS': ID_BOOKING_KELAS,
          'ID_JADWAL_HARIAN': ID_JADWAL_HARIAN,
        }),
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        print('Data berhasil dikirim ke backend');
      } else {
        print('Gagal mengirim data ke backend. Status: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          headerHomeMember(),
          Center(child: HeaderTemplate(message: 'List Booking Kelas')),
          Visibility(
            visible: historyBookingKelas.isNotEmpty,
            child: Expanded(
              child: ListView.builder(
                itemCount: historyBookingKelas.length,
                itemBuilder: (context, index) {
                  var item = historyBookingKelas[index];
                  var ID_JADWAL_HARIAN = item['ID_JADWAL_HARIAN'];
                  var ID_BOOKING_KELAS = item['ID_BOOKING_KELAS'];
                  var TANGGAL_KELAS = item['TANGGAL_KELAS'];
                  var SESI_BOOKING_KELAS = item['SESI_BOOKING_KELAS'];
                  var TANGGAL_BOOKING_KELAS = item['TANGGAL_BOOKING_KELAS'];
                  var NAMA_KELAS = item['NAMA_KELAS'];

                  // final isCancelable = DateTime.parse(TANGGAL_BOOKING_KELAS)
                  //     .subtract(Duration(days: 1))
                  //     .isAfter(DateTime.now());
                  final isCancelable =
                      TANGGAL_KELAS != null && TANGGAL_KELAS.isNotEmpty
                          ? DateTime.parse(TANGGAL_KELAS)
                              .subtract(Duration(days: 1))
                              .isAfter(DateTime.now())
                          : false;

                  return Card(
                    elevation: 4,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                          colors: [Colors.blue.shade200, Colors.blue.shade400],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          final screenWidth = constraints.maxWidth;
                          final cardWidth = screenWidth * 0.9;
                          final fontSize = screenWidth * 0.04;

                          return Container(
                            width: cardWidth,
                            padding: EdgeInsets.all(screenWidth * 0.04),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'ID $ID_BOOKING_KELAS',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: fontSize,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Kelas $NAMA_KELAS',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: fontSize,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Pada $TANGGAL_KELAS',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: fontSize,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  GetSesiTetx(SESI_BOOKING_KELAS),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: fontSize,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Di Booking Pada $TANGGAL_BOOKING_KELAS',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: fontSize,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8),
                                ElevatedButton(
                                  onPressed: isCancelable
                                      ? () {
                                          showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              title: Text('Konfirmasi'),
                                              content: Text(
                                                  'Apakah Anda yakin ingin membatalkan kelas?'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    sendIzinDataToBackend(
                                                        ID_BOOKING_KELAS,
                                                        ID_JADWAL_HARIAN);
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text('Ya'),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text('Tidak'),
                                                ),
                                              ],
                                            ),
                                          );
                                        }
                                      : null,
                                  child: Text(
                                    'Batalkan Kelas',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: fontSize,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Visibility(
            visible: historyBookingKelas.isEmpty,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const Text(
                      'Anda Belum Melakukan Booking untuk Minggu Ini',
                      textAlign: TextAlign.center,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BookingKelasPage()),
                        );
                      },
                      child: const Text(
                        'Booking Sekarang',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    // Icon(Icons.state)
                  ],
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BookingKelasPage()),
              );
            },
            child: Container(
              margin: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add, color: Colors.white),
                  const SizedBox(width: 8),
                  Text(
                    'Booking',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
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
                color: Colors.blue,
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
                boxContent2(context),
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

Container boxContent2(BuildContext context) {
  return Container(
    width: 100,
    height: 100,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(10)),
      border: Border.all(color: Colors.blue.shade200),
    ),
    child: Container(
      width: 100,
      height: 100,
      child: IconButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BookingKelasPage()),
          );
        },
        icon: Icon(Icons.add),
      ),
    ),
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

String GetSesiTetx(int sesi) {
  if (sesi == 0) {
    return 'Pukul 06:00 - 08:00';
  } else if (sesi == 1) {
    return 'Pukul 08:00 - 10:00';
  } else if (sesi == 2) {
    return 'Pukul 10:00 - 12:00';
  } else if (sesi == 3) {
    return 'Pukul 12:00 - 14:00';
  } else if (sesi == 4) {
    return 'Pukul 14:00 - 16:00';
  } else if (sesi == 5) {
    return 'Pukul 18:00 - 20:00';
  } else {
    return 'Pukul 20:00 - 22:00';
  }
}
