import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class DashboardPage extends StatelessWidget {
  final String userId;

  DashboardPage({required this.userId});

  Future<void> _uploadImageAndSetUrl(PickedFile pickedImage) async {
    final storageReference = FirebaseStorage.instance.ref().child('profile_images/${userId}');

    final uploadTask = storageReference.putFile(File(pickedImage.path));
    final taskSnapshot = await uploadTask;

    final imageUrl = await taskSnapshot.ref.getDownloadURL();

    await FirebaseFirestore.instance.collection('users').doc(userId).update({
      'profileImageUrl': imageUrl,
    });
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 9, 102, 178),
        centerTitle: true,
        title: Text(
          'Tableau de bords',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w900,
            color: Colors.white,
          ),
        ),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: users.doc(userId).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          if (snapshot.hasError) {
            return Text('Erreur: ${snapshot.error}');
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Text(
              'Utilisateur non retrouvé',
              style: GoogleFonts.poppins(
                fontSize: 10,
                fontWeight: FontWeight.w900,
                color: Colors.black,
              ),
            );
          }

          var userData = snapshot.data!.data() as Map<String, dynamic>;
          String userName = userData['username'] ?? '';
          String userClass = userData['class'] ?? '';
          String userAge = userData['age'] ?? '';

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    CircleAvatar(
                      radius: 70,
                      backgroundImage: userData['profileImageUrl'] != null
                          ? NetworkImage(userData['profileImageUrl'])
                          : null,
                      child: userData['profileImageUrl'] == null
                          ? const Icon(
                              Icons.photo,
                              size: 70,
                            )
                          : null,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: CircleAvatar(
                        backgroundColor: const Color.fromARGB(255, 26, 203, 32),
                        radius: 20,
                        child: IconButton(
                          icon: const Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                          onPressed: () async {
                            final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

                            if (pickedFile != null) {
                              await _uploadImageAndSetUrl(pickedFile as PickedFile);

                              // Après la mise à jour de l'URL, vous devriez probablement rafraîchir l'état
                              // de votre widget pour afficher la nouvelle image.
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                Text(
                  userName,
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 170),
                  child: Row(
                    children: [
                      Text('Classe: ',
                          style: GoogleFonts.poppins(
                            fontSize: 17,
                            fontWeight: FontWeight.w900,
                            color: Colors.black,
                          )),
                      Text(userClass,
                          style: GoogleFonts.poppins(
                            fontSize: 17,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          )),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 170),
                  child: Row(
                    children: [
                      Text('Age: ',
                          style: GoogleFonts.poppins(
                            fontSize: 17,
                            fontWeight: FontWeight.w900,
                            color: Colors.black,
                          )),
                      Text(userAge,
                          style: GoogleFonts.poppins(
                            fontSize: 17,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          )),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
              ListView.builder(
                shrinkWrap: true,
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle button tap based on index (notes, absences, etc.).
                      },
                      style: ElevatedButton.styleFrom(
                        primary: const Color.fromARGB(255, 9, 102, 178),
                        padding: EdgeInsets.all(20),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      ),
                      child: Text(
                        _getTitle(index), // Get the title based on index.
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                },
              ),
              ],
            ),
          );
        },
      ),
    );
  }
  String _getTitle(int index) {
    switch (index) {
      case 0:
        return 'Notes';
      case 1:
        return 'Absences';
      case 2:
        return 'Devoirs à venir';
      case 3:
        return 'Événements scolaires';
      default:
        return '';
    }
  }
}
