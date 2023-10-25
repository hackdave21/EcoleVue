import 'package:application_parent/Preliminaires/connexion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:google_fonts/google_fonts.dart';

import '../outils/style.dart';

class Acceuil extends StatelessWidget {
  const Acceuil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              hexStringToColor("5E61F4"),
              hexStringToColor("CB2B93"),
              hexStringToColor("9546C4"),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "image/enfants.webp",
              width: 300,
              height: 300,
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 210, 210, 210),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  "Bienvenue sur EcoleVue. Heureux de vous compter parmi nous!!!",
                  style: GoogleFonts.eduSaBeginner(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            CountdownTimer(
              endTime: DateTime.now().millisecondsSinceEpoch + 5000,
              onEnd: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const SignInScreen()),
                );
              },
              widgetBuilder: (_, CurrentRemainingTime? time) {
                if (time == null) {
                  return Text("0",
                      style: GoogleFonts.eduSaBeginner(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ));
                }
                return Text(
                    "Prochaine page dans ${time.sec} s", 
                    style: GoogleFonts.eduSaBeginner(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
