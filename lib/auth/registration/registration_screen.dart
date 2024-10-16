import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:multiservices_app/model/user.dart';
import 'package:multiservices_app/utils/assets.dart';
import 'package:multiservices_app/widgets/fill_button_widget.dart';
import 'package:multiservices_app/widgets/global_text_form_field.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _repPassword = TextEditingController();

  void _showMessage(String msg) {
    setState(() {
      SnackBar snackBar = SnackBar(content: Text(msg));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }

  void _onRegisterButtonClicked() {
    if (_name.text.isEmpty || _email.text.isEmpty || _password.text.isEmpty) {
      _showMessage("ERROR: Debe digitar correo electrónico y contraseña");
    } else if (_password.text != _repPassword.text) {
      _showMessage("ERROR: Las contraseñas deben de ser iguales");
    } else {
      var user = User(
        uuid: "",
        name: _name.text,
        email: _email.text,
        password: _password.text,
      );
      _createUser(user);
    }
  }

  // Función para limpiar todos los campos de texto
  void _clearTextFields() {
    _name.clear();
    _email.clear();
    _password.clear();
    _repPassword.clear();
  }

  void _onLoginTextClicked() {
    _clearTextFields();
    Navigator.pop(context);
  }

  @override
  void dispose() {
    // Limpia los controllers cuando se destruye el widget
    _name.dispose();
    _email.dispose();
    _password.dispose();
    _repPassword.dispose();
    super.dispose();
  }

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
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Expanded(
                flex: 4,
                child: SizedBox(),
              ),
              Text(
                '¡Bienvenido a Bordo!',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.3),
                child: Text(
                  'Encontremos a quien necesitas',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        height: 1.6,
                      ),
                ),
              ),
              const Expanded(
                child: SizedBox(),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.05),
                child: Column(
                  children: [
                    GlobalTextFormField(
                      hintText: 'Ingresa tu nombre completo',
                      labelText: 'Ingresa tu nombre completo',
                      controller: _name,
                      keyboardType: TextInputType.text,
                      prefixIcon: const Icon(Icons.person),
                      validator: (String? value) =>
                          value!.isLongerThanFive ? null : "Nombre muy corto",
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GlobalTextFormField(
                      hintText: 'Ingresa tu correo electrónico',
                      labelText: 'Ingresa tu correo electrónico',
                      controller: _email,
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: const Icon(Icons.email),
                      validator: (String? value) =>
                          value!.isEmailValid ? null : "Correo inválido",
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GlobalTextFormField(
                      hintText: 'Ingresa tu contraseña',
                      labelText: 'Ingresa tu contraseña',
                      controller: _password,
                      keyboardType: TextInputType.visiblePassword,
                      prefixIcon: const Icon(Icons.lock),
                      obscureAvailable: true,
                      validator: (String? value) => value!.isLongerThanFive
                          ? null
                          : "Contraseña muy corta",
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GlobalTextFormField(
                      hintText: 'Confirma tu contraseña',
                      labelText: 'Confirma tu contraseña',
                      controller: _repPassword,
                      keyboardType: TextInputType.visiblePassword,
                      prefixIcon: const Icon(Icons.lock),
                      obscureAvailable: true,
                      validator: (String? value) => value!.isLongerThanFive
                          ? null
                          : "Contraseña muy corta",
                    ),
                  ],
                ),
              ),
              const Expanded(
                child: SizedBox(),
              ),
              FillButtonWidget(
                text: 'Registrarse',
                onPressed: _onRegisterButtonClicked,
              ),
              const SizedBox(
                height: 20,
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '¿Ya tienes una cuenta?',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    TextSpan(
                      text: ' Inicia sesión',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = _onLoginTextClicked,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _createUser(User user) {
    /* Invocar a Firebase */
    _showMessage("Usuario creado con éxito");
    Navigator.pop(context);
  }
}

extension on String {
  bool get isLongerThanFive => length > 5;
}

extension on String {
  bool get isEmailValid => RegExp(
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
      .hasMatch(this);
}
