import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:user_management/login_screen/login_screen_controller.dart';
import 'package:user_management/sign_up_screen/sign_up_screen.dart';
import 'package:user_management/user_list_screen/user_list_screen.dart';

class LoginScreen extends StatelessWidget {
  final LoginScreenController loginScreenController = Get.put(LoginScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF4285F4), Color(0xFF34A853)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Card(
            elevation: 8.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  TextField(
                    controller: loginScreenController.emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) => loginScreenController.validateInput(),
                  ),
                  const SizedBox(height: 16.0),
                  TextField(
                    controller: loginScreenController.passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock),
                    ),
                    obscureText: true,
                    onChanged: (value) => loginScreenController.validateInput(),
                  ),
                  const SizedBox(height: 24.0),
                  ElevatedButton(
                    onPressed: loginScreenController.login,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 12.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: const Text('Login'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}