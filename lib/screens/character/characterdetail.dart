import 'package:studentdex/Components/bordered_title.dart';
import 'package:studentdex/services/database.dart';
import 'package:studentdex/services/storage.dart';
import 'package:flutter/material.dart';
import 'package:studentdex/Components/character_card.dart';

class CharacterDetails extends StatefulWidget {
  const CharacterDetails({super.key});

  @override
  State<CharacterDetails> createState() => _CharacterDetailsState();
}

class _CharacterDetailsState extends State<CharacterDetails> {
  @override
  Widget build(BuildContext context) {
    final character = ModalRoute.of(context)!.settings.arguments as String;
    final imgPath = StorageService().getIMG(character);
    final characterData = DatabaseService().getCharacterData(character);
    final characterHighSchool =
        DatabaseService().getCharacterHighSchool(character);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.close,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/');
          },
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          FutureBuilder(
            future: imgPath,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return FittedBox(
                  child: Image.network(snapshot.requireData),
                );
              } else {
                return Container();
              }
            },
          ),
          FutureBuilder(
            future: characterData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final List<String> keys = [
                  for (var e in snapshot.data!.entries) e.key
                ];
                final List<dynamic> values = [
                  for (var e in snapshot.data!.entries) e.value
                ];
                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    if (keys[index] != 'picture') {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 0,
                            ),
                            child: BorderedTitle(
                              title: '${keys[index]}: ',
                              titleSize: 60,
                            ),
                          ),
                          Center(
                            child: Text(
                              values[index].toString(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 25,
                              ),
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Container();
                    }
                  },
                );
              } else {
                return Container();
              }
            },
          ),
          const Center(
            child: BorderedTitle(
              title: "Colegio",
              titleSize: 100,
            ),
          ),
          FutureBuilder(
            future: characterHighSchool,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final List<String> relation = [
                  for (var e in snapshot.data!.entries) e.key
                ];
                final List<dynamic> names = [
                  for (var e in snapshot.data!.entries) e.value
                ];
                return GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5,
                    mainAxisExtent: 285,
                  ),
                  shrinkWrap: true,
                  itemCount: snapshot.data?.length,
                  
                  itemBuilder: (context, index) {
                    final picturePath = StorageService().getIMG(names[index]);
                    return FutureBuilder(
                        future: picturePath,
                        builder: (context, snapshot) {
                          return FutureBuilder(
                              future: picturePath,
                              builder: (context, snapshotPath) {
                                if (snapshotPath.hasData) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(context, "/character",
                                          arguments: names[index]);
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Center(
                                          child: BorderedTitle(
                                            title: relation[index],
                                            titleSize: 50,
                                          ),
                                        ),
                                        CharacterCard(
                                          name: names[index],
                                          picRoute: snapshotPath.requireData,
                                        ),
                                      ],
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              });
                        });
                  },
                );
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
    );
  }
}
