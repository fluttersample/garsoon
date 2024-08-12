import 'package:get/get.dart';
import 'package:waiter/Presentation/Home/Controller/Home.Controller.dart';
import 'package:waiter/waiter_injection_container.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(iGetShopsUseCase: sl()) );
  }
}
