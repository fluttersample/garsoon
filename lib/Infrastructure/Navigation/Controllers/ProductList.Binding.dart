import 'package:get/get.dart';
import 'package:waiter/Presentation/ProductList/Controller/ProductList.Controller.dart';
import 'package:waiter/waiter_injection_container.dart';

class ProductListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductListController>(
      () => ProductListController(iGetProductsUseCase: sl(), iProductsGroupUseCase: sl()),
    );
  }
}
