import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:multiservices_app/auth/registration/registration_screen.dart';
import 'package:multiservices_app/repository/firebase_api.dart';
import 'package:multiservices_app/utils/assets.dart';
import 'package:multiservices_app/widgets/fill_button_widget.dart';
import 'package:multiservices_app/widgets/global_text_form_field.dart';
import 'package:multiservices_app/widgets/navigation_bar_menu.dart';
import 'dart:developer';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false; // Variable para controlar el estado de carga

  final FirebaseApi _firebaseApi = FirebaseApi();

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: SvgPicture.asset(
              Assets.circlesImage,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Expanded(
                  child: SizedBox(),
                ),
                Text(
                  'Bienvenido a Multiservicios N & D',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                GlobalTextFormField(
                  hintText: 'Correo electrónico',
                  labelText: 'Correo electrónico',
                  controller: _email,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: const Icon(Icons.email),
                ),
                const SizedBox(
                  height: 30,
                ),
                GlobalTextFormField(
                  hintText: 'Contraseña',
                  labelText: 'Contraseña',
                  controller: _password,
                  obscureAvailable: true,
                  keyboardType: TextInputType.visiblePassword,
                  prefixIcon: const Icon(Icons.lock),
                ),
                /* const SizedBox(
                  height: 30,
                ),
                InkWell(
                  child: Text(
                    '¿Olvidaste la contraseña?',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                ), */
                const SizedBox(
                  height: 40,
                ),
                _isLoading
                    ? const CircularProgressIndicator() // Mostrar indicador de carga
                    : FillButtonWidget(
                        text: 'Iniciar sesión',
                        onPressed: () =>
                            _onLoginButtonClicked(_email.text, _password.text),
                      ),
                const SizedBox(
                  height: 20,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '¿No tienes una cuenta?',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      TextSpan(
                        text: ' Regístrate',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const RegistrationScreen()));
                          },
                      ),
                    ],
                  ),
                ),
                const Expanded(
                  child: SizedBox(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onLoginButtonClicked(String emailAddress, String password) async {
    setState(() {
      _isLoading = true; // Cambiar el estado a cargando
    });
    String? result;
    try {
      if (emailAddress == "" || password == "") {
        _showErrorMessage("no-user-or-password"); // Error personalizado
        return;
      }
      // Esperar a que el inicio de sesión se complete
      result = await _firebaseApi.signInUser(emailAddress, password);

      if (result != null) {
        // Si el inicio de sesión es exitoso, navegar a la siguiente pantalla
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const NavigationBarMenu()),
        );
      } else {
        // Si la autenticación falla, mostrar un mensaje de error
        _showErrorMessage("Usuario no existente");
      }
    } on FirebaseAuthException catch (e) {
      log("FirebaseAuthException ${e.code}",
          name: "_onLoginButtonClicked", level: 800);
      _showErrorMessage(e.code);
    } finally {
      setState(() {
        _isLoading = false; // Detener la animación de carga
      });
    }
  }

  void _showErrorMessage(String code) {
    // Create a message for the snackbar depending on the given error code by FirebaseAuthException
    String message = "";
    switch (code) {
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
      case "no-user-or-password":
        message = "Debe ingresar un correo electrónico y una contraseña.";
        break;
      default:
        message = "Error al iniciar sesión.";
        break;
    }
    setState(() {
      SnackBar snackBar = SnackBar(content: Text(message));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }
}
