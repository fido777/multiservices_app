import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Import flutter_svg package
import 'package:multiservices_app/model/job.dart';
import 'package:multiservices_app/repository/firebase_api.dart';
import 'package:multiservices_app/main/jobs_listing/job_item_widget.dart';
import 'package:multiservices_app/main/jobs_listing/publish_new_job_screen.dart';
import 'package:multiservices_app/utils/assets.dart';

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
      appBar: AppBar(
        title: const Text("Trabajos Publicados"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        elevation: 4,
      ),
      body: Column(
        children: [
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _jobs.isEmpty
                    ? Center(
                        child: Text(
                          "No hay trabajos publicados",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        itemCount: _jobs.length,
                        itemBuilder: (context, index) {
                          return JobItemWidget(job: _jobs[index]);
                        },
                      ),
          ),

          // SVG at the bottom of the screen
          Padding(
            padding: const EdgeInsets.only(bottom: 100.0),
            child: SvgPicture.asset(
              Assets.undrawConstructorsImage,
              height: 200,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
      // center the position of the floating button
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const PublishNewJobScreen(),
            ),
          );
        },
        label: const Text("Nuevo Trabajo"),
        icon: const Icon(Icons.add),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
      ),
    );
  }
}
