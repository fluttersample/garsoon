import 'package:get/get.dart';
import 'package:waiter/Presentation/TableCustomer/Controller/TableCustomer.Controller.dart';
import 'package:waiter/waiter_injection_container.dart';

class TableCustomerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TableCustomerController>(
      () => TableCustomerController(iTableCustomerUseCase: sl()),
    );
  }
}
