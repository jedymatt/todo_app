import 'package:flutter/material.dart';

import '../widgets/log_in_form.dart';
import '../widgets/register_form.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLoginForm = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(15.0),
          child: isLoginForm
              ? LogInForm(
                  onTapRegister: toggleForm,
                )
              : RegisterForm(
                  onTapLogIn: toggleForm,
                ),
        ),
      ),
    );
  }

  void toggleForm() {
    setState(() {
      isLoginForm = !isLoginForm;
    });
  }
}
