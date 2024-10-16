import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:multiservices_app/model/user.dart' as user_model;

class FirebaseApi {
  Future<String?> createUser(String emailAddress, String password) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      return credential.user?.uid;
    } on FirebaseAuthException catch (e) {
      print("FirebaseAuthException ${e.code}");
      return e.code;
    } on FirebaseException catch (e) {
      print("FirebaseException ${e.code}");
      return e.code;
    }
  }

  Future<String?> signInUser(String emailAddress, String password) async {
    // try {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailAddress,
      password: password,
    );
    return credential.user?.uid;
/*     } on FirebaseAuthException catch (e) {
      print("FirebaseAuthException ${e.code}");
      return e.code;
    } on FirebaseException catch (e) {
      print("FirebaseException ${e.code}");
      return e.code;
    } */
  }

  Future<String> createUserInFirestore(user_model.User user) async {
    try {
      var db = FirebaseFirestore.instance;
      final document =
          await db.collection('user').doc(user.uuid).set(user.toJson());
      return user.uuid;
    } on FirebaseException catch (e) {
      print("FirebaseException ${e.code}");
      return e.code;
    }
  }

Future<user_model.User?> getUserFromFirestoreById(String uuid) async {
  try {
    var db = FirebaseFirestore.instance;

    // Obtener el documento del usuario por su `uuid`
    DocumentSnapshot<Map<String, dynamic>> doc = await db.collection('user').doc(uuid).get();

    if (doc.exists && doc.data() != null) {
      // Convertir el documento de Firestore a una instancia de `User`
      return user_model.User.fromJson(doc.data()!);
    } else {
      print("El usuario con uuid $uuid no existe.");
      return null;
    }
  } on FirebaseException catch (e) {
    print("FirebaseException ${e.code}");
    return null;
  }
}

}
