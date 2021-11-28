import 'package:flutter/material.dart';

import '../../services/auth_service.dart';

class LogInForm extends StatefulWidget {
  final VoidCallback onTapRegister;

  const LogInForm({Key? key, required this.onTapRegister}) : super(key: key);

  @override
  _LogInFormState createState() => _LogInFormState();
}

class _LogInFormState extends State<LogInForm> {
  final emailField = TextEditingController();
  final passwordField = TextEditingController();
  bool isObscurePassword = true;
  @override
  Widget build(BuildContext context) {
    return AutofillGroup(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            autofillHints: const [
              AutofillHints.username,
              AutofillHints.email,
            ],
            controller: emailField,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              label: Text('Email'),
              prefixIcon: Icon(Icons.email_outlined),
            ),
            textInputAction: TextInputAction.next,
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
                  isObscurePassword ? Icons.visibility : Icons.visibility_off,
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

              if (message != "Success") {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(message),
                  ),
                );
              }
            },
            child: const Text('Login'),
          ),
          TextButton(
            onPressed: widget.onTapRegister,
            child: const Text('New user? Register here'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    emailField.dispose();
    passwordField.dispose();
    super.dispose();
  }
}
