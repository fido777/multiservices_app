import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:multiservices_app/model/user.dart' as model_user;
import 'package:multiservices_app/repository/firebase_api.dart';
import 'package:multiservices_app/utils/assets.dart';
import 'package:multiservices_app/widgets/fill_button_widget.dart';
import 'package:multiservices_app/widgets/global_text_form_field.dart';
import 'package:multiservices_app/utils/extensions.dart';
import 'package:multiservices_app/utils/lists.dart' as lists;

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final FirebaseApi _firebaseApi = FirebaseApi();

  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _repPassword = TextEditingController();
  final TextEditingController _phone = TextEditingController();


  String? _selectedCity;
  String? _selectedProfession;
  
  get _cities => null;

  void _showMessage(String msg) {
    if (mounted) {
      setState(() {
        SnackBar snackBar = SnackBar(content: Text(msg));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      });
    }
  }

  /// No toma argumentos. Recupera los datos del usuario de los controladores de texto.
  /// Valida los datos del formulario antes de intentar el registro.
  /// Muestra mensajes de éxito o error usando SnackBar.
  /// Vuelve a la pantalla anterior si el registro se ha realizado correctamente.
  Future<void> _registerNewUser() async {
    if (_name.text.isEmpty ||
        _email.text.isEmpty ||
        _password.text.isEmpty ||
        _selectedCity == null) {
      _showMessage(
          "Debe digitar nombre, correo electrónico, contraseña y ciudad");
    } else if (_password.text != _repPassword.text) {
      _showMessage("ERROR: Las contraseñas deben de ser iguales");
    } else {
      model_user.User user = model_user.User(
        uuid: "",
        name: _name.text,
        email: _email.text,
        city: _selectedCity!,
        phone: _phone.text.isEmpty ? null : _phone.text,
        profession: _selectedProfession,
      );

      try {
        // Crear usuario en Firebase Authentication y agregar el uid del usuario dado por Firebase Authentication
        user.uuid = await _firebaseApi.createUser(user.email, _password.text);
      } on FirebaseAuthException catch (e) {
        if (mounted) {
          showAuthErrorMessage(code: e.code, context: context);
        }
      }

      try {
        // Crear usuario en Firestore
        await _firebaseApi.createUserInFirestore(user);

        _showMessage('Usuario creado con éxito');
        // Navegar a la pantalla de Login
        if (mounted) {
          Navigator.pop(context);
        }
      
      } on FirebaseException catch (e) {
        if (mounted) {
          showAuthErrorMessage(context: context, code: e.code);
        }
      }
      
    }
  }

  // Función para limpiar todos los campos de texto
  void _clearTextFields() {
    _name.clear();
    _email.clear();
    _password.clear();
    _repPassword.clear();
    _phone.clear();
    _selectedCity = null;
    _selectedProfession = null;
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
    _phone.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log("Accedido a RegistrationScreen",
        level: 200, name: "RegistrationScreen.build()");
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
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Flexible(
                  // Use Flexible instead of Expanded
                  child: SizedBox(
                    height: 200, // Set a fixed height for the SizedBox
                  ),
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
                        validator: (String? value) => value!.isLongerThanSeven
                            ? null
                            : "Nombre muy corto",
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
                        validator: (String? value) => value!.isLongerThanSeven
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
                        validator: (String? value) => value == _password.text
                            ? null
                            : "Las contraseñas deben ser iguales",
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          labelText: 'Ciudad',
                          prefixIcon: Icon(Icons.location_city),
                        ),
                        value: _selectedCity,
                        hint: const Text('Selecciona tu ciudad'),
                        items: _cities.map((city) {
                          return DropdownMenuItem(
                            value: city,
                            child: Text(city),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedCity = value;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GlobalTextFormField(
                        hintText: 'Ingresa tu número de teléfono',
                        labelText: 'Ingresa tu número de teléfono',
                        controller: _phone,
                        keyboardType: TextInputType.phone,
                        prefixIcon: const Icon(Icons.phone),
                        validator: (String? value) => value!.isPhoneNumberValid
                            ? null
                            : "Número inválido",
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          labelText: 'Profesión',
                          prefixIcon: Icon(Icons.work),
                        ),
                        value: _selectedProfession,
                        hint: const Text('Selecciona tu profesión'),
                        items: lists.professions.map((profession) {
                          return DropdownMenuItem(
                            value: profession,
                            child: Text(profession),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedProfession = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                const Expanded(
                  child: SizedBox(),
                ),
                FillButtonWidget(
                  text: 'Registrarse',
                  onPressed: _registerNewUser,
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
          ),
        ],
      ),
    );
  }
}
