


import 'package:get/get.dart';
import 'package:waiter/Presentation/LoginCustomer/Controller/LoginCustomer.Controller.dart';
import 'package:waiter/waiter_injection_container.dart';

class LoginCustomerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginCustomerController>(
          () => LoginCustomerController(iLoginCustomerUseCase:  sl(),iRegisterPhoneNumberUseCase: sl(), iSignUpCustomerUseCase: sl()),
    );
  }
}
