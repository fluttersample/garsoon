
import 'package:flutter/foundation.dart';
import 'package:uuid/v6.dart';
import 'package:uuid/v7.dart';
import 'package:waiter/Core/Dto/Models/export_models.dart';
import 'package:waiter/Core/Helper/BaseBrain.dart';
import 'package:waiter/Core/Helper/Storage/LocalData.dart';
import 'package:waiter/Core/Helper/WaiterBasket.dart';
import 'package:waiter/Core/Interfaces/UseCasesExport.dart';
import 'package:waiter/waiter_injection_container.dart';
import 'dart:developer' as l;
class GlobalApis {

  static final GlobalApis _singleton = GlobalApis._internal();

  factory GlobalApis() {
    return _singleton;
  }

  GlobalApis._internal();


  final IInsertOrderUseCase _iInsertOrderUseCase = sl();


  Future<void> startInsertOrder({bool fromHandler = false}) async {
    if(kDebugMode) {
      await Future.delayed(const Duration(seconds: 20));
    }
    final tempListQueue = LocalData.getQueueList;
    return await Future.forEach(tempListQueue, (InsertOrderRequestModel element) async{
      if(fromHandler) {
        if (element.StatusSend == 1) {
          print("STATUS SEND IS");
          await _useCaseInsertOrder(element: element);
        }
      }else {
        if(element.StatusSend == null || element.StatusSend == 0){
          await _useCaseInsertOrder(element: element);
        }
      }
    });
  }
  Future<void> _useCaseInsertOrder({required InsertOrderRequestModel element})async{
      /// if response is Right ( data removed ) else not remove
      /// because when response is Left data is Changed
    await _iInsertOrderUseCase.handler(params: element).then((value) {
      value.fold((l) {
        BaseBrain.orderListQueue.firstWhere((item) => item == element).StatusSend = 1;
      }, (result) {
        if(element.StatusSend == 1){
          BaseBrain.orderListQueue.remove(element);
        }
      });
      if(element.StatusSend == null || element.StatusSend == 0){
      BaseBrain.orderListQueue.remove(element);
      }
    }).catchError((e){
      print("CATHHHHHHHHHHHHHHHHH");
    });
    LocalData.setQueueList();
  }



}