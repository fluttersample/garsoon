


import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';

class ShowMessage {

  static final ShowMessage _instance = ShowMessage._internal();


  factory ShowMessage () => _instance;

  ShowMessage._internal();



  void showToast({required String message,  MessageType type  =MessageType.INFO, required BuildContext context}){

    toastification.show(
      context: context,
      type: _statusType(type: type),
      style: ToastificationStyle.flat,
      title: _statusTitle(type: type),
      dragToClose: true,
      description: Text(message),
      alignment: Alignment.topLeft,
      autoCloseDuration: const Duration(seconds: 4),
      animationDuration: const Duration(seconds: 1),
      animationBuilder: (
          context,
          animation,
          alignment,
          child,
          ) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: lowModeShadow,
      direction: TextDirection.rtl,
      pauseOnHover: false,
      showProgressBar: false
    );
  }

  void showToastWithoutCnt({required String message,  int status = 200}){
    if(kIsWeb){
      getSnackBar(message: message);
      return;
    }
    Fluttertoast.showToast(
      backgroundColor: status == 410 ? Colors.red:Colors.grey,
        textColor: status == 410 ? Colors.white:Colors.white,
        msg: message);
  }

  ToastificationType _statusType({required MessageType type}){
    switch ( type){
      case MessageType.ERROR:
        return ToastificationType.error;
      case MessageType.INFO:
        return ToastificationType.info;
      case MessageType.SUCCESS:
        return ToastificationType.success;
    }
  }


  Widget _statusTitle({required MessageType type}){
    switch ( type){
      case MessageType.ERROR:
        return Text('خطا');
      case MessageType.INFO:
        return Text('اخطار');
      case MessageType.SUCCESS:
        return Text('موفق');
    }
  }

   getSnackBar({
    String? title,
    required String message,
    MessageType type = MessageType.INFO,
    Color textColor = Colors.white,
    Color backgroundColor = Colors.black,
    SnackPosition? snackPosition = SnackPosition.TOP,
  }) {
    late Icon icon;
    late Color leftBarIndicatorColor;
    switch (type) {
      case MessageType.INFO:
        icon = const Icon(Icons.info_outline, color: Colors.yellow);
        leftBarIndicatorColor = Colors.yellow;
        break;
      case MessageType.ERROR:
        icon = const Icon(Icons.error_outline, color: Colors.red);
        leftBarIndicatorColor = Colors.red;
        break;
      case MessageType.SUCCESS:
        icon = const Icon(Icons.check_circle_outline, color: Colors.green);
        leftBarIndicatorColor = Colors.green;
        break;
    }

    Get.snackbar(
      title ?? "",
      message,
      titleText: Container(),
      colorText: Colors.white,
      backgroundColor: Colors.black.withOpacity(0.7),
      leftBarIndicatorColor: leftBarIndicatorColor,
      margin: const EdgeInsets.all(8.0),
      borderRadius: 0,
      barBlur: 2,
      snackPosition: snackPosition,
      icon: icon,
    );
  }






}

enum MessageType { ERROR, INFO, SUCCESS }
