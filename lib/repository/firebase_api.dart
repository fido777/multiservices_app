import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:multiservices_app/model/user.dart' as user_model;
import 'package:multiservices_app/model/job.dart';

// Create an Enum for the names of the firestore collections users and jobs
enum FirestoreCollectionsEnum { users, jobs }

class FirebaseApi {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Crea un nuevo usuario en Firebase Authentication con el correo electrónico y la contraseña dados.
  /// Devuelve el UID del usuario si el registro es exitoso.
  ///
  /// Lanza una excepción [FirebaseAuthException] si ocurre un error durante el proceso de creación del usuario.
  Future<String> createUser(String emailAddress, String password) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      log("Firebase Authentication: Nuevo usuario creado con UID ${userCredential.user?.uid}",
          level: 200, name: 'FirebaseApi.createUser()');
      // Return uid if succeed, throw Exception if failed
      if (userCredential.user != null) {
        return userCredential.user!.uid;
      } else {
        throw FirebaseAuthException(code: "null-user");
      }
    } on FirebaseAuthException catch (e) {
      log("Firebase Authentication Exception ${e.code}",
          level: 1000, name: 'FirebaseApi.createUser()');
      rethrow;
    }
  }

  /// Inicia sesión a un usuario existente en Firebase Authentication con el correo electrónico y la contraseña dados.
  /// Devuelve el UID del usuario si el inicio de sesión es exitoso.
  ///
  /// Lanza una excepción [FirebaseAuthException] si ocurre un error durante el proceso de inicio de sesión.
  Future<String?> signInUser(String emailAddress, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      if (userCredential.user != null) {
        return userCredential.user!.uid;
      } else {
        throw FirebaseAuthException(code: "null-user");
      }
    } on FirebaseAuthException catch (e) {
      log(
        "FirebaseAuthException ${e.code}",
        name: "signInUser()",
        level: 1000,
      );
      rethrow;
    }
  }

  /// Crea un nuevo usuario en la colección 'users' de Firestore.
  /// Recibe un objeto [user_model.User] como argumento.
  /// Devuelve el UUID del usuario creado.
  ///
  /// Lanza una excepción [FirebaseException] si ocurre un error durante la creación del usuario en Firestore.
  Future<String> createUserInFirestore(user_model.User user) async {
    // Revisar si el UID del usuario está vacío
    try {
      if (user.id.isEmpty) {
        throw FirebaseException(
            plugin: 'firebase_firestore', code: 'null-user-uid');
      }

      await _firestore
          .collection(FirestoreCollectionsEnum.users.name)
          .doc(user.id)
          .set(user.toJson()); // Creando documento

      log(
        "Firestore Database: Usuario con UID ${user.id} ha sido guardado con éxito.",
        level: 200,
        name: 'FirebaseApi.createUserInFirestore()',
      );

      return user.id;
    } on FirebaseException catch (e) {
      log("Firestore Database Exception ${e.code}",
          level: 1000, name: 'FirebaseApi.createUserInFirestore()');
      rethrow; // Relanzar el error para que sea manejado por el caller
    }
  }

  /// Obtiene un usuario de Firestore por su ID.
  /// Recibe el ID del usuario a obtener.
  /// Retorna objeto [user_model.User] si el usuario existe, de lo contrario, null.
  Future<user_model.User?> getUserFromFirestoreById(String uuid) async {
    try {
      // Obtener el documento del usuario por su `uuid`
      DocumentSnapshot<Map<String, dynamic>> doc = await _firestore
          .collection(FirestoreCollectionsEnum.users.name)
          .doc(uuid)
          .get();

      // doc.exists: This property of DocumentSnapshot is true if the document with the given uuid exists in Firestore.
      // doc.data() != null: This checks if the document actually contains any data. Even if a document exists, it might be empty.
      if (doc.exists && doc.data() != null) {
        log(
          "Firestore Database: El usuario con $uuid ha sido encontrado.",
          level: 200,
          name: 'FirebaseApi.getUserFromFirestoreById()',
          // Convertir el documento de Firestore a una instancia de `User`
        );
        return user_model.User.fromJson(doc.data()!);
      } else {
        log(
          "Firestore Database Error: El usuario con uuid $uuid no existe.",
          level: 800,
          name: 'FirebaseApi.getUserFromFirestoreById()',
        );
        return null;
      }
    } on FirebaseException catch (e) {
      log(
        'Firestore Database Exception ${e.code}',
        level: 1000,
        name: 'FirebaseApi.getUserFromFirestoreById()',
      );
      return null;
    }
  }

  /// Actualizar la URL de la imagen de perfil
  Future<void> updateUserImageUrl(String userId, String? imageUrl) async {
    try {
      await _firestore
          .collection(FirestoreCollectionsEnum.users.name)
          .doc(userId)
          .update({
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
      DocumentReference docRef = await _firestore
          .collection(FirestoreCollectionsEnum.jobs.name)
          .add({});
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
      await _firestore
          .collection(FirestoreCollectionsEnum.jobs.name)
          .doc(job.jobId)
          .set(job.toJson());
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
      QuerySnapshot querySnapshot =
          await _firestore.collection(FirestoreCollectionsEnum.jobs.name).get();
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

  Future<List<user_model.User>> getProfessionalsByProfession(
      String profession) async {
    try {
      final querySnapshot = await _firestore
          .collection(FirestoreCollectionsEnum.users.name)
          .where('profession', isEqualTo: profession)
          .get();

      return querySnapshot.docs
          .map((doc) => user_model.User.fromJson(doc.data()))
          .toList();
    } catch (e) {
      log('Error obteniendo profesionales por profesión: $e',
          level: 1000, name: 'FirebaseApi.getProfessionalsByProfession');
      return []; // Return an empty list on error
    }
  }
}
