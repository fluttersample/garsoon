import 'package:get/get.dart';
import 'package:waiter/Presentation/DeveloperTools/Controller/DeveloperTools.Controller.dart';
import 'package:waiter/Presentation/Login/Controller/Login.Controller.dart';
import 'package:waiter/Presentation/StatusUploadServer/Controller/StatusUploadServer.Controller.dart';

class StatusUploadServerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StatusUploadServerController>(
          () => StatusUploadServerController(),
    );
  }
}
