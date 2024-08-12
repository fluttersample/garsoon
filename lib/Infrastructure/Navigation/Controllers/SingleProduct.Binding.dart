import 'package:get/get.dart';
import 'package:waiter/Presentation/Login/Controller/Login.Controller.dart';
import 'package:waiter/Presentation/SingleProduct/Controller/SingleProduct.Controller.dart';
import 'package:waiter/waiter_injection_container.dart';

class SingleProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SingleProductController>(
      () => SingleProductController(),
    );
  }
}
