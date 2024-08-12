

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/v6.dart';
import 'package:uuid/v7.dart';
import 'package:waiter/Core/Dto/Enums/StorageKey.dart';
import 'package:waiter/Core/Dto/Enums/StorageServiceTables.dart';
import 'package:waiter/Core/Dto/Models/export_models.dart';
import 'package:waiter/Core/Helper/AppTypography.dart';
import 'package:waiter/Core/Helper/ArgName.dart';
import 'package:waiter/Core/Helper/BaseBrain.dart';
import 'package:waiter/Core/Helper/Globals/GlobalFunc.dart';
import 'package:waiter/Core/Helper/Storage/LocalData.dart';
import 'package:waiter/Core/Helper/Storage/StorageHelper.dart';
import 'package:waiter/Core/Helper/WaiterBasket.dart';
import 'package:waiter/Core/Interfaces/UseCases/IGetShopsUseCase.dart';
import 'package:waiter/Core/Interfaces/UseCasesExport.dart';
import 'package:waiter/Infrastructure/Navigation/CustomRoot.dart';
import 'package:waiter/Infrastructure/Navigation/Routes.dart';
import 'package:waiter/Presentation/Widgets/CustomDivider.dart';
import 'package:waiter/Presentation/Widgets/Dialogs/CustomDialogWidget.dart';
import 'package:waiter/Presentation/Widgets/ToastNotification/ShowMessage.dart';import 'package:persian_number_utility/persian_number_utility.dart';

class CheckOrderController extends GetxController {

  final IInsertOrderUseCase _iInsertOrderUseCase;
  CheckOrderController({required IInsertOrderUseCase iInsertOrderUseCase}) :
        _iInsertOrderUseCase = iInsertOrderUseCase;

  late TablesModel tableName;
  @override
  void onInit() {
    super.onInit();
    listProducts = WaiterBasket.productChoiceOrder;
    setData();
  }


  /// variables
  // booleans
  bool isLoadingInsert = false;
  // strings
  String productSchemaId = '';

  // obx
  final showIconSuffix = false.obs;
  final currentSlider = 0.obs;

  // models
  late List<ProductsModel>  listProducts;


  /// Methods

  updateLoading(bool isLoading) {
    isLoadingInsert = isLoading;
    update();
  }
  void setData(){
    if( LocalData.checkDataInLocal(StorageKey.tableName)){
    tableName = LocalData.getSelectedTable;
    }else {
      if(kDebugMode) {
        tableName = BaseBrain.selectedTable??TablesModel();
      }
    }
  }

  void insertOrder(){
    if(listProducts.isEmpty){
      ShowMessage().showToastWithoutCnt(message: 'سبد خرید شما خالی است');
      return;
    }
    if(BaseBrain.isCustomer){
      showDialog(context: Get.context!,
          builder: (context) {
            return CustomDialogWidget(
              title: 'ثبت سفارش',
              height: 200,
              messageDialog: 'آیا از ثبت سفارش خود مطمئن هستید ؟',
              btnOkOnTap: (){
                CustomRoot.back();
                startInsertOrder();
              }
            );
          },);

    }else {
      CustomRoot.toNamed(Routes.Receipt)?.then((value) {
        update();
      });
    }
  }

  /// apis


  Future<void> startInsertOrder() async {
    final trackingCode = const UuidV7().generate();
    final orderId =  const UuidV6().generate();
    final dateOrder =  DateTime.now().toIso8601String();
    final dataRequest =InsertOrderRequestModel(
        PhoneNumber: BaseBrain.isGuest ? null :BaseBrain.token.phoneNumber?.toEnglishDigit(),
        OrderId: orderId,
        TotalAmount: WaiterBasket.calculateCart(),
        TrackingCodeWaiter: trackingCode,
        PosPay: 0,
        BonusUsed: 0,
        CashPay: 0,
        TableId:  tableName.TableId,
        IsPaymentType : 4,
        CreatedAt : dateOrder,
        Cart: WaiterBasket.productChoiceOrder.map((e) {
          e.ShowAddDescription?.value = false;
          return CartListModel(SchemaId: e.SchemaId, Quantity: e.Count!.value, Price: e.Price, OffPrice: e.OffPrice,
              CustomerDescription: e.textEditingController.text.isEmpty ? null : e.textEditingController.text);
        }).toList()
    );
    updateLoading(true);
    await _iInsertOrderUseCase.handler(params: dataRequest).then((value) {
      value.fold((l) {
        ShowMessage().showToastWithoutCnt(message: 'خطا، مجدد تلاش کنید');
      }, (result) {
        CustomRoot.offAllNamed(Routes.Receipt,parameters: {
          ArgName.trackingCode : result.SingleData??'',
           ArgName.dateOrder : dateOrder,
          ArgName.orderId : orderId,});

      });
      updateLoading(false);

    }).catchError((e){
      ShowMessage().showToastWithoutCnt(message: 'خطا، مجدد تلاش کنید');
      updateLoading(false);

    });

    update();



  }



}

