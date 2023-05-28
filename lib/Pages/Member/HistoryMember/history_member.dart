// ignore_for_file: prefer_const_constructors, unused_import

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gofid_mobile_fix/Models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:gofid_mobile_fix/Config/global.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gofid_mobile_fix/Bloc/app/app_bloc.dart';
import 'package:gofid_mobile_fix/Bloc/login/login_bloc.dart';

class HistoryPage extends StatefulWidget {
  @override
  HistoryPageState createState() => HistoryPageState();
}

class HistoryPageState extends State<HistoryPage> {
  List<dynamic> historyData = [];
  late String loggedInUserID; // ID_USER yang diambil dari login
  late double _screenWidth = 0.0;

  @override
  void initState() {
    super.initState();
    loggedInUserID = getLoggedInUserID();
    _screenWidth = 0.0; // Initialize _screenWidth here
    fetchHistoryData();
  }

  String getLoggedInUserID() {
    String? ID_MEMBER =
        BlocProvider.of<LoginBloc>(context).state.user?.ID_MEMBER;
    return ID_MEMBER ?? '';
  }

  Future<void> fetchHistoryData() async {
    String apiUrl = '$url/indexHistoryMemberKelas/$loggedInUserID';
    inspect(loggedInUserID);
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
        title: Text('History Kelas'),
      ),
      body: ListView.builder(
        itemCount: historyData.length,
        itemBuilder: (context, index) {
          var history = historyData[index];
          var ID_BOOKING_KELAS = history['ID_BOOKING_KELAS'];
          var TANGGAL_BOOKING_KELAS = history['TANGGAL_BOOKING_KELAS'];
          var TANGGAL_KELAS = history['TANGGAL_KELAS'];
          var NAMA_INSTRUKTUR = history['Instruktur']['NAMA_USER'];
          var NAMA_KELAS = history['jadwal']['kelas']['NAMA_KELAS'];
          // var ID_BOOKING_KELAS = history['ID_BOOKING_KELAS'];

          return Card(
            elevation: 4,
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: InkWell(
              onTap: () {
                // Aksi saat Card diklik
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return HistoryDetailScreen(
                        data: history, screenWidth: _screenWidth);
                  },
                );
              },
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    colors: [Colors.blue.shade200, Colors.blue.shade400],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '#$ID_BOOKING_KELAS',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '$NAMA_KELAS',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Tanggal Kelas: $TANGGAL_KELAS',
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Nama User: $NAMA_INSTRUKTUR',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class HistoryDetailScreen extends StatelessWidget {
  final dynamic data;
  final double screenWidth;

  HistoryDetailScreen({required this.data, required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    String namaInstruktur = data['Instruktur']['NAMA_USER'];
    String idBooking = data['ID_BOOKING_KELAS'];
    String namaKelas = data['jadwal']['kelas']['NAMA_KELAS'];
    String ID_MEMBER = data['ID_MEMBER'];
    int SESI_BOOKING_KELAS = data['SESI_BOOKING_KELAS'];
    String TANGGAL_BOOKING_KELAS = data['TANGGAL_BOOKING_KELAS'];
    String TANGGAL_KELAS = data['TANGGAL_KELAS'];
    int STATUS_PRESENSI = data['STATUS_PRESENSI'];
    int SESI_JADWAL = data['jadwal']['SESI_JADWAL'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Detail History'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Card(
            elevation: 4,
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
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.history,
                        weight: 32,
                        size: 32,
                        color: Colors.blue,
                      ),
                      Flexible(
                        child: Text(
                          '#$idBooking',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  Text(
                    'Nama Kelas',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    namaKelas,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Nama Instruktur',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    namaInstruktur,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'ID Member',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    ID_MEMBER,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Tanggal Booking',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    TANGGAL_BOOKING_KELAS,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Tanggal Kelas',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    TANGGAL_KELAS,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Presensi',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    getPresensiText(STATUS_PRESENSI),
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Sesi Kelas',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    GetSesiTetx(SESI_JADWAL),
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 32),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(
                            context); // Navigate back to previous screen
                      },
                      child: Text('Kembali'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
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

String GetSesiTetx(int sesi) {
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
