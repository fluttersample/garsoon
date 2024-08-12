

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:waiter/Core/Dto/Enums/StorageKey.dart';
import 'package:waiter/Core/Dto/Models/export_models.dart';
import 'package:waiter/Core/Helper/BaseBrain.dart';
import 'package:waiter/Core/Helper/Globals/GlobalFunc.dart';
import 'package:waiter/Core/Helper/Storage/LocalData.dart';
import 'package:waiter/Core/Helper/Storage/StorageHelper.dart';
import 'package:waiter/Core/Helper/WaiterBasket.dart';
import 'package:waiter/Core/Interfaces/UseCases/IGetProductsUseCase.dart';
import 'package:waiter/Core/Interfaces/UseCases/IProductsGroupUseCase.dart';


class ProductListController extends GetxController {


  final IGetProductsUseCase _iGetProductsUseCase;
  final IProductsGroupUseCase _iProductsGroupUseCase;
  ProductListController({required IGetProductsUseCase iGetProductsUseCase,
  required IProductsGroupUseCase iProductsGroupUseCase}) :
        _iProductsGroupUseCase = iProductsGroupUseCase,
        _iGetProductsUseCase = iGetProductsUseCase;


  @override
  void onReady() {
    super.onReady();
    _initCheckDataAndCallApi();
  }

  // models
  List<ProductsModel> constListProducts = [];
  List<ProductsGroupModel> listGroups = [];
  final selectedGroup = ProductsGroupModel().obs ;
  final listProducts = <ProductsModel>[].obs;

  /// bool
  bool isLoading = true;

  // obx
  final showGroupPanel = false.obs;
  final isLoadingGroup = true.obs;


  final scController = ScrollController();

  /// Methods \\\
  Future<void> _initCheckDataAndCallApi()async{
    if(!BaseBrain.isCustomer) {
     await LocalData.checkTimeCallApi();
    }
    if(!LocalData.checkDataInLocal(StorageKey.productList)){
     await startApiGetProducts();
    }else {
      listProducts.value = LocalData.getProductList;
      constListProducts = LocalData.getProductList;
      isLoading = false;
      update();
    }
    if(!LocalData.checkDataInLocal(StorageKey.productGroupList)){
      await startApiGroups();

    }else {
      listGroups = LocalData.getProductGroupList;
      isLoadingGroup.value = false;

    }
  }




  /// Apis ///

  Future<void> startApiGetProducts() async {
    await _iGetProductsUseCase.handler().then((value) {
      isLoading = false;
      value.fold((l) {

      }, (result) async{
        constListProducts = result;
        listProducts.value = result;
        await LocalData.setProduct(listProducts);
        await LocalData.setDateTimeCallApi();

      });
    }).catchError((e){
      isLoading = false;

    });
    WaiterBasket.checkCallBak(listProducts);

    update();

  }


  Future<void> startApiGroups()async{
    await _iProductsGroupUseCase.handler().then((value) {
      isLoadingGroup.value = false;
      value.fold((l) {

      }, (result) async{
        listGroups = result;
        await LocalData.setProductGroups(listGroups);
      });
    }).catchError((e){
      isLoadingGroup.value = false;

    });

  }



  void selectCategory({required ProductsGroupModel item}){
    print("Group Id ${item.GroupId}");
    if(selectedGroup.value.GroupId == item.GroupId){
      selectedGroup.value=ProductsGroupModel();
      listProducts.value = constListProducts;
      WaiterBasket.checkCallBak(listProducts);
      return;
    }
    selectedGroup.value = item;
    final result = constListProducts.where((element) => element.GroupId?.toLowerCase() == item.GroupId?.toLowerCase()).toList();
      listProducts.value = result;
      WaiterBasket.checkCallBak(listProducts);


  }










}