import 'package:get/get.dart';
import 'package:waiter/Presentation/ChangeProductOrder/Controller/ChangeProductOrder.Controller.dart';
import 'package:waiter/Presentation/Login/Controller/Login.Controller.dart';
import 'package:waiter/Presentation/PreviewChangeOrder/Controller/PreviewChangeOrder.Controller.dart';
import 'package:waiter/Presentation/ReceiptBasket/Controller/ReceiptBasket.Controller.dart';
import 'package:waiter/waiter_injection_container.dart';

class ChangeProductOrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChangeProductOrderController>(
      () => ChangeProductOrderController(iGetProductsUseCase: sl(), iProductsGroupUseCase: sl()),
    );
  }
}
