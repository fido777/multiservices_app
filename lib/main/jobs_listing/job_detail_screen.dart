import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:multiservices_app/model/job.dart';

class JobDetailScreen extends StatelessWidget {
  final Job job;

  const JobDetailScreen({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    log(
        "Accedido a JobDetailScreen",
        level: 200,
        name: "JobDetailScreen.build()");

    return Scaffold(
      appBar: AppBar(title: Text(job.resume)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ID del trabajo: ${job.jobId}'),
            Text('Categoría de profesión: ${job.profession}'),
            Text('Estado: ${job.state}'),
            Text('Fecha: ${job.date}'),
            Text('Oferta de pago: \$${job.paymentOffer}'),
            const SizedBox(height: 20),
            const Text('Descripción:'),
            Text(job.shortDescription),
            const SizedBox(height: 20),
            Text('Ciudad: ${job.city}'),
            Text('Barrio: ${job.neighborhood}'),
            Text('Dirección: ${job.address}'),
            Text('ID del cliente: ${job.clientId}'),
          ],
        ),
      ),
    );
  }
}
