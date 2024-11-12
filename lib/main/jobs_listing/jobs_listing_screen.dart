import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:multiservices_app/model/job.dart';
import 'package:multiservices_app/repository/firebase_api.dart';
import 'package:multiservices_app/main/jobs_listing/job_item_widget.dart';
import 'package:multiservices_app/main/jobs_listing/publish_new_job_screen.dart';

class JobsListingScreen extends StatefulWidget {
  const JobsListingScreen({super.key});

  @override
  State<JobsListingScreen> createState() => _JobsListingScreenState();
}

class _JobsListingScreenState extends State<JobsListingScreen> {
  final FirebaseApi _firebaseApi = FirebaseApi();
  List<Job> _jobs = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadJobs();
  }

  Future<void> _loadJobs() async {
    List<Job> jobs = await _firebaseApi.getJobsFromFirestore();
    if (mounted) {
      setState(() {
        _jobs = jobs;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    log("Accedido a JobsListingScreen",
        level: 200, name: "JobsListingScreen.build()");
    return Scaffold(
      appBar: AppBar(title: const Text("Trabajos Publicados")),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _jobs.isEmpty
              ? const Center(child: Text("No hay trabajos publicados"))
              : ListView.builder(
                  itemCount: _jobs.length,
                  itemBuilder: (context, index) {
                    return JobItemWidget(job: _jobs[index]);
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const PublishNewJobScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
