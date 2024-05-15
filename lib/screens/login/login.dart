
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../components/textfield.dart';
import '../../components/button.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.close,
            color: Colors.black,
          ),
          onPressed: () {Navigator.pushNamed(context, '/');},
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFieldComponent(
                text: "email", hide: false, controllerParam: emailController),
            TextFieldComponent(
              text: "password",
              hide: true,
              controllerParam: passwordController,
            ),
            const ButtonComponent(
                text: "Sign in",
                textColor: Colors.white,
                backgroundColor: Colors.red),
            Text.rich(
              TextSpan(
                children: [
                  const TextSpan(text: "New? "),
                  TextSpan(
                      text: "Sign Up!",
                      style: const TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Navigator.pushNamed(context, "/signin"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
