import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../services/auth_service.dart';

class RegisterForm extends StatefulWidget {
  final VoidCallback onTapLogIn;

  const RegisterForm({Key? key, required this.onTapLogIn}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final emailField = TextEditingController();
  final confirmPasswordField = TextEditingController();
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
              AutofillHints.email,
              AutofillHints.newUsername,
            ],
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
            autofillHints: const [AutofillHints.newPassword],
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
          TextFormField(
            obscureText: true,
            autofillHints: const [AutofillHints.newPassword],
            controller: confirmPasswordField,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              label: Text('Confirm password'),
              prefixIcon: Icon(Icons.lock),
            ),
            onEditingComplete: () => TextInput.finishAutofillContext(),
          ),
          const SizedBox(height: 10.0),
          ElevatedButton(
            onPressed: () async {
              if (passwordField.text != confirmPasswordField.text) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Password mismatch'),
                  ),
                );
                passwordField.text = '';
                confirmPasswordField.text = '';
              }

              final message = await AuthService().createAccount(
                email: emailField.text,
                password: confirmPasswordField.text,
              );

              if (message != "Success") {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(message),
                  ),
                );
              }
            },
            child: const Text('Register'),
          ),
          TextButton(
            onPressed: widget.onTapLogIn,
            child: const Text('Already have an account? Login here'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    emailField.dispose();
    passwordField.dispose();
    confirmPasswordField.dispose();

    super.dispose();
  }
}
