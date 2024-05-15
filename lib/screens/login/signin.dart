import 'package:flutter/material.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () => Navigator.pushNamed(context, "/login"), icon: const Icon(Icons.close)),
      ),
      body: const Text("data"),
    );
  }
}
