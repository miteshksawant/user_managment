import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_management/sign_up_screen/sign_up_screen.dart';
import 'package:user_management/sign_up_screen/sign_up_screen_controller.dart';
import 'package:user_management/user_list_screen/user_list_screen_controller.dart';

class UserListScreen extends StatelessWidget {
  final UserListController userListController = Get.put(UserListController());

  UserListScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.picture_as_pdf),
          ),
        ],
      ),
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
          child: Column(
            children: [
              // User List Widget
              Expanded(
                child: Obx(
                  () => userListController.isLoading.value
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : ListView.builder(
                          itemCount: userListController.users.length,
                          itemBuilder: (context, index) {
                            var user = userListController.users[index];
                            print("user: $user");
                            return GestureDetector(
                              onTap: () {
                                Get.to(SignUpScreen(
                                  isFrom: true,
                                  users: userListController.users[index],
                                ))?.then((value) {
                                  if (value != null && value is UserModel) {
                                    userListController.users[index] = value;
                                    Get.find<SignUpScreenController>()
                                        .saveUserData(userListController.users);
                                  }
                                });
                              },
                              child: Card(
                                color: Colors.white,
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(user.image ?? ""),
                                  ),
                                  title: Text(user.fullName ?? ""),
                                  subtitle: Text(
                                      'Age: ${user.age}, DOB: ${user.dob}, Mobile: ${user.mobile}'),
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ),

              // Add User Button
              ElevatedButton(
                // onPressed: userListController.addUser,
                onPressed: () {
                  Get.dialog(
                    SignUpScreen(), // Assuming SignUpScreen is your form for adding a user
                    barrierDismissible: false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 32.0, vertical: 12.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text('Add User'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
