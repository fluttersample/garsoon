import 'package:get/get.dart';
import 'package:waiter/Presentation/Login/Controller/Login.Controller.dart';
import 'package:waiter/Presentation/PreviewChangeOrder/Controller/PreviewChangeOrder.Controller.dart';
import 'package:waiter/Presentation/ReceiptBasket/Controller/ReceiptBasket.Controller.dart';
import 'package:waiter/waiter_injection_container.dart';

class PreviewChangeOrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PreviewChangeOrderController>(
      () => PreviewChangeOrderController(getOrderInfoUseCase: sl(), iEditOrderUseCase: sl(), cancelOrderUseCase: sl()),
    );
  }
}
