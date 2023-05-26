import 'package:flutter/material.dart';
import 'package:gofid_mobile_fix/Bloc/login/login_bloc.dart';
import 'package:gofid_mobile_fix/Components/component.dart';
import 'package:gofid_mobile_fix/Fungsi/fungsi.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:gofid_mobile_fix/Bloc/app/app_bloc.dart';
import 'package:gofid_mobile_fix/Pages/Member/Profile/profile_member.dart';

class ProfileInstruktur extends StatefulWidget {
  const ProfileInstruktur({super.key});

  @override
  State<ProfileInstruktur> createState() => _ProfileInstrukturState();
}

class _ProfileInstrukturState extends State<ProfileInstruktur> {
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
      try {
        bytes = base64Decode(base64Image);
      } catch (e) {
        print('Error decoding base64 image: $e');
        bytes = null;
      }
    } else {
      bytes = null; // Set bytes menjadi null jika data foto tidak ada
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Profile Instruktur'),
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
              Container(
                child: Card(
                  color: Color.fromRGBO(102, 130, 202, 1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      semiHeader(state.EMAIL_USER),
                      semiHeader('|'),
                      semiHeader(state.user?.ID_INSTRUKTUR ?? ''),
                    ],
                  ),
                ),
              ),
              partTwo(state),
              partFour(state),
            ],
          ),
        );
      },
    );
  }
}

Padding semiHeader(String showText) {
  return Padding(
    padding: const EdgeInsets.only(left: 10.0, top: 10, bottom: 10, right: 10),
    child: Center(
        child: Text(
      showText,
      style: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
    )),
  );
}

Padding partTwo(LoginState state) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
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
                'Nama',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(state.user?.NAMA_USER ?? ''),
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
                'Deskripsi',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(state.user?.DESKRIPSI_INSTRUKTUR ?? ''),
              leading: Icon(Icons.phone_android),
            ),
          ],
        ),
      ),
    ),
  );
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

Padding partFour(LoginState state) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
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
                  'Keterlambatan',
                  state.user?.KETERLAMBATAN_INSTRUKTUR,
                  Icons.class_,
                ),
                // Add more subDescription widgets here as needed
              ],
            );
          },
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
        if (textDescription !=
            null) // Tambahkan penanganan jika textDescription tidak null
          Text(
            textDescription,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        if (textDescription ==
            null) // Tambahkan penanganan jika textDescription null
          Text(
            'No description available',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
      ],
    ),
  );
}
