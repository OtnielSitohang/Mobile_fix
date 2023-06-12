import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gofid_mobile_fix/Models/kelas.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../../Bloc/login/login_bloc.dart';
import '../../Config/global.dart';
import 'kelas_today.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class PresensiKelasPage extends StatefulWidget {
  final String idJadwalHarian;
  final String idInstruktur;

  const PresensiKelasPage({
    Key? key,
    required this.idJadwalHarian,
    required this.idInstruktur,
  }) : super(key: key);

  @override
  _PresensiKelasPageState createState() => _PresensiKelasPageState();
}

class _PresensiKelasPageState extends State<PresensiKelasPage> {
  late String idJadwalHarian;
  late String idInstruktur;
  // late String idMember;

  static String get baseUrl => url;
  List<dynamic> DataPresensiMember = [];
  late String loggedInUserID;

  // get http => null;
  var http = Client();

  @override
  void initState() {
    idJadwalHarian = widget.idJadwalHarian;
    idInstruktur = widget.idInstruktur;
    super.initState();
    loggedInUserID = getLoggedInUserID();
    fetchHistoryData();
    initializeDateFormatting('id_ID', null);
    //  idMember = DataPresensiMember[index]['ID_MEMBER'];
  }

  String getLoggedInUserID() {
    String? ID_INSTRUKTUR =
        BlocProvider.of<LoginBloc>(context).state.user?.ID_INSTRUKTUR;
    return ID_INSTRUKTUR ?? '';
  }

  Future<void> fetchHistoryData() async {
    String apiUrl = '$url/GetPresensiKelas/$idJadwalHarian/$idInstruktur';

    try {
      var response = await http.post(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);

        if (jsonData['data'] != null) {
          setState(() {
            DataPresensiMember = List.from(jsonData['data']);
          });
        }
      } else {
        print('Failed to fetch history data');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<void> GetPresensiHadir(
      String? idJadwalHarian, String ID_MEMBER) async {
    String apiUrl = '$url/PresensiMemberKelasHadir/$idJadwalHarian/$ID_MEMBER';
    inspect(apiUrl);

    try {
      final response = await http.put(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
      );
      inspect(response.statusCode);

      if (response.statusCode == 200) {
        print('Presensi Dibuat Hadir');
        // Fetch the updated data after successful presensi
        await fetchHistoryData();
      } else {
        print('Data Gagal di Update. Status: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<void> PresensiMemberKelasTidakHadir(
      String? idJadwalHarian, String ID_MEMBER) async {
    String apiUrl =
        '$url/PresensiMemberKelasTidakHadir/$idJadwalHarian/$ID_MEMBER';
    inspect(apiUrl);

    try {
      final response = await http.put(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
      );
      inspect(response.statusCode);

      if (response.statusCode == 200) {
        print('Presensi Dibuat Hadir');
        // Fetch the updated data after successful presensi
        await fetchHistoryData();
      } else {
        print('Data Gagal di Update. Status: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Presensi Member Kelas'),
        centerTitle: true,
        automaticallyImplyLeading: false, // Menghilangkan tombol kembali
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              elevation: 4,
              margin: EdgeInsets.all(10),
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
                    Text(
                      'Daftar Member Booking Kelas',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            DataPresensiMember.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                        itemCount: DataPresensiMember.length,
                        itemBuilder: (context, index) {
                          var history = DataPresensiMember[index];
                          var ID_MEMBER = history['ID_MEMBER'];
                          var NAMA_USER = history['NAMA_USER'];
                          var TANGGAL_BOOKING_KELAS =
                              history['TANGGAL_BOOKING_KELAS'];
                          // var localeId = 'id_ID';
                          var dateFormatter =
                              DateFormat('EEEE, dd MMMM yyyy', 'id_ID');
                          String formattedDate = dateFormatter
                              .format(DateTime.parse(TANGGAL_BOOKING_KELAS));

                          return Card(
                            elevation: 4,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.blue.shade200,
                                      Colors.blue.shade400
                                    ],
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
                                      padding:
                                          EdgeInsets.all(screenWidth * 0.04),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Nama Member $NAMA_USER',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: fontSize,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 8),
                                          Text(
                                            'ID Member $ID_MEMBER',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: fontSize,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 8),
                                          Text(
                                            'Tanggal Booking $formattedDate',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: fontSize,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 8),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              ElevatedButton(
                                                onPressed: (history[
                                                            'STATUS_PRESENSI'] ==
                                                        0)
                                                    ? () async {
                                                        // Aksi ketika tombol "Hadir" ditekan
                                                        await GetPresensiHadir(
                                                            widget
                                                                .idJadwalHarian,
                                                            DataPresensiMember[
                                                                    index]
                                                                ['ID_MEMBER']);
                                                        await fetchHistoryData();
                                                      }
                                                    : null,
                                                style: ElevatedButton.styleFrom(
                                                  primary: Colors.green,
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 16,
                                                      vertical: 8),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                ),
                                                child: Text('Hadir'),
                                              ),
                                              SizedBox(width: 8),
                                              ElevatedButton(
                                                onPressed: (history[
                                                            'STATUS_PRESENSI'] ==
                                                        0)
                                                    ? () async {
                                                        // Aksi ketika tombol "Tidak Hadir" ditekan
                                                        await PresensiMemberKelasTidakHadir(
                                                            widget
                                                                .idJadwalHarian,
                                                            DataPresensiMember[
                                                                    index]
                                                                ['ID_MEMBER']);
                                                        await fetchHistoryData();
                                                      }
                                                    : null,
                                                style: ElevatedButton.styleFrom(
                                                  primary: Colors.red,
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 16,
                                                      vertical: 8),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                ),
                                                child: Text('Tidak Hadir'),
                                              ),
                                            ],
                                          ),
                                          if (history['STATUS_PRESENSI'] !=
                                              0) ...[
                                            SizedBox(height: 8),
                                            Container(
                                              decoration: BoxDecoration(
                                                color: Colors.green,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              padding: EdgeInsets.all(8),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    'Sudah di presensi',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  SizedBox(height: 4),
                                                  Text(
                                                    (history['STATUS_PRESENSI'] ==
                                                            1)
                                                        ? 'MemberHadir'
                                                        : 'Member Tidak Hadir',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ],
                                      ),
                                    );
                                  },
                                )),
                          );
                        }),
                  )
                : Card(
                    elevation: 4,
                    margin: EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                          colors: [Colors.red.shade200, Colors.red.shade400],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'Tidak Ada Member yang Melakukan Booking',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Aksi ketika tombol "Selesai" ditekan
          Navigator.pop(context, ModalRoute.withName('/kelas_today'));
        },
        label: Text('Selesai'),
        icon: Icon(Icons.check),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
