import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:multiservices_app/auth/registration/registration_screen.dart';
import 'package:multiservices_app/utils/assets.dart';
import 'package:multiservices_app/widgets/fill_button_widget.dart';
import 'package:multiservices_app/widgets/global_text_form_field.dart';
import 'package:multiservices_app/widgets/navigation_bar_menu.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                const GlobalTextFormField(
                  hintText: 'Correo electrónico',
                  labelText: 'Correo electrónico',
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: Icon(Icons.email),
                ),
                const SizedBox(
                  height: 30,
                ),
                const GlobalTextFormField(
                  hintText: 'Contraseña',
                  labelText: 'Contraseña',
                  obscureAvailable: true,
                  keyboardType: TextInputType.visiblePassword,
                  prefixIcon: Icon(Icons.lock),
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
                FillButtonWidget(
                  text: 'Iniciar sesión',
                  onPressed: _onLoginButtonClicked,
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

  void _onLoginButtonClicked() {
    /* Invocar a Firebase authentication y navegar a NavigationBar si es exitoso */
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const NavigationBarMenu()));
  }
}
