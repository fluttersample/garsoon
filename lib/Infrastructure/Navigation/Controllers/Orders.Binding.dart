import 'package:get/get.dart';
import 'package:waiter/Presentation/Home/Controller/Home.Controller.dart';
import 'package:waiter/Presentation/Orders/Controller/OrdersController.dart';
import 'package:waiter/waiter_injection_container.dart';

class OrdersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrdersController>(
      () => OrdersController(iOrdersUseCase: sl()),
    );
  }
}