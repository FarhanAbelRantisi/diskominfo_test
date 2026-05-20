import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:diskominfo_test/services/auth_service.dart';

import 'package:diskominfo_test/screens/auth/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState
    extends State<LoginScreen> {

  final _formKey =
      GlobalKey<FormState>();

  final _emailController =
      TextEditingController();

  final _passwordController =
      TextEditingController();

  final AuthService _authService =
      AuthService();

  bool _isLoading = false;

  bool _obscurePassword = true;

  Future<void> _login() async {

    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {

      await _authService.login(
        email:
            _emailController.text.trim(),
        password:
            _passwordController.text
                .trim(),
      );

    } on FirebaseAuthException
    catch (e) {

      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content:
              Text(e.message ??
                  "Login gagal"),
        ),
      );

    } finally {

      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Center(

        child: Padding(
          padding:
              const EdgeInsets.all(20),

          child: Form(
            key: _formKey,

            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment
                      .center,

              children: [

                const Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(
                    height: 20),

                TextFormField(
                  controller:
                      _emailController,

                  decoration:
                      const InputDecoration(
                    labelText: "Email",
                    border:
                        OutlineInputBorder(),
                  ),

                  validator: (value) {

                    if (value == null ||
                        value.isEmpty) {

                      return "Masukkan email";
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 20),

                TextFormField(
                  controller: _passwordController,

                  obscureText: _obscurePassword,

                  decoration: InputDecoration(
                    labelText: "Password",
                    border:const OutlineInputBorder(),

                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons
                                .visibility_off
                            : Icons
                                .visibility,
                      ),

                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),

                  validator: (value) {

                    if (value == null ||
                        value.isEmpty) {

                      return "Masukkan password";
                    }

                    return null;
                  },
                ),

                const SizedBox(
                    height: 30),

                SizedBox(
                  width: double.infinity,

                  child: ElevatedButton(

                    onPressed: _isLoading ? null
                    : _login,

                    child: _isLoading
                        ? const CircularProgressIndicator()
                        : const Text(
                            "Login",
                          ),
                  ),
                ),

                const SizedBox(
                    height: 20),

                TextButton(

                  onPressed: () {

                    Navigator.push(
                      context,

                      MaterialPageRoute(
                        builder: (_) => const RegisterScreen(),
                      ),
                    );
                  },

                  child: const Text(
                    "Belum punya akun? Register",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}