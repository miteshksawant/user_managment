import 'package:get/get.dart';
import 'package:user_management/login_screen/login_screen_controller.dart';
import 'package:user_management/user_list_screen/user_list_screen_controller.dart';


class AppInitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginScreenController());
    Get.lazyPut(() => UserListController());
  }
}
