import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_management/user_list_screen/user_list_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreenController extends GetxController  {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  RxBool isButtonDisabled = true.obs;
  final String loginStatusKey = 'loginStatus';

  @override
  void onInit() {
    super.onInit();
  }

  void validateInput() {
    final bool isValid = GetUtils.isEmail(emailController.text) &&
        passwordController.text.isNotEmpty;
    isButtonDisabled.value = !isValid;
  }

  void login() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text,
      );
      print('Logged in: ${userCredential.user?.email}');
      _saveLoginStatus(true);
      Get.to(UserListScreen());
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to log in: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> _saveLoginStatus(bool status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(loginStatusKey, status);
  }


  Future<bool> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(loginStatusKey) ?? false;
  }

}