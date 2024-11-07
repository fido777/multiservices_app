import 'package:flutter/material.dart';

class GlobalTextFormField extends StatefulWidget {
  final String? labelText;
  final String hintText;
  final TextEditingController? controller;
  final Widget? prefixIcon;
  final bool obscureAvailable;
  final TextInputType? keyboardType;
  final int? maxLines;
  final String? Function(String?)? validator;

  const GlobalTextFormField({
    super.key,
    required this.hintText,
    this.labelText,
    this.controller,
    this.prefixIcon,
    this.obscureAvailable = false,
    this.keyboardType,
    this.maxLines,
    this.validator,
  });

  @override
  State<GlobalTextFormField> createState() => _GlobalTextFormFieldState();
}

class _GlobalTextFormFieldState extends State<GlobalTextFormField> {
  bool isPasswordObscure = true;

  @override
  Widget build(BuildContext context) {
    // Obtener el ancho de la pantalla
    final double screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      width: screenWidth * 0.88, // 88% del ancho de la pantalla
      height: 50, // Altura deseada de 50
      child: TextFormField(
        keyboardType: widget.keyboardType,
        obscureText: widget.obscureAvailable
            ? isPasswordObscure
            : false, // Ocultar el texto si es necesario
        decoration: InputDecoration(
          suffixIcon: widget.obscureAvailable
              ? IconButton(
                  icon: Icon(
                    isPasswordObscure ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      isPasswordObscure = !isPasswordObscure;
                    });
                  },
                )
              : null, // Mostrar el icono solo si obscureAvailable es true
          filled: true,
          fillColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          prefixIcon: widget.prefixIcon,
          border: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
            borderRadius: BorderRadius.circular(30.0),
          ),
          labelText: widget.labelText,
          hintText: widget.hintText,
        ),
        controller: widget.controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: widget.validator,
        maxLines: widget.maxLines ?? 1,
      ),
    );
  }
}
