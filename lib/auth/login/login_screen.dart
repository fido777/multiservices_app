import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:multiservices_app/utils/assets.dart';
import 'package:multiservices_app/widgets/fill_button_widget.dart';
import 'package:multiservices_app/widgets/global_text_form_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(
                  height: 30,
                ),
                const GlobalTextFormField(
                  hintText: 'Contraseña',
                  obscureAvailable: true,
                  keyboardType: TextInputType.visiblePassword,
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
                  onPressed: () {
                    // Navigate to Home
                  },
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
                          ..onTap = () => {/* Navegar a registro */},
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
}
