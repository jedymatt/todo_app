import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'presentation/screens/home_screen.dart';
import 'presentation/screens/login_screen.dart';
import 'services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const App());
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  // Create the initialization Future outside of `build`:
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<User?>.value(
          value: AuthService().user,
          initialData: null,
        ),
      ],
      child: MaterialApp(
        home: FutureBuilder(
          // Initialize FlutterFire:
          future: _initialization,
          builder: (context, snapshot) {
            // Check for errors
            if (snapshot.hasError) {
              return const Scaffold(
                body: Center(
                  child: Text('Unknown error has occured'),
                ),
              );
            }

            // Once complete, show your application
            if (snapshot.connectionState == ConnectionState.done) {
              final user = Provider.of<User?>(context);

              return (user != null) ? const HomeScreen() : const LoginScreen();
              // return const Center(
              //   child: Scaffold(
              //     body: Center(
              //       child: Text('Okay'),
              //     ),
              //   ),
              // );
            }

            // Otherwise, show something whilst waiting for initialization to complete
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        ),
      ),
    );
  }
}
