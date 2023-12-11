import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_management/sign_up_screen/sign_up_screen_controller.dart';
import 'package:user_management/user_list_screen/user_list_screen_controller.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key, this.users, this.isFrom}) : super(key: key);

  UserModel? users;
  final bool? isFrom;

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final SignUpScreenController signUpScreenController =
      Get.put(SignUpScreenController());

  final UserListController userListController = Get.put(UserListController());

  @override
  void initState() {
    super.initState();
    print("name: ${widget.users?.fullName ?? ""}");
    if (widget.users != null) {
      signUpScreenController.fullNameController.text =
          widget.users?.fullName ?? "";
      signUpScreenController.ageController.text =
          widget.users?.age.toString() ?? "";
      signUpScreenController.dobController.text = widget.users?.dob ?? "";
      signUpScreenController.mobileController.text = widget.users?.mobile ?? "";
    }
  }

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
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage:
                          signUpScreenController.selectedImage != null
                              ? FileImage(signUpScreenController.selectedImage!)
                              : const AssetImage(
                                      'assets/default_profile_image.jpeg')
                                  as ImageProvider,
                    ),
                    const SizedBox(height: 8.0),
                    ElevatedButton(
                      onPressed: signUpScreenController.pickImage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      child: const Text('Pick Image'),
                    ),
                    const SizedBox(height: 16.0),
                    TextField(
                      controller: signUpScreenController.fullNameController,
                      decoration: const InputDecoration(
                        labelText: 'Full Name',
                        prefixIcon: Icon(Icons.person),
                      ),
                      onChanged: (value) =>
                          signUpScreenController.validateInput(),
                    ),
                    const SizedBox(height: 16.0),
                    TextField(
                      controller: signUpScreenController.ageController,
                      decoration: const InputDecoration(
                        labelText: 'Age',
                        prefixIcon: Icon(Icons.calendar_today),
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) =>
                          signUpScreenController.validateInput(),
                    ),
                    const SizedBox(height: 16.0),
                    TextField(
                      controller: signUpScreenController.dobController,
                      decoration: const InputDecoration(
                        labelText: 'Date of Birth',
                        prefixIcon: Icon(Icons.event),
                      ),
                      keyboardType: TextInputType.datetime,
                      onChanged: (value) =>
                          signUpScreenController.validateInput(),
                    ),
                    const SizedBox(height: 16.0),
                    TextField(
                      controller: signUpScreenController.mobileController,
                      decoration: const InputDecoration(
                        labelText: 'Mobile No.',
                        prefixIcon: Icon(Icons.phone),
                      ),
                      keyboardType: TextInputType.phone,
                      onChanged: (value) =>
                          signUpScreenController.validateInput(),
                    ),
                    const SizedBox(height: 24.0),
                    ElevatedButton(
                      onPressed: () {
                        if (widget.users != null) {
                          widget.users = UserModel(
                            fullName:
                                signUpScreenController.fullNameController.text,
                            age: int.parse(
                                signUpScreenController.ageController.text),
                            dob: signUpScreenController.dobController.text,
                            mobile:
                                signUpScreenController.mobileController.text,
                            image: signUpScreenController.selectedFile,
                          );
                          Get.back(result: widget.users);
                        } else {
                          userListController.users.add(UserModel(
                            fullName:
                                signUpScreenController.fullNameController.text,
                            age: int.parse(
                                signUpScreenController.ageController.text),
                            dob: signUpScreenController.dobController.text,
                            mobile:
                                signUpScreenController.mobileController.text,
                            image: signUpScreenController.selectedFile,
                          ));
                          userListController.users.refresh();
                          signUpScreenController
                              .saveUserData(userListController.users);
                          Get.back();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32.0, vertical: 12.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: Text('Add User'.toUpperCase()),
                    ),
                    const SizedBox(height: 24.0),
                    ElevatedButton(
                      onPressed: () {
                        Get.back();
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32.0, vertical: 12.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: Text('Cancel'.toUpperCase()),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
