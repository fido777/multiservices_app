import 'package:flutter/material.dart';
import 'package:multiservices_app/model/job.dart';
import 'package:multiservices_app/main/jobs_listing/job_detail_screen.dart';

class JobItemWidget extends StatelessWidget {
  final Job job;

  const JobItemWidget({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(job.resume),
        subtitle: Text(job.profession),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => JobDetailScreen(job: job),
            ),
          );
        },
      ),
    );
  }
}
