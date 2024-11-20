import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:multiservices_app/model/job.dart';
import 'package:intl/intl.dart';
import 'package:multiservices_app/model/user.dart';
import 'package:multiservices_app/repository/firebase_api.dart';

class JobDetailScreen extends StatelessWidget {
  final Job job;

  const JobDetailScreen({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    log("Accedido a JobDetailScreen",
        level: 200, name: "JobDetailScreen.build()");
    final currencyFormat =
        NumberFormat.simpleCurrency(decimalDigits: 0, locale: 'en_US');
    final dateFormat = DateFormat('dd/MM/yyyy');
    FirebaseApi firebaseApi = FirebaseApi();

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: FlexibleSpaceBar(
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              job.resume,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
          centerTitle: true,
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionContainer(
              context,
              title: 'Detalles del Trabajo',
              content: Column(
                children: [
                  _buildJobDetailRow(Icons.work, 'Categoría:', job.profession),
                  _buildJobDetailRow(Icons.location_city, 'Estado:', job.state),
                  _buildJobDetailRow(Icons.calendar_today, 'Fecha:',
                      dateFormat.format(DateTime.parse(job.date))),
                  _buildJobDetailRow(Icons.monetization_on, 'Oferta de pago:',
                      currencyFormat.format(job.paymentOffer)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _buildSectionContainer(
              context,
              title: 'Descripción',
              content: Text(
                job.shortDescription,
                style: TextStyle(color: Colors.grey.shade700),
              ),
            ),
            const SizedBox(height: 20),
            _buildSectionContainer(
              context,
              title: 'Ubicación',
              content: ListTile(
                leading: const Icon(Icons.location_on, color: Colors.redAccent),
                title: Text('${job.city}, ${job.neighborhood}'),
                subtitle: Text(job.address),
                onTap: () {
                  // Handle navigation to map or other location-based action
                },
              ),
            ),
            const SizedBox(height: 20),
            _buildSectionContainer(
              context,
              title: 'Información del Cliente',
              content: FutureBuilder<User?>(
                future: firebaseApi.getUserFromFirestoreById(job.clientId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.hasData) {
                    User? user = snapshot.data;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (user != null) ...[
                          _buildJobDetailRow(
                              Icons.person, 'Nombre:', user.name),
                          _buildJobDetailRow(Icons.location_city, 'Ciudad:',
                              user.city),
                          if (user.phone != null)
                            _buildJobDetailRow(
                                Icons.phone, 'Teléfono:', user.phone!),
                          _buildJobDetailRow(Icons.work, 'Profesión:',
                              user.profession ?? 'N/A'),
                          if (user.imageUrl != null)
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.network(
                                  user.imageUrl!,
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                        ] else ...[
                          const Text('Cliente no encontrado.',
                              style: TextStyle(color: Colors.red)),
                        ]
                      ],
                    );
                  } else {
                    return const Center(
                        child: Text('No se encontraron datos del cliente'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionContainer(BuildContext context,
      {required String title, required Widget content}) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.only(bottom: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
          ),
          const SizedBox(height: 8),
          content,
        ],
      ),
    );
  }

  Widget _buildJobDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.blueAccent, size: 20),
          const SizedBox(width: 8),
          Text(
            '$label ',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
              child:
                  Text(value, style: const TextStyle(color: Colors.black87))),
        ],
      ),
    );
  }
}
