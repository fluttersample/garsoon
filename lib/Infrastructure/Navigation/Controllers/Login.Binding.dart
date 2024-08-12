import 'package:get/get.dart';
import 'package:waiter/Presentation/Login/Controller/Login.Controller.dart';
import 'package:waiter/waiter_injection_container.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(
      () => LoginController(iLoginUseCase: sl(),forgetPasswordUseCase: sl(),
          confirmUseCase: sl(), changePasswordUseCase: sl()),
    );
  }
}
