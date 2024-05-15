import 'package:studentdex/screens/login/signin.dart';
import 'package:flutter/material.dart';
import 'screens/home/homemenu.dart';
import 'package:firebase_core/firebase_core.dart';
import 'services/firebase_options.dart';
import 'screens/login/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'screens/character/characterdetail.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  try {
    await FirebaseAuth.instance.signInAnonymously();
  } on FirebaseAuthException {
    print("Anon auth error.");
  }
  runApp(const Home());
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: <String, WidgetBuilder>{
        '/': (context) {
          return const HomeMenu();
        },
        '/login': (context) {
          return const Login();
        },
        '/signin': (context) {
          return const SignIn();
        },
        '/character': (context) {
          return const CharacterDetails();
        },
      },
    );
  }
}
