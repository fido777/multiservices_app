import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:multiservices_app/model/user.dart' as user_model;
import 'package:multiservices_app/model/job.dart';

class FirebaseApi {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String?> createUser(String emailAddress, String password) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      log("Firebase Authentication: Nuevo usuario creado con UID ${credential.user?.uid}",
          level: 200, name: 'FirebaseApi.createUser()');
      return credential.user?.uid;
    } on FirebaseAuthException catch (e) {
      log("Firebase Authentication Exception ${e.code}",
          level: 1000, name: 'FirebaseApi.createUser()');
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
    log("Firebase Authentication: Usuario con UID ${credential.user?.uid} ha iniciado sesión.",
        level: 200, name: 'FirebaseApi.signInUser()');
    return credential.user?.uid;
  }

  Future<String> createUserInFirestore(user_model.User user) async {
    try {
      var db = FirebaseFirestore.instance;
      await db
          .collection('users')
          .doc(user.uuid)
          .set(user.toJson()); // Creando documento
      log("Firestore Database: Usuario con UID ${user.uuid} ha sido guardado con éxito.",
          level: 200, name: 'FirebaseApi.createUserInFirestore()');
      return user.uuid;
    } on FirebaseException catch (e) {
      log("Firestore Database Exception ${e.code}",
          level: 1000, name: 'FirebaseApi.createUserInFirestore()');
      return e.code;
    }
  }

  Future<user_model.User?> getUserFromFirestoreById(String uuid) async {
    try {
      var db = FirebaseFirestore.instance;

      // Obtener el documento del usuario por su `uuid`
      DocumentSnapshot<Map<String, dynamic>> doc =
          await db.collection('users').doc(uuid).get();

      if (doc.exists && doc.data() != null) {
        // Convertir el documento de Firestore a una instancia de `User`
        log("Firestore Database: El usuario con $uuid ha sido encontrado.",
            level: 200, name: 'FirebaseApi.getUserFromFirestoreById()');
        return user_model.User.fromJson(doc.data()!);
      } else {
        log("Firestore Database Error: El usuario con uuid $uuid no existe.",
            level: 800, name: 'FirebaseApi.getUserFromFirestoreById()');
        return null;
      }
    } on FirebaseException catch (e) {
      log('Firestore Database Exception ${e.code}', level: 1000, name: 'FirebaseApi.getUserFromFirestoreById()');
      return null;
    }
  }

  final CollectionReference usersRef =
      FirebaseFirestore.instance.collection('users');

  /// Actualizar la URL de la imagen de perfil
  Future<void> updateUserImageUrl(String userId, String? imageUrl) async {
    try {
      await usersRef.doc(userId).update({
        'imageUrl': imageUrl,
      });
      log('Firebase Firestore: URL de la imagen de perfil actualizada con éxito',
          level: 200, name: 'FirebaseApi.updateUserImageUrl()');
    } catch (e) {
      log('Firestore Database Exception: Error al actualizar la URL de la imagen de perfil: $e',
          level: 1000, name: 'FirebaseApi.updateUserImageUrl()');
    }
  }

  Future<String?> generateJobId() async {
    try {
      DocumentReference docRef = await _firestore.collection('jobs').add({});
      log('Firestore Database: Nuevo ID del trabajo generado: ${docRef.id}',
          level: 200, name: 'FirebaseApi.generateJobId()');
      return docRef.id;
    } catch (e) {
      log('Firestore Database Exception: Error al generar el ID del trabajo: $e',
          level: 1000, name: 'FirebaseApi.generateJobId()');
      return null;
    }
  }

  Future<String> createJobInFirestore(Job job) async {
    try {
      await _firestore.collection('jobs').doc(job.jobId).set(job.toJson());
      log('Firebase Firestore: Trabajo con ID ${job.jobId} creado con éxito',
          level: 200, name: 'FirebaseApi.createJobInFirestore()');
      return 'success';
    } catch (e) {
      log('Firebase Firestore Exception: Error al crear el trabajo: $e',
          level: 1000, name: 'FirebaseApi.createJobInFirestore()');
      return 'network-request-failed';
    }
  }

  Future<List<Job>> getJobsFromFirestore() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('jobs').get();
      List<Job> jobs = querySnapshot.docs.map((doc) {
        return Job.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
      log('Firebase Firestore: ${jobs.length} trabajos encontrados',
          level: 200, name: 'FirebaseApi.getJobsFromFirestore()');
      return jobs;
    } catch (e) {
      log('Firebase Firestore Exception: Error al obtener los trabajos: $e',
          level: 1000, name: 'FirebaseApi.getJobsFromFirestore()');
      return [];
    }
  }
}
