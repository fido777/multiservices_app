import 'dart:developer';
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
      log("FirebaseAuthException ${e.code}", level: 1000);
      return e.code;
    }
  }

  /// Inicia la sesión de un usuario con el correo electrónico y la contraseña indicados.
  ///
  /// Devuelve el UID del usuario si la operación es correcta; de lo contrario, devuelve un código de error.
  /// Lanza [FirebaseAuthException] si hay un problema con la conexión de Firebase.
  Future<String?> signInUser(String emailAddress, String password) async {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailAddress,
      password: password,
    );
    return credential.user?.uid;
  }

  Future<String> createUserInFirestore(user_model.User user) async {
    try {
      var db = FirebaseFirestore.instance;
      await db
          .collection('user')
          .doc(user.uuid)
          .set(user.toJson()); // Creando documento
      return user.uuid;
    } on FirebaseException catch (e) {
      log("FirebaseException ${e.code}", level: 1000);
      return e.code;
    }
  }

  Future<user_model.User?> getUserFromFirestoreById(String uuid) async {
    try {
      var db = FirebaseFirestore.instance;

      // Obtener el documento del usuario por su `uuid`
      DocumentSnapshot<Map<String, dynamic>> doc =
          await db.collection('user').doc(uuid).get();

      if (doc.exists && doc.data() != null) {
        // Convertir el documento de Firestore a una instancia de `User`
        return user_model.User.fromJson(doc.data()!);
      } else {
        log("El usuario con uuid $uuid no existe.", level: 800);
        return null;
      }
    } on FirebaseException catch (e) {
      log("FirebaseException ${e.code}", level: 1000);
      return null;
    }
  }

  final CollectionReference usersRef =
      FirebaseFirestore.instance.collection('user');

  /// Actualizar la URL de la imagen de perfil
  Future<void> updateUserImageUrl(String userId, String? imageUrl) async {
    await usersRef.doc(userId).update({
      'imageUrl': imageUrl,
    });
  }
}
