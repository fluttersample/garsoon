import 'package:get/get.dart';
import 'package:waiter/Presentation/ReceiptBasket/Controller/ReceiptBasket.Controller.dart';
import 'package:waiter/waiter_injection_container.dart';

class ReceiptBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReceiptBasketController>(
      () => ReceiptBasketController(),
    );
  }
}
