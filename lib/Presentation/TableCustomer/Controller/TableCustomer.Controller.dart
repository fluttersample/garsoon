

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waiter/Core/Dto/Models/export_models.dart';
import 'package:waiter/Core/Interfaces/UseCases/ITableCustomerUseCase.dart';
import 'package:waiter/Infrastructure/Navigation/CustomRoot.dart';
import 'package:waiter/Infrastructure/Navigation/Routes.dart';
import 'package:waiter/Presentation/Home/Controller/Home.Controller.dart';
import 'package:waiter/Presentation/Widgets/ToastNotification/ShowMessage.dart';

class TableCustomerController extends GetxController {

  final ITableCustomerUseCase _tableCustomerUseCase;
  TableCustomerController({required ITableCustomerUseCase iTableCustomerUseCase}) :
        _tableCustomerUseCase = iTableCustomerUseCase;


  @override
  void onReady() {
    super.onReady();
    startApiTableCustomer();
  }

  final isLoading = true.obs;
  final selectedTable = TablesModel().obs;

  List<TablesModel> listTables = [];




  void startApiTableCustomer() async {
    await _tableCustomerUseCase.handler().then((value) {
      isLoading.value = false;
      value.fold((l) {

      }, (result) {
        listTables = result;

      });
    }).catchError((e){
      isLoading.value = false;

    });

  }

  void goToProductList() {
    if(selectedTable.value.TableCode == null){
      ShowMessage().showToastWithoutCnt(message: 'لطفا شماره میز را انتخاب کنید');
      return;
    }
    CustomRoot.toNamed(Routes.ProductList);

  }



}