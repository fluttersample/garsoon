import 'package:get/get.dart';
import 'package:waiter/Presentation/Payment/Controller/Payment.Controller.dart';
import 'package:waiter/waiter_injection_container.dart';

class PaymentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentController>(
      () => PaymentController(iGetOrderInfoCustomerUseCase: sl(),iCheckPaymentUseCase: sl()),
    );
  }
}
