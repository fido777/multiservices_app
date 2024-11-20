import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:multiservices_app/main/home/professionals_list_screen.dart';
import 'package:multiservices_app/utils/assets.dart';
import 'package:multiservices_app/utils/lists.dart' as lists;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profesiones"),
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
        elevation: 2,
      ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: SvgPicture.asset(
              Assets.circlesImage,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.builder(
              itemCount: lists.professions.length,
              itemBuilder: (context, index) {
                final profession = lists.professions[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ProfessionalsListScreen(profession: profession),
                      ),
                    );
                  },
                  child: Card(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                    color: Colors.transparent,
                    elevation: 0,
                    margin: const EdgeInsets.symmetric(vertical: 2.0),
                    child: ListTile(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 16.0),
                      leading: Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          border: Border.all(
                            color: Colors.black,
                            width: 2,
                          ),
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      title: Text(
                        profession,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: Icon(
                        Icons.arrow_right_sharp,
                        color: Theme.of(context).colorScheme.secondary,
                        size: 36,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
