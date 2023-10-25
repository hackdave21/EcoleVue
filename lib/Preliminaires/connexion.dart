import 'package:application_parent/Homepage/principal.dart';
import 'package:application_parent/Preliminaires/inscription.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../outils/lesWidgets.dart';
import '../outils/style.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          hexStringToColor("5E61F4"),
          hexStringToColor("CB2B93"),
          hexStringToColor("9546C4"),
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.2, 20, 0),
            child: Column(
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 70,
                  child: Image.asset("image/man.png"),
                ),
                const SizedBox(
                  height: 15,
                ),
                reusableTextField("Entrez votre Email",
                    Icons.person_outline, false, _emailTextController,
                    obscureText: false,
                    suffixIcon: IconButton(
                        onPressed: () {},
                        icon: Container(
                          width: 0,
                        ))),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Entrez votre mot de passe",
                    Icons.lock_outline, true, _passwordTextController,
                    obscureText: false,
                    suffixIcon: IconButton(
                        onPressed: () {},
                        icon: Container(
                          width: 0,
                        ))),
                const SizedBox(
                  height: 5,
                ),
                firebaseUIButton(context, "Connexion", () {
                  FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                          email: _emailTextController.text,
                          password: _passwordTextController.text)
                      .then((value) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Maison()));
                  }).onError((error, stackTrace) {
                    print("Error ${error.toString()}");
                  });
                }),
                signUpOption(),
                /*ElevatedButton(onPressed: () {
                   Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Maison()));
                }, child: Icon(Icons.arrow_forward_ios))*/
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Vous n'avez pas encore de compte?",
            style: GoogleFonts.eduSaBeginner(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            )),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignUpScreen()));
          },
          child: Text(" Inscription",
              style: GoogleFonts.eduSaBeginner(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: Colors.lightBlue,
              )),
        )
      ],
    );
  }
}
