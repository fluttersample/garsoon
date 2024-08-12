import 'package:get/get.dart';
import 'package:waiter/Presentation/Splash/Controller/Splash.Controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(
      () => SplashController(),
    );
  }
}
