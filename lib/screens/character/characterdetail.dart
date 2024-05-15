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
    final imgPath = StorageService().getIMGfromID(character);
    final characterData = DatabaseService().getCharacterData(character);
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
                    if (keys[index] != 'picture' &&
                        keys[index] != 'highschool') {
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
                    } else if (keys[index] == 'highschool') {
                      final highschool = DatabaseService().getCharacterHighSchool(values[index]);
                      return FutureBuilder(
                        future: highschool,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final picturePath = StorageService().getIMGHighSchool(snapshot.data!['picture']);
                            return FutureBuilder(
                              future: picturePath, 
                              builder: 
                              (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Center(
                                      child: BorderedTitle(
                                        title: "Colegio",
                                        titleSize: 50,
                                      ),
                                    ),
                                    CharacterCard(
                                      name: values[index],
                                      picRoute: snapshot.requireData,
                                    ),
                                  ],
                                  );
                                } else {
                                  return Container();
                                }
                              }
                            );
                          } else {
                            return Container();
                          }
                        }
                      );
                    } else {
                      return Container();
                    }
                  }
                );
              } else {
                return Container();
              }
            }
          ),
        ],
      ),
    );
  }
}
