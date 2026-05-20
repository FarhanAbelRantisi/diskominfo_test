import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:diskominfo_test/services/auth_service.dart';

class RegisterScreen
    extends StatefulWidget {

  const RegisterScreen({
    super.key,
  });


  @override
  State<RegisterScreen>
      createState() {

    return _RegisterScreenState();
  }
}

class _RegisterScreenState
    extends State<RegisterScreen> {

  final _formKey =
      GlobalKey<FormState>();

  final _emailController =
      TextEditingController();

  final _passwordController =
      TextEditingController();

  final AuthService _authService =
      AuthService();

  bool _isLoading = false;

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await _authService.register(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Register berhasil! Silakan login."),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pop(context);

    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message ?? "Register gagal"),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title:
            const Text("Register"),
      ),

      body: Padding(
        padding:
            const EdgeInsets.all(20),

        child: Form(
          key: _formKey,

          child: Column(
            children: [

              TextFormField(
                controller:
                    _emailController,

                decoration:
                    const InputDecoration(
                  labelText: "Email",
                  border:
                      OutlineInputBorder(),
                ),
              ),

              const SizedBox(
                  height: 20),

              TextFormField(
                controller:
                    _passwordController,

                obscureText: true,

                decoration:
                    const InputDecoration(
                  labelText:
                      "Password",

                  border:
                      OutlineInputBorder(),
                ),
              ),

              const SizedBox(
                  height: 30),

              SizedBox(
                width:
                    double.infinity,

                child:
                    ElevatedButton(

                  onPressed:
                      _isLoading
                          ? null
                          : _register,

                  child: _isLoading
                      ? const CircularProgressIndicator()
                      : const Text(
                          "Register",
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}