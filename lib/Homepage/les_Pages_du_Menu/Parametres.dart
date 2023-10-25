import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Parametres extends StatefulWidget {
  const Parametres({super.key});

  @override
  State<Parametres> createState() => _ParametresState();
}

class _ParametresState extends State<Parametres> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('A propos',  style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w900,
            color: Colors.white,
          ),),
        backgroundColor: const Color.fromARGB(255, 9, 102, 178),
      ),
    );
  }
}