import 'package:flutter/material.dart';
import 'package:gofid_mobile_fix/Pages/Member/HistoryMember/history_kelas_member.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gofid_mobile_fix/Bloc/app/app_bloc.dart';
import 'package:gofid_mobile_fix/Bloc/login/login_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:gofid_mobile_fix/Config/global.dart';
import 'dart:convert';

class HistoryGymPage extends StatefulWidget {
  @override
  State<HistoryGymPage> createState() => _HistoryGymPageState();
}

class _HistoryGymPageState extends State<HistoryGymPage> {
  List<dynamic> historyData = [];
  late String loggedInUserID; // ID_USER yang diambil dari login

  void initState() {
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
    String apiUrl = '$url/indexHistoryMemberGym/$loggedInUserID';
    try {
      var response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        setState(() {
          historyData = jsonData['data'];
        });
      } else {
        print('Failed to fetch history data');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History Gym'),
        automaticallyImplyLeading: false, // Menghilangkan tanda kembali
        actions: [
          IconButton(
            icon: Icon(Icons.history_toggle_off_sharp),
            onPressed: () {
              Navigator.pop(context); // Kembali ke halaman sebelumnya
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: historyData.length,
        itemBuilder: (context, index) {
          var history = historyData[index];
          var ID_BOOKING_PRESENSI_GYM = history['ID_BOOKING_PRESENSI_GYM'];
          var SESI_BOOKING_GYM = history['SESI_BOOKING_GYM'];
          var TANGGAL_BOOKING_GYM = history['TANGGAL_BOOKING_GYM'];
          var TANGGAL_GYM = history['TANGGAL_GYM'];
          var STATUS_PRESENSI = history['STATUS_PRESENSI'];

          return Card(
            elevation: 4,
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: InkWell(
              onTap: () {
                // Aksi saat Card diklik
                // showDialog(
                //   context: context,
                //   builder: (BuildContext context) {
                //     return HistoryDetailScreen(
                //         data: history, screenWidth: _screenWidth);
                //   },
                // );
              },
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
                            '#$ID_BOOKING_PRESENSI_GYM',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: fontSize,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: screenWidth * 0.02),
                          Text(
                            GetSesiText(SESI_BOOKING_GYM),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: fontSize,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: screenWidth * 0.02),
                          Text(
                            'Tanggal Booking : $TANGGAL_BOOKING_GYM',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: fontSize,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: screenWidth * 0.02),
                          Text(
                            'Tanggal Gym  : $TANGGAL_GYM',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: fontSize,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: screenWidth * 0.02),
                          Text(
                            getPresensiText(STATUS_PRESENSI),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: fontSize,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // Fungsi dan metode lainnya...
}

String GetSesiText(int sesi) {
  if (sesi == 0) {
    return '06:00 - 08:00';
  } else if (sesi == 1) {
    return '08:00 - 10:00';
  } else if (sesi == 2) {
    return '10:00 - 12:00';
  } else if (sesi == 3) {
    return '12:00 - 14:00';
  } else if (sesi == 4) {
    return '14:00 - 16:00';
  } else if (sesi == 5) {
    return '18::00 - 20:00';
  } else {
    return '20:00 - 22:00';
  }
}

String getPresensiText(int presensi) {
  if (presensi == 0) {
    return 'Belum Presensi';
  } else if (presensi == 1) {
    return 'Sudah Presensi';
  } else if (presensi == 2) {
    return 'Tidak Hadir';
  } else {
    return 'Status Presensi Tidak Valid';
  }
}
