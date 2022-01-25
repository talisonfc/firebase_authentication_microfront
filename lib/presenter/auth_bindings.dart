
import 'package:get/instance_manager.dart';
import 'exports.dart';

class AuthBindings extends Bindings {
  @override
  void dependencies() {
    
    Get.lazyPut(() => AuthController());
  }
}