import 'package:studentdex/Components/character_card.dart';
import 'package:studentdex/components/topbar.dart';
import 'package:studentdex/services/database.dart';
import 'package:studentdex/services/storage.dart';
import 'package:flutter/material.dart';

class HomeMenu extends StatefulWidget {
  const HomeMenu({
    super.key,
  });

  @override
  State<HomeMenu> createState() => _HomeMenuState();
}

class _HomeMenuState extends State<HomeMenu> {
  @override
  Widget build(BuildContext context) {
    final Future<List<String>> names;

    names = DatabaseService().getCharacter();
    return FutureBuilder(
        future: names,
        builder: (context, snapshotNames) {
          if (snapshotNames.hasData) {
            final List<String> names = snapshotNames.requireData;
            return Scaffold(
              appBar: const TopBar(),
              body: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5,
                  ),
                  itemCount: names.length,
                  itemBuilder: (context, index) {
                    final picturePath = StorageService().getIMG(names[index]);
                    return FutureBuilder(
                        future: picturePath,
                        builder: (context, snapshotPath) {
                          if (snapshotPath.hasData) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, "/character",
                                    arguments: names[index]);
                              },
                              child: CharacterCard(
                                name: names[index],
                                picRoute: snapshotPath.requireData,
                              ),
                            );
                          } else {
                            return Container();
                          }
                        });
                  }),
            );
          } else {
            return Container();
          }
        });
  }
}
