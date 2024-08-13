import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:studentdex/services/storage.dart';
import 'package:studentdex/services/utils.dart';
import 'package:studentdex/services/database.dart';
import 'package:flutter/material.dart';
import '../../components/textfield.dart';
import 'package:image_picker/image_picker.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final aliasController = TextEditingController();
  final annioController = TextEditingController();
  final hobbiesController = TextEditingController();
  final musicController = TextEditingController();
  final sportController = TextEditingController();
  final seriesController = TextEditingController();
  String highschool = '';
  final highschools = DatabaseService().getHighSchools();

  dynamic picture;
  void selectImage() async {
    XFile? img = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      picture = File(img!.path);
    });
  }

  Future<bool> pushData() async {
  try {
    if (picture != null) {
      final character = {
        'name': aliasController.text,
        'annio': annioController.text,
        'hobbies': hobbiesController.text,
        'music': musicController.text,
        'sport': sportController.text,
        'series': seriesController.text,
        'highschool': highschool,
      };

      String id = await DatabaseService().uploadCharacter(character);
      StorageService().uploadIMG(picture!, id);
      return true;
    } else {
      return false;  // Retorna false si no hay imagen
    }
  } catch (e) {
    return false;  // Retorna false en caso de error
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            TextFieldComponent(
                text: "Alias", hide: false, controllerParam: aliasController),
            TextFieldComponent(
              text: "Año de nacimiento",
              hide: false,
              controllerParam: annioController,
            ),
            TextFieldComponent(
                text: "Hobbies",
                hide: false,
                controllerParam: hobbiesController),
            TextFieldComponent(
                text: "Musica Favorita",
                hide: false,
                controllerParam: musicController),
            TextFieldComponent(
                text: "Deporte/Juego Favorito",
                hide: false,
                controllerParam: sportController),
            TextFieldComponent(
                text: "Serie/Pelicula Favorita",
                hide: false,
                controllerParam: seriesController),
            FutureBuilder(
                future: highschools,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                      child: DropdownMenu<String>(
                        onSelected: (String? selectedHighSchool) {
                          setState(() {
                            highschool = selectedHighSchool!;
                          });
                        },
                        dropdownMenuEntries: snapshot.data!.map<DropdownMenuEntry<String>>((highschool) {
                          return DropdownMenuEntry<String>(value: highschool, label: highschool);
                        }).toList(),
                      )
                    );
                  } else {
                    return Container();
                  }
                }),
            Center(
              child: Stack(
                children: [
                  picture != null
                      ? CircleAvatar(
                          radius: 64,
                          backgroundImage: FileImage(picture!),
                        )
                      : const CircleAvatar(
                          radius: 64,
                          backgroundImage:
                              AssetImage('assets/images/avatar.webp'),
                        ),
                  Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                        onPressed: selectImage,
                        icon: const Icon(Icons.add_a_photo_outlined)),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: ElevatedButton(
                onPressed: () async {
                  bool success = await pushData();
                  if (success) {
                    Navigator.pushNamed(
                      context,
                      '/',
                      arguments: 'Información ingresada correctamente',
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Error al ingresar la información'),
                      ),
                    );
                  }
                },
                style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.red),
                ),
                child: const Text(
                  "Ingresar!",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              )
            ),
          ],
        ),
      ),
    );
  }
}
