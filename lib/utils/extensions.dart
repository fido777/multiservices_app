import 'package:flutter/material.dart';

extension Validators on String {
  bool get isLongerThanSeven => length > 7;

  bool get isEmailValid => RegExp(
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
      .hasMatch(this);

  bool get isPhoneNumberValid => RegExp(r'3\d{9}$').hasMatch(this);
}

/// Crea un mensaje para el snackbar dependiendo del código de error dado por FirebaseAuthException
void showAuthErrorMessage(
    {String code = "default", required BuildContext context}) {
  String message = "";
  switch (code) {
    case "null-user":
      message = "Error al iniciar sesión, intente de nuevo";
      break;
    case "invalid-credential":
      message = "Correo o contraseña incorrectos.";
      break;
    case "user-mismatch":
      message = "El usuario no coincide.";
      break;
    case "too-many-requests":
      message = "Demasiados intentos de inicio de sesión. Intente más tarde.";
      break;
    case "operation-not-allowed":
      message = "Esta operación no está permitida.";
      break;
    case "user-disabled":
      message = "Esta cuenta de usuario ha sido deshabilitada.";
      break;
    case "user-not-found":
      message = "No se encontró ningún usuario con ese correo electrónico.";
      break;
    case "wrong-password":
      message = "Contraseña incorrecta.";
      break;
    case "network-request-failed":
      message = "Revise su conexión a internet.";
      break;
    case "invalid-email":
      message = "El correo electrónico está mal escrito.";
      break;
    case "email-already-in-use":
      message = "Ya existe una cuenta con ese correo electrónico.";
      break;
    case "weak-password":
      message = "La contraseña es muy débil.";
      break;
    case "no-email-or-password":
      message = "Debe ingresar un correo electrónico y una contraseña.";
      break;
    default:
      message = "Error al iniciar sesión, intente de nuevo";
      break;
  }
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}
