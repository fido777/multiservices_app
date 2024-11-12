import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:multiservices_app/auth/registration/registration_screen.dart';
import 'package:multiservices_app/repository/firebase_api.dart';
import 'package:multiservices_app/utils/assets.dart';
import 'package:multiservices_app/utils/extensions.dart';
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
    log("Accedido a LoginScreen", level: 200, name: "LoginScreen.build()");
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
                          ..onTap = _onRegisterTextClicked,
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

  void _onRegisterTextClicked() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RegistrationScreen()),
    );
  }

  void _onLoginButtonClicked(String emailAddress, String password) async {
    setState(() {
      _isLoading = true; // Cambiar el estado a cargando
    });
    try {
      if (emailAddress.isEmpty || password.isEmpty) {
        showAuthErrorMessage(
            code: "no-email-or-password",
            context: context); // Error personalizado
        return;
      }
      // Esperar a que el inicio de sesión se complete
      await _firebaseApi.signInUser(emailAddress, password);

      // Si el inicio de sesión es exitoso, navegar a la siguiente pantalla
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const NavigationBarMenu()),
        );
      }
    } on FirebaseAuthException catch (e) {
      log("Firebase Authentication Exception: ${e.code}",
          name: '_onLoginButtonClicked()', level: 800);

      if (mounted) {
        showAuthErrorMessage(code: e.code, context: context);
      }
    } finally {
      setState(() {
        _isLoading = false; // Detener la animación de carga
      });
    }
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }
}
