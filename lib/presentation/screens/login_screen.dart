import 'package:flutter/material.dart';
import 'package:todo_app/services/auth_service.dart';

import '../screens/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailField = TextEditingController();
  final passwordField = TextEditingController();
  bool isObscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(15.0),
          child: AutofillGroup(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  autofillHints: const [AutofillHints.email],
                  controller: emailField,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Email'),
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                ),
                const SizedBox(height: 10.0),
                TextFormField(
                  obscureText: isObscurePassword,
                  autofillHints: const [AutofillHints.password],
                  controller: passwordField,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    label: const Text('Password'),
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isObscurePassword = !isObscurePassword;
                        });
                      },
                      icon: Icon(
                        isObscurePassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                ElevatedButton(
                  onPressed: () async {
                    final String message = await AuthService().signIn(
                      email: emailField.text,
                      password: passwordField.text,
                    );

                    if (message == "Success") {
                      emailField.clear();
                      passwordField.clear();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(message),
                        ),
                      );
                    }
                  },
                  child: Text('Login'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegisterScreen(),
                      ),
                    );
                  },
                  child: const Text('New user? Register here'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
