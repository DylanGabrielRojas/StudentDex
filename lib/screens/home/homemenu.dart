import 'package:studentdex/Components/character_card.dart';
import 'package:studentdex/components/topbar.dart';
import 'package:studentdex/services/database.dart';
import 'package:studentdex/services/storage.dart';
import 'package:flutter/material.dart';

class HomeMenu extends StatefulWidget {
  const HomeMenu({super.key});

  @override
  State<HomeMenu> createState() => _HomeMenuState();
}

class _HomeMenuState extends State<HomeMenu> {
  @override
  Widget build(BuildContext context) {
    final message = ModalRoute.of(context)!.settings.arguments as String?;

    if (message != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
          ),
        );
      });
    }

    final Future<List<dynamic>> names = DatabaseService().getCharacter();

    return FutureBuilder(
      future: names,
      builder: (context, snapshotNames) {
        if (snapshotNames.hasData) {
          final List<dynamic> names = snapshotNames.requireData;
          return Scaffold(
            appBar: const TopBar(),
            body: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 5,
              ),
              itemCount: names.length,
              itemBuilder: (context, index) {
                final picturePath = StorageService().getIMGfromID(names[index]['id']);
                return FutureBuilder(
                  future: picturePath,
                  builder: (context, snapshotPath) {
                    if (snapshotPath.hasData) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            "/character",
                            arguments: names[index]['id'],
                          );
                        },
                        child: CharacterCard(
                          name: names[index]['name'],
                          picRoute: snapshotPath.requireData,
                        ),
                      );
                    } else {
                      return Container();
                    }
                  },
                );
              },
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
