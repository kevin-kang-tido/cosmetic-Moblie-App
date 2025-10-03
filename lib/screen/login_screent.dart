import 'package:cosmetic/screen/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'main_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isObscureText = true;
  final _key = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> _login(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Login success")),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainScreen()),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Login failed: ${e.code}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final emailWidget = Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: TextFormField(
        controller: emailController,
        decoration: InputDecoration(
          hintText: "Email",
          prefixIcon: const Icon(Icons.account_circle),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
        ),
        validator: (value) =>
        value!.isEmpty ? "Email is required" : null,
      ),
    );

    final passwordWidget = Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: TextFormField(
        controller: passwordController,
        obscureText: _isObscureText,
        decoration: InputDecoration(
          hintText: "Password",
          prefixIcon: const Icon(Icons.lock),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
          suffixIcon: IconButton(
            icon: Icon(_isObscureText ? Icons.visibility : Icons.visibility_off),
            onPressed: () {
              setState(() => _isObscureText = !_isObscureText);
            },
          ),
        ),
        validator: (value) =>
        value!.isEmpty ? "Password is required" : null,
      ),
    );

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Center(
            child: Column(
              children: [
                Expanded(
                  child: Form(
                    key: _key,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/cosmetic_1.png",
                          width: 200,
                          height: 200,
                        ),
                        emailWidget,
                        passwordWidget,
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_key.currentState!.validate()) {
                                _login(emailController.text,
                                    passwordController.text);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.indigoAccent,
                            ),
                            child: const Text("Login",
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RegisterScreen()),
                        );
                      },
                      child: const Text("Register"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
