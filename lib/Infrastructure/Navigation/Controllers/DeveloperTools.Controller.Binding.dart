import 'package:get/get.dart';
import 'package:waiter/Presentation/DeveloperTools/Controller/DeveloperTools.Controller.dart';

class DeveloperToolsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DeveloperToolsController>(
      () => DeveloperToolsController(),
    );
  }
}
