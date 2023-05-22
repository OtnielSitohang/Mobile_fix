import 'package:flutter/material.dart';

class HomeInstruktur extends StatefulWidget {
  const HomeInstruktur({super.key});

  @override
  State<HomeInstruktur> createState() => _HomeInstrukturState();
}

class _HomeInstrukturState extends State<HomeInstruktur> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text('mantap'),),
      body: Text('instruktur'),
    );
  }
}