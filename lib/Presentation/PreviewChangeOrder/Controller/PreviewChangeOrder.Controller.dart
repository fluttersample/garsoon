

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:waiter/Core/Dto/Enums/StorageKey.dart';
import 'package:waiter/Core/Dto/Enums/StorageServiceTables.dart';
import 'package:waiter/Core/Dto/Models/export_models.dart';
import 'package:waiter/Core/Helper/AppTypography.dart';
import 'package:waiter/Core/Helper/ArgName.dart';
import 'package:waiter/Core/Helper/BaseBrain.dart';
import 'package:waiter/Core/Helper/Globals/GlobalFunc.dart';
import 'package:waiter/Core/Helper/Storage/StorageHelper.dart';
import 'package:waiter/Core/Helper/WaiterBasket.dart';
import 'package:waiter/Core/Interfaces/UseCases/ICancelOrderUseCase.dart';
import 'package:waiter/Core/Interfaces/UseCases/IEditOrderUseCase.dart';
import 'package:waiter/Core/Interfaces/UseCases/IGetOrderInfoUseCase.dart';
import 'package:waiter/Core/Interfaces/UseCases/IGetShopsUseCase.dart';
import 'package:waiter/Infrastructure/Navigation/CustomRoot.dart';
import 'package:waiter/Infrastructure/Navigation/Routes.dart';
import 'package:waiter/Presentation/Widgets/CustomDivider.dart';
import 'package:waiter/Presentation/Widgets/Dialogs/CustomDialogWidget.dart';
import 'package:waiter/Presentation/Widgets/ToastNotification/ShowMessage.dart';
class PreviewChangeOrderController extends GetxController {


  late final String orderId ;
  late final String trackingCode ;
  late  bool insertFromWaiter =false;


  final IGetOrderInfoUseCase _getOrderInfoUseCase;
  final IEditOrderUseCase _iEditOrderUseCase;
  final ICancelOrderUseCase _cancelOrderUseCase;
  PreviewChangeOrderController({
    required IGetOrderInfoUseCase getOrderInfoUseCase,
    required ICancelOrderUseCase cancelOrderUseCase,
  required IEditOrderUseCase iEditOrderUseCase}) :
      _iEditOrderUseCase = iEditOrderUseCase,
        _cancelOrderUseCase = cancelOrderUseCase,
      _getOrderInfoUseCase = getOrderInfoUseCase;
  @override
  void onInit() {
    super.onInit();
    setData();
  }

  @override
  void onReady() {
    super.onReady();
    handler();

  }

  /// variables
  // booleans
  bool isLoading = true;
  // strings
  String productSchemaId = '';

  // obx
  final showIconSuffix = false.obs;
  final currentSlider = 0.obs;

  // models
   List<ProductsModel>  listProducts = [];
   VMOrderInfo orderInfo =VMOrderInfo();


  final phoneNumberController = TextEditingController();

  /// Methods

  void setData(){
    GlobalFunc.checkParameter(argName: ArgName.orderId,result: (value) {
      orderId = value;
    },);
    GlobalFunc.checkParameter(argName: ArgName.insertFromWaiter,result: (value) {
      insertFromWaiter = value.contains('true') ? true : false ;
    },);
    GlobalFunc.checkParameter(argName: ArgName.trackingCode,result: (value) {
      if(!insertFromWaiter) {
        trackingCode = value;
      }else {
        trackingCode = '';
      }
    },);
  }
  /// First, it should be checked whether the data should be local or from the server
  void handler(){
    if(insertFromWaiter){
      GlobalFunc.checkArgument<List<ProductsModel>>(argName: ArgName.tempChoiceOrder, result: (value) {
        listProducts = value;
      },);
      checkCountAddedItems();
      isLoading = false;
      update();
    }else {
      startApiGetOrderInfo();

    }
  }

  void checkCountAddedItems(){
    for (var element in listProducts) {
      element.IsAddToCart!.value = true;
    }
  }

  /// apis

  void startApiGetOrderInfo() async {
    await _getOrderInfoUseCase.handler(params: GetOrderInfoRequestModel(OrderId: orderId)).then((value) {
      isLoading = false;
      value.fold((l) {

      }, (result) {
        orderInfo = result;
        listProducts = result.Products??[];
        checkCountAddedItems();
      });
    }).catchError((e){
      isLoading = false;

    });
    update();
  }



  void startApiEditOrder() async {
    final dataInsert = InsertOrderRequestModel(
      OrderId: orderId,
      TotalAmount: WaiterBasket.calculateCart(tempList: listProducts),
      PosPay: 0,
      BonusUsed: 0,
      CashPay: 0,
      IsPaymentType: 4,
      PhoneNumber: phoneNumberController.text.isEmpty ? null : phoneNumberController.text.toEnglishDigit(),
      Cart: listProducts.map((e) {
        e.ShowAddDescription?.value = false;
        return CartListModel(SchemaId: e.SchemaId,
          Quantity: e.Count!.value,
          Price: e.Price,
          CustomerDescription: e.textEditingController.text.isEmpty ? null : e.textEditingController.text,
          OffPrice: e.OffPrice);
      }).toList()
    );
    CustomRoot.toNamed(Routes.Receipt,parameters: {ArgName.trackingCode : trackingCode,
      ArgName.orderId : orderId,},
    arguments: {ArgName.listProducts : listProducts,
    ArgName.fromEdit : true});
    await _iEditOrderUseCase.handler(params: dataInsert).then((value) {
      value.fold((l) {

      }, (result) {

      });
    }).catchError((e){

    });

  }

  void startApiCancelOrder() async {
    CustomRoot.offNamedUntil(Routes.Home,arguments: {ArgName.fromUtil : true});
    await _cancelOrderUseCase.handler(params: InsertOrderRequestModel(OrderId: orderId)).then((value) {
      value.fold((l) {

      }, (result) {

      });
    }).catchError((e){

    });
  }

}