import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:multiservices_app/model/job.dart';
import 'package:multiservices_app/main/jobs_listing/job_detail_screen.dart';

class JobItemWidget extends StatelessWidget {
  final Job job;

  const JobItemWidget({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    // Formatter for date in 'dd/MM' format
    final dateFormat = DateFormat('dd/MM');
    final currencyFormat = NumberFormat.simpleCurrency(decimalDigits: 0, locale: 'en_US');

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => JobDetailScreen(job: job),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Job profession as bold title
              Text(
                job.profession,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 4),

              // Job resume as normal text
              Text(
                job.resume,
                style: TextStyle(
                  color: Colors.grey.shade800,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 12),

              // Row for date and neighborhood, with payment offer below
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Date and neighborhood information
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildIconTextRow(
                        icon: Icons.calendar_today,
                        text: dateFormat.format(DateTime.parse(job.date)),
                      ),
                      const SizedBox(height: 4),
                      _buildIconTextRow(
                        icon: Icons.location_on,
                        text: job.neighborhood,
                      ),
                    ],
                  ),

                  // Payment offer
                  _buildIconTextRow(
                    icon: Icons.attach_money,
                    text: currencyFormat.format(job.paymentOffer),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper widget for icon-text rows
  Widget _buildIconTextRow({required IconData icon, required String text}) {
    return Row(
      children: [
        Icon(icon, color: Colors.blueAccent, size: 18),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            color: Colors.grey.shade700,
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}
