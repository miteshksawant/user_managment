import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_management/user_list_screen/user_list_screen_controller.dart';

class SignUpScreenController extends GetxController {
  final UserListController userListController = Get.put(UserListController());

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();

  RxBool isButtonDisabled = true.obs;
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;

  File? selectedImage;
  String? selectedFile;
  RxList<UserModel> users = <UserModel>[].obs;




  final firebaseApp = Firebase.app();
  final ImagePicker _imagePicker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
  }

  void validateInput() {
    final bool isValid =
        fullNameController.text.isNotEmpty &&
            ageController.text.isNotEmpty &&
            dobController.text.isNotEmpty &&
            mobileController.text.isNotEmpty;

    isButtonDisabled.value = !isValid;
  }

  void pickImage() async {
    // Request gallery permission
    PermissionStatus status = await Permission.storage.status;

    if (status.isGranted) {
      final imagePicker = ImagePicker();
      final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        selectedImage = File(pickedFile.path);
        selectedFile = pickedFile.path ?? "";
        update();
        // Handle the picked image file path: pickedFile.path)
        print("Image Path: ${pickedFile.path}");
      } else {
        // User canceled the image picking
      }

      // final XFile? pickedFile = await _imagePicker.pickImage(source: ImageSource.gallery);
      // if (pickedFile != null) {
      //   selectedImage = File(pickedFile.path);
      //   update(); // Update the UI to reflect the selected image
      // }
    } else {
      // If permission is not granted, request it
      Map<Permission, PermissionStatus> statuses = await [
        Permission.storage,
      ].request();

      if (statuses[Permission.storage] == PermissionStatus.granted) {
        // Permission granted, try picking the image again
        pickImage();
      } else {
        // Permission denied, handle accordingly (e.g., show an error message)
        print('Permission denied for storage');
      }
    }
  }

  void signup() async {
    try {
      // Set loading to true to show a loading indicator
      isLoading.value = true;

      // Perform signup logic here

      // Reset loading state and clear error message on success
      isLoading.value = false;
      errorMessage.value = '';

      // Reset form fields
      fullNameController.clear();
      ageController.clear();
      dobController.clear();
      mobileController.clear();
      selectedImage = null;

      userListController.addUser;

      // Redirect to another page or perform additional actions after signup
    } catch (e) {
      // Handle signup errors
      errorMessage.value = 'Failed to sign up: $e';

      // Reset loading state
      isLoading.value = false;
    }
  }


  Future<void> saveUserData(List<UserModel> listUsers) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      // List<String>? usersData = prefs.getStringList('users');


      List<Map<String,dynamic>> userListMap = listUsers.map((e) => e.toMap()).toList();

      prefs.setString('users',jsonEncode(userListMap));

      // // Convert the JSON string to List<User> if data exists, otherwise create an empty list
      // List<User> usersList = usersData != null
      //     ? usersData.map((userData) => User.fromJson(json.decode(userData))).toList()
      //     : [];
      //
      // // Add the new user data to the list
      // usersList.add(UserModel(
      //   fullName: fullNameController.text,
      //   age: int.parse(ageController.text),
      //   dob: dobController.text,
      //   mobile: mobileController.text, image: '',
      //   // Add other properties as needed
      // ));
      //
      // // Convert the list of users back to a List<String> of JSON strings
      // List updatedUsersData = usersList.map((user) => json.encode(user.toJson())).toList();

      // Save the updated user data to SharedPreferences
      // prefs.setStringList('users', updatedUsersData);

    } catch (e) {
      print('Error saving user data: $e');
    }
  }
}

