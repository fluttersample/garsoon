

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:waiter/Core/Dto/Enums/StorageKey.dart';
import 'package:waiter/Core/Dto/Models/export_models.dart';
import 'package:waiter/Core/Helper/ArgName.dart';
import 'package:waiter/Core/Helper/Globals/GlobalFunc.dart';
import 'package:waiter/Core/Helper/Storage/LocalData.dart';
import 'package:waiter/Core/Helper/WaiterBasket.dart';


class SearchProductController extends GetxController  {





  @override
  void onReady() {
    super.onReady();
    setData();
    Future.delayed(Durations.medium2,() {
    focusSearch.requestFocus();
    },);
  }



  // models
  List<ProductsModel> constListProducts = [];
  final listProducts = <ProductsModel>[].obs;

  /// bool

  // obx
  final showIconSuffix = false.obs;


  final focusSearch = FocusNode();


  /// controllers
  final ctnSearch = TextEditingController();


  void setData(){
    if(LocalData.checkDataInLocal(StorageKey.productList)){
      constListProducts =  LocalData.getProductList;
      listProducts.value =  LocalData.getProductList;
    }

  }
  void searchProduct(){
    final text = ctnSearch.text;
    if (text.isEmpty) {
      showIconSuffix.value = false;
    } else {
      if (!showIconSuffix.value) {
        showIconSuffix.value = true;
      }
    }
    if(text.isEmpty){
      listProducts.value = constListProducts;
      WaiterBasket.checkCallBak(listProducts);

      return;
    }
    final result = constListProducts.where((element) => element.ProductName?.toLowerCase().contains(text.toLowerCase())??false).toList();
    listProducts.value = result;
    WaiterBasket.checkCallBak(listProducts);


  }










}