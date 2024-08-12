

import 'dart:async';

import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:waiter/Core/Dto/Models/export_models.dart';
import 'package:waiter/Core/Helper/BaseBrain.dart';
import 'package:waiter/Core/Helper/Globals/GlobalFunc.dart';
import 'package:waiter/Core/Helper/Storage/LocalData.dart';
import 'package:waiter/Core/Helper/Storage/StorageHelper.dart';
import 'package:waiter/Infrastructure/Navigation/CustomRoot.dart';
import 'package:waiter/Infrastructure/Navigation/Routes.dart';
import 'package:waiter/Presentation/Widgets/ToastNotification/ShowMessage.dart';
class SplashController extends GetxController {


  StreamSubscription<ConnectivityResult>? _connectivitySubscription;
  final Rx<InternetStatus> internetStatus = InternetStatus.Connect.obs;
  @override
  void onReady() {
    super.onReady();
    checkInternet();

  }

  Future<void> redirect() async{
    Future.delayed(const Duration(milliseconds: 1500),() {
      if(GlobalFunc.isLogin){
        if(BaseBrain.isCustomer){
          StorageHelper.clean();
          CustomRoot.offAndToNamed(Routes.LoginCustomer);
        }
        CustomRoot.offAndToNamed(Routes.Home);
      }else {
      CustomRoot.offAndToNamed(Routes.Login);
      }
    },);
  }

  Future<void> initCheckInternet()async{
    final result = await (Connectivity().checkConnectivity());
    _updateConnectionStatus(result);
  }


  Future<void> checkInternet()async{
    initCheckInternet();
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen(_updateConnectionStatus);
  }


  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    if (result != ConnectivityResult.none) {
      print('internet is connected');
      internetStatus.value = InternetStatus.Connect;
      redirect();
    } else if (result == ConnectivityResult.vpn) {
      internetStatus.value = InternetStatus.Vpn;
      ShowMessage().getSnackBar(message: 'برای بهبود عملکرد برنامه لطفا فیلتر شکن خود را خاموش کنید');
      redirect();
    }else {
      await Future.delayed(const Duration(milliseconds: 500),() {
        internetStatus.value = InternetStatus.Disconnect;
      },);

    }
  }

  @override
  void onClose() {
    super.onClose();
    _connectivitySubscription?.cancel();
  }





}
enum InternetStatus {
  Connect ,
  Disconnect ,
  Loading ,
  Vpn
}