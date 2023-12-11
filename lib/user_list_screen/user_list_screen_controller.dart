import 'dart:async';
import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserListController extends GetxController {
  RxList<UserModel> users = <UserModel>[].obs;
  RxBool isLoading = false.obs;

  final firebaseApp = Firebase.app();

  @override
  void onInit() async {
    isLoading.value = true;
    await readUserLocal();
    isLoading.value = false;
    // TODO: implement onInit
    super.onInit();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("init data: ${prefs.getString('users')}");
    Timer.periodic(const Duration(minutes: 20), (timer) {
      List<Map<String, dynamic>> userListMap =
          users.map((e) => e.toMap()).toList();
      final rtdb = FirebaseDatabase.instanceFor(
          app: firebaseApp,
          databaseURL:
              'https://user-management-d99e9-default-rtdb.asia-southeast1.firebasedatabase.app/');
      rtdb.ref("/").child('users').push().set(userListMap);
    });
  }

  Future readUserLocal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? localUsers = prefs.getString('users');
    if (localUsers != null) {
      users.value = (jsonDecode(localUsers) as List<dynamic>)
          .map((e) => UserModel().fromJsonData(e))
          .toList();
    }
  }

  void addUser() {
    // Implement logic to add a new user
    UserModel newUser = UserModel(
      fullName: 'New User',
      age: 25,
      dob: '01/01/1998',
      mobile: '1234567890',
      image: 'https://example.com/default_user_image.jpg',
    );
    users.add(newUser);
  }
}

class UserModel {
  final String? fullName;
  final int? age;
  final String? dob;
  final String? mobile;
  final String? image;

  UserModel({
    this.fullName,
    this.age,
    this.dob,
    this.mobile,
    this.image,
  });

  UserModel fromJsonData(Map<String, dynamic> data) {
    return UserModel(
        fullName: data["fullName"],
        age: data["age"],
        dob: data["dob"],
        mobile: data["mobile"],
        image: data["image"]);
  }

  Map<String, dynamic> toMap() {
    return {
      "fullName": fullName,
      "age": age,
      "dob": dob,
      "mobile": mobile,
      "image": image
    };
  }
}
