import 'package:get/get.dart';
import 'package:waiter/Presentation/SearchProduct/Controller/SearchProduct.Controller.dart';
import 'package:waiter/waiter_injection_container.dart';

class SearchProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchProductController>(
          () => SearchProductController(),
    );
  }
}
