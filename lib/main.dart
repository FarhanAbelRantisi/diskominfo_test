import 'package:diskominfo_test/screens/auth/login_screen.dart';
import 'package:diskominfo_test/screens/navigator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:diskominfo_test/services/provider/auth_provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    ChangeNotifierProvider(
      create: (_) => AuthProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Consumer<AuthProvider>(
        builder: (context, authProvider, _) {
          if (authProvider.isLoggedIn) {
            return const NavigatorScreen();
          }
          return const LoginScreen();
        },
      ),
    );
  }
}