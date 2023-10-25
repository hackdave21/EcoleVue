import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:application_parent/outils/style.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Homepage/principal.dart';
import '../outils/lesWidgets.dart';
import 'connexion.dart'; // Assurez-vous que le chemin est correct

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _userNameTextController = TextEditingController();
  TextEditingController _classTextController = TextEditingController(); // Nouveau champ
  TextEditingController _ageTextController = TextEditingController(); // Nouveau champ

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 120, 20, 0),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 10),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 70,
                  child: Image.asset("image/man.png"),
                ),
                const SizedBox(height: 15),
                reusableTextField(
                  "Entrez le nom de l'élève",
                  Icons.person_outline,
                  false,
                  _userNameTextController,
                  obscureText: false,
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: Container(width: 0),
                  ),
                ),
                const SizedBox(height: 20),
                reusableTextField(
                  "Entrez votre Email",
                  Icons.email,
                  false,
                  _emailTextController,
                  obscureText: false,
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: Container(width: 0),
                  ),
                ),
                const SizedBox(height: 20),
                reusableTextField(
                  "Creez votre mot de passe",
                  Icons.lock_outlined,
                  true,
                  _passwordTextController,
                  obscureText: false,
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: Container(width: 0),
                  ),
                ),
                const SizedBox(height: 20),
                reusableTextField(
                  "Entrez votre classe", 
                  Icons.school,
                  false,
                  _classTextController,
                  obscureText: false,
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: Container(width: 0),
                  ),
                ),
                const SizedBox(height: 20),
                reusableTextField(
                  "Entrez votre âge", 
                  Icons.calendar_today,
                  false,
                  _ageTextController,
                  obscureText: false,
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: Container(width: 0),
                  ),
                ),
                const SizedBox(height: 20),
                firebaseUIButton(context, "Inscription", () {
                  FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                    email: _emailTextController.text,
                    password: _passwordTextController.text,
                  )
                      .then((value) {
                        FirebaseFirestore database = FirebaseFirestore.instance;
                    String userId = value.user!.uid;
                    CollectionReference collection = database.collection('users');
                    
                    collection.doc(userId).set({
                      'username': _userNameTextController.text,
                      'email': _emailTextController.text,
                      'class': _classTextController.text,
                      'age': _ageTextController.text,
                    });

                    print("Nouveau compte créé");
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Maison()),
                    );
                  }).onError((error, stackTrace) {
                    print("Erreur ${error.toString()}");
                  });
                }),
                signInOption(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row signInOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Vous avez déjà un compte?",
          style: GoogleFonts.eduSaBeginner(
            fontSize: 20,
            fontWeight: FontWeight.w900,
            color: Colors.white,
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SignInScreen()),
            );
          },
          child: Text(
            " Connexion",
            style: GoogleFonts.eduSaBeginner(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: Colors.blue,
            ),
          ),
        ),
      ],
    );
  }
}
