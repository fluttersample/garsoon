

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waiter/Core/Dto/Models/export_models.dart';
import 'package:waiter/Core/Interfaces/UseCasesExport.dart';

class OrdersController extends GetxController with StateMixin<List<OrdersModel>> {

  final IOrdersUseCase _iOrdersUseCase;
  OrdersController({required IOrdersUseCase iOrdersUseCase}) :
  _iOrdersUseCase = iOrdersUseCase;

  List<OrdersModel> listOrders = [];


  @override
  void onReady() {
    startApiGetOrders();
    super.onReady();
  }


//variables
  /// Obx
  final dropdownValue = 0.obs;

  var items = [
    'همه',
    'آماده سازی',
    'تحویل شد',
  ];
  bool isLoading = true;

  void changeSort(int value ){
    if(listOrders.isEmpty){
      return;
    }
    if(value == 0){
      change(listOrders,status: RxStatus.success());
      return;
    }
    final sortList = listOrders.where((e) => e.IsStatus == value).toList();

    change(sortList,status: RxStatus.success());
  }




  /// apis
  void startApiGetOrders() async {
    change([],status: RxStatus.loading());

    await _iOrdersUseCase.handler(params: OrdersRequestModel(
      skip: 0,take: 100
    )).then((value) {
      value.fold((l) {

      }, (result) {
        listOrders = result;
        change(result,status: RxStatus.success());
        if(listOrders.isEmpty){
          change([],status: RxStatus.empty());
        }
      });
      isLoading = false;
    }).catchError((e){
      isLoading = false;
      change([],status: RxStatus.error());


    });

    // update();

  }

}