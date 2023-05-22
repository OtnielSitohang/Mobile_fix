import 'package:flutter/material.dart';

class HomePegawai extends StatefulWidget {
  const HomePegawai({super.key});

  @override
  State<HomePegawai> createState() => _HomePegawaiState();
}

class _HomePegawaiState extends State<HomePegawai> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text('mantap'),),
      body: Text('instruktur'),
    );
  }
}