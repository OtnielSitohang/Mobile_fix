import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gofid_mobile_fix/Bloc/app/app_bloc.dart';
import 'package:gofid_mobile_fix/Bloc/login/login_bloc.dart';
import 'package:gofid_mobile_fix/Components/component.dart';
import 'package:gofid_mobile_fix/Fungsi/fungsi.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ProfileMember extends StatefulWidget {
  const ProfileMember({super.key});

  @override
  State<ProfileMember> createState() => _ProfileMemberState();
}

class _ProfileMemberState extends State<ProfileMember> {
  Uint8List? bytes;

  @override
  void initState() {
    super.initState();
    loadImageFromBackend();
  }

  Future<void> loadImageFromBackend() async {
    String? base64Image =
        BlocProvider.of<LoginBloc>(context).state.user?.FOTO_USER;

    if (base64Image != null && base64Image.isNotEmpty) {
      // Membersihkan dan memvalidasi nilai base64Image
      base64Image = base64Image.replaceAll('data:image/png;base64,', '');
      base64Image = base64Image.replaceAll('data:image/jpeg;base64,', '');

      try {
        bytes = base64Decode(base64Image);
      } catch (e) {
        // Jika terjadi error saat decode, atur bytes menjadi null
        bytes = null;
      }
    } else {
      bytes = null; // Set bytes menjadi null jika data foto tidak ada
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Profile Member'),
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                context.read<LoginBloc>().add(Logout());
                Navigator.pushReplacementNamed(context, '/loginMobile2');
              },
            ),
          ],
        ),
        body: ListView(
          children: [
            Avatar(bytes: bytes),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.blue.shade200, Colors.blue.shade400],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: [
                          semiHeader('Email', state.EMAIL_USER),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.blue.shade200, Colors.blue.shade400],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.all(16),
                      child: Column(
                        children: [
                          semiHeader('ID Member', state.user?.ID_MEMBER ?? ''),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            buildPartTree(state),
            SizedBox(height: 16),
            partFour(state),
            SizedBox(height: 16),
            partTwo(state),
          ],
        ),
      );
    });
  }
}

class Avatar extends StatelessWidget {
  final Uint8List? bytes;

  const Avatar({required this.bytes});

  @override
  Widget build(BuildContext context) {
    if (bytes == null) {
      // Tampilkan avatar kosong atau default jika bytes bernilai null
      return Container(
        width: 300,
        height: 300,
        decoration: BoxDecoration(
          color: Colors.blue,
          shape: BoxShape.circle,
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(
          backgroundImage: MemoryImage(bytes!),
          radius: 150,
        ),
      );
    }
  }
}

Padding semiHeader(String title, String subtitle) {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: Column(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}

Padding partTwo(LoginState state) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade200, Colors.blue.shade400],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Card(
        // color: Colors.orangeAccent,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            padding: EdgeInsets.all(8.0),
            shrinkWrap: true,
            children: [
              ListTile(
                title: Text(
                  'Address',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(state.user?.ALAMAT_MEMBER ?? ''),
                leading: Icon(Icons.home),
              ),
              ListTile(
                title: Text(
                  'Born',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle:
                    Text(formatTanggal(state.user?.TANGGAL_LAHIR_USER ?? '')),
                leading: Icon(Icons.date_range_sharp),
              ),
              ListTile(
                title: Text(
                  'Phone Number',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(state.user?.TELEPON_MEMBER ?? ''),
                leading: Icon(Icons.phone_android),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Padding buildPartTree(LoginState state) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade200, Colors.blue.shade400],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            padding: const EdgeInsets.all(8.0),
            shrinkWrap: true,
            itemCount: 1, // Set the number of items to 1
            itemBuilder: (BuildContext context, int index) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Deposite",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Rp. ' +
                            NumberFormat('#,##0', 'en_US').format(double.parse(
                                state.user?.SISA_DEPOSIT_MEMBER ?? '')),
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  // Add more subDescription widgets here as needed
                ],
              );
            },
          ),
        ),
      ),
    ),
  );
}

Padding partFour(LoginState state) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade200, Colors.blue.shade400],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            padding: const EdgeInsets.all(8.0),
            shrinkWrap: true,
            itemCount: 1, // Set the number of items to 1
            itemBuilder: (BuildContext context, int index) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  subDescription(
                    'Total Deposite Kelas',
                    state.user?.TOTAL_KELAS,
                    Icons.class_,
                  ),
                  subDescription(
                    'Nama Kelas',
                    state.user?.kelas?.NAMA_KELAS,
                    Icons.class_outlined,
                  ),
                  // Add more subDescription widgets here as needed
                ],
              );
            },
          ),
        ),
      ),
    ),
  );
}

Widget subDescription(String textTitle, textDescription, IconData ic) {
  return Center(
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(ic),
              Text(
                textTitle,
                style: TextStyle(),
              ),
            ],
          ),
        ),
        Text(textDescription,
            style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    ),
  );
}
