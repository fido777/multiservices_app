import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:multiservices_app/model/job.dart';
import 'package:multiservices_app/repository/firebase_api.dart';
import 'package:multiservices_app/widgets/fill_button_widget.dart';
import 'package:multiservices_app/widgets/global_text_form_field.dart';

class PublishNewJobScreen extends StatefulWidget {
  const PublishNewJobScreen({super.key});

  @override
  State<PublishNewJobScreen> createState() => _PublishNewJobScreenState();
}

class _PublishNewJobScreenState extends State<PublishNewJobScreen> {
  final FirebaseApi _firebaseApi = FirebaseApi();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController _resumeController = TextEditingController();
  final TextEditingController _shortDescriptionController =
      TextEditingController();
  final TextEditingController _neighborhoodController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _paymentOfferController = TextEditingController();

  final List<String> _states = [
    'Abierto',
    'En proceso',
    'Cancelado',
    'Completado',
  ];

  late String _selectedState;

  final List<String> _cities = [
    'Bogotá',
    'Medellín',
    'Cali',
    // ... add other Colombian cities
  ];

  late String _selectedCity;

  final List<String> _professions = [
    'Cerrajeros',
    'Pintores',
    'Electricistas',
    'Constructores',
    'Grúas',
    'Jardineros',
    'Limpiadores',
    'Mudanzas',
    'Servicio de comidas',
    'Servicio de internet y televisión',
  ];

  late String _selectedProfession;
  late String _userId;
  DateTime _selectedDateTime = DateTime.now();

  @override
  void initState() {
    _selectedState = _states.first;
    _selectedCity = _cities.first;
    _selectedProfession = _professions.first;
    _getCurrentUser();
    super.initState();
  }

  void _getCurrentUser() async {
    User? user = _auth.currentUser;
    if (user != null) {
      setState(() {
        _userId = user.uid; // Store the user ID
      });
    }
  }

  void _showMessage(String msg) {
    setState(() {
      SnackBar snackBar = SnackBar(content: Text(msg));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: _selectedDateTime,
      firstDate: DateTime.now(), // La fecha es desde hoy
      lastDate: DateTime.now().add(const Duration(
          days: 60)), // La fecha máxima es 60 días desde ahora (2 meses)
    ).then((pickedDate) {
      if (pickedDate == null) return;
      setState(() {
        _selectedDateTime = pickedDate;
      });
    });
  }

  void _presentTimePicker() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_selectedDateTime),
    ).then((pickedTime) {
      if (pickedTime == null) return;
      setState(() {
        _selectedDateTime = DateTime(
          _selectedDateTime.year,
          _selectedDateTime.month,
          _selectedDateTime.day,
          pickedTime.hour,
          pickedTime.minute,
        );
      });
    });
  }

  void _createJobInDB(Job job) async {
    String result = await _firebaseApi.createJobInFirestore(job);

    if (result == 'network-request-failed') {
      _showMessage('Revise su conexión a internet');
    } else {
      _showMessage('Trabajo publicado con éxito');
      Navigator.pop(context); // Regresar a la pantalla anterior
    }
  }

  void _publishNewJob() {
    if (_resumeController.text.isEmpty ||
        _shortDescriptionController.text.isEmpty ||
        _neighborhoodController.text.isEmpty ||
        _addressController.text.isEmpty ||
        _paymentOfferController.text.isEmpty) {
      _showMessage("ERROR: Debe completar todos los campos del formulario");
    } else {
      _firebaseApi.generateJobId().then((jobId) {
        if (jobId != null) {
          Job job = Job(
            jobId: jobId,
            clientId: _userId,
            profession: _selectedProfession,
            state: _selectedState,
            date: _selectedDateTime.toString(),
            paymentOffer: double.parse(_paymentOfferController.text),
            resume: _resumeController.text,
            shortDescription: _shortDescriptionController.text,
            city: _selectedCity,
            neighborhood: _neighborhoodController.text,
            address: _addressController.text,
          );
          _createJobInDB(job);
        } else {
          _showMessage("ERROR: No se pudo generar el ID del trabajo");
        }
      });
    }
  }

  void _onPublishButtonClicked() {
    _publishNewJob();
  }

  @override
  void dispose() {
    // Limpia los controllers cuando se destruye el widget
    _resumeController.dispose();
    _shortDescriptionController.dispose();
    _neighborhoodController.dispose();
    _addressController.dispose();
    _paymentOfferController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log("Accedido a PublishNewJobScreen", level: 200, name: "PublishNewJobScreen.build()");
    return Scaffold(
      appBar: AppBar(title: const Text("Publicar Nuevo Trabajo")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Categoría del trabajo',
                  prefixIcon: Icon(Icons.category),
                ),
                value: _selectedProfession,
                hint: const Text('Selecciona la categoría'),
                items: _professions.map((profession) {
                  return DropdownMenuItem(
                    value: profession,
                    child: Text(profession),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedProfession = value!;
                  });
                },
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Ciudad',
                  prefixIcon: Icon(Icons.check_circle),
                ),
                value: _selectedCity,
                hint: const Text('Selecciona la ciudad'),
                items: _cities.map((city) {
                  return DropdownMenuItem(
                    value: city,
                    child: Text(city),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCity = value!;
                  });
                },
              ),
              const SizedBox(height: 20),
              GlobalTextFormField(
                hintText: 'Resumen del trabajo',
                labelText: 'Resumen del trabajo',
                controller: _resumeController,
                keyboardType: TextInputType.text,
                prefixIcon: const Icon(Icons.description),
              ),
              const SizedBox(height: 20),
              GlobalTextFormField(
                hintText: 'Descripción del trabajo',
                labelText: 'Descripción del trabajo',
                controller: _shortDescriptionController,
                keyboardType: TextInputType.multiline,
                maxLines: 5,
                prefixIcon: const Icon(Icons.details),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Fecha y hora del trabajo:',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  TextButton(
                    onPressed: _presentDatePicker,
                    child: Text(
                      '${_selectedDateTime.day}/${_selectedDateTime.month}/${_selectedDateTime.year}',
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  ),
                  TextButton(
                    onPressed: _presentTimePicker,
                    child: Text(
                      '${_selectedDateTime.hour}:${_selectedDateTime.minute}',
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              GlobalTextFormField(
                hintText: 'Barrio',
                labelText: 'Barrio',
                controller: _neighborhoodController,
                keyboardType: TextInputType.text,
                prefixIcon: const Icon(Icons.location_pin),
              ),
              const SizedBox(height: 20),
              GlobalTextFormField(
                hintText: 'Dirección',
                labelText: 'Dirección',
                controller: _addressController,
                keyboardType: TextInputType.text,
                prefixIcon: const Icon(Icons.home),
              ),
              const SizedBox(height: 20),
              GlobalTextFormField(
                hintText: 'Oferta de pago',
                labelText: 'Oferta de pago',
                controller: _paymentOfferController,
                keyboardType: TextInputType.number,
                prefixIcon: const Icon(Icons.attach_money),
              ),
              const SizedBox(height: 40),
              Center(
                child: FillButtonWidget(
                  text: 'Publicar Trabajo',
                  onPressed: _onPublishButtonClicked,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
