import 'package:flutter/material.dart';

class IndexInstruktur extends StatefulWidget {
  const IndexInstruktur({super.key});

  @override
  State<IndexInstruktur> createState() => _IndexInstrukturState();
}

class _IndexInstrukturState extends State<IndexInstruktur> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Instruktur'),
        titleSpacing: 10,
      ),
    );
  }
}
