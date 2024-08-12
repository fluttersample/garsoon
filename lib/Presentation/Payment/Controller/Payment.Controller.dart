

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:waiter/Core/Dto/Models/export_models.dart';
import 'package:waiter/Core/Helper/ArgName.dart';
import 'package:waiter/Core/Helper/BaseBrain.dart';
import 'package:waiter/Core/Helper/Globals/GlobalFunc.dart';
import 'package:waiter/Core/Helper/WaiterBasket.dart';
import 'package:waiter/Core/Interfaces/UseCasesExport.dart';
import 'package:waiter/Infrastructure/Navigation/CustomRoot.dart';
import 'package:waiter/Infrastructure/Navigation/Routes.dart';
import 'package:waiter/Presentation/Widgets/Dialogs/CustomDialogWidget.dart';
import 'package:waiter/Presentation/Widgets/ToastNotification/ShowMessage.dart';
class PaymentController extends GetxController with WidgetsBindingObserver {


  late final String orderId ;


  final IGetOrderInfoCustomerUseCase _iGetOrderInfoCustomerUseCase;
  final ICheckPaymentUseCase _iCheckPaymentUseCase;
  PaymentController({required IGetOrderInfoCustomerUseCase iGetOrderInfoCustomerUseCase,
  required ICheckPaymentUseCase iCheckPaymentUseCase}) :
        _iCheckPaymentUseCase = iCheckPaymentUseCase,
  _iGetOrderInfoCustomerUseCase = iGetOrderInfoCustomerUseCase;

  String trackingCode  = '';
  bool fromDirectLink =false;
  String dateOrder ='';


  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
  }


  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if(state == AppLifecycleState.resumed){
      startApiCheckPayment();
    }
    }
  @override
  void onReady() {
    super.onReady();
    setData();
  }


  /// variables
  // booleans
  bool isLoading = false;
  // strings
  String productSchemaId = '';

  // obx
  final showIconSuffix = false.obs;
  final currentSlider = 0.obs;

  // models

  final listProducts = <ProductsModel>[ProductsModel(Id: '0')].obs;
  VMOrderInfo orderInfo = VMOrderInfo();
  MoneyCalculateModel moneyCalculateModel = const MoneyCalculateModel();


  // obx
  final statusButtonPay = StatusPay.Init.obs;




  /// Methods \\\

  updateLoading({required bool isLoading}) {
    this.isLoading = isLoading;
    update();
  }
  void setData(){

    GlobalFunc.checkParameter(argName: ArgName.fromDirectLink, result: (value) {
      fromDirectLink = value.contains('true')?true : false;
    },);
    GlobalFunc.checkParameter(argName: ArgName.trackingCode, result: (value) {
      trackingCode = value;
    },);
    GlobalFunc.checkParameter(argName: ArgName.dateOrder, result: (value) {
      dateOrder = value;
    },);
    GlobalFunc.checkParameter(argName: ArgName.orderId,result: (value) {
      orderId = value;
    },);
    if(fromDirectLink){
      startApiGetOrderInfoCustomer();
    }else {
      _showLocalData();
    }
  }

  void _afterGetOrderInfo(VMOrderInfo result){
    _addDataToListProducts(data: result.Records?.first.ShopProducts??[]);
    orderInfo = result;
    dateOrder = orderInfo.RequestedDateTime??'';
    trackingCode = orderInfo.TrackingCode??'';
    _updateMoneyCal(priceProducts: orderInfo.MoneyCalculation?.TotalAmount ,
        yourBenefit: orderInfo.MoneyCalculation?.YourBenefit);

    if(orderInfo.IsPaid == true){statusButtonPay.value = StatusPay.Paid;}
  }

  void _showLocalData(){
    _addDataToListProducts(data: WaiterBasket.productChoiceOrder);
    _updateMoneyCal(priceProducts: WaiterBasket.calculateCart() , yourBenefit: WaiterBasket.calculateOffCart());
    update();
  }

  void _addDataToListProducts({required List<ProductsModel> data}){
    listProducts.addAll(data);
    listProducts.insert(listProducts.length, ProductsModel(Id: '1'));
  }

  void _updateMoneyCal({int? priceProducts , int? yourBenefit}){
    moneyCalculateModel = MoneyCalculateModel(
      priceProducts: priceProducts,
      yourBenefit: yourBenefit,
    );
  }

  /// Apis ///

  void startApiGetOrderInfoCustomer() async {
    updateLoading(isLoading: true);
    await _iGetOrderInfoCustomerUseCase.handler(params: GetOrderInfoRequestModel(OrderId: orderId)).then((value) {
      value.fold((l) {

      }, (result) {

        _afterGetOrderInfo(result);

      });

      updateLoading(isLoading: false);

    }).catchError((e){

      updateLoading(isLoading: false);

    });

    update();

  }

  void startApiCheckPayment() async {
    /*
     StatusCode == 200 ( pardakht shode )
     StatusCode == 410 ( pardakht nashode )
     */
    statusButtonPay.value = StatusPay.Loading;
    await _iCheckPaymentUseCase.handler(params: CheckPaymentRequestModel(orderId: orderId,
    money: moneyCalculateModel.priceProducts ,
    userName: BaseBrain.token.phoneNumber)).then((value) {
      statusButtonPay.value = StatusPay.Init;
      value.fold((l) {
      }, (result) {
        if(result.StatusCode == 200){
          statusButtonPay.value = StatusPay.Paid;
        }else if (result.StatusCode == 410){
          if(result.Content?.PaymentUrl != null && result.Content!.PaymentUrl!.isNotEmpty){
            final resultPayment = '${result.Content?.PaymentUrl}';
            showDialogPay(resultPayment);
          }else {
            ShowMessage().showToastWithoutCnt(message: 'ناموجودی کیف پول');
          }
        }

      });


    }).catchError((e){
      statusButtonPay.value = StatusPay.Init;

    });

  }


  void showDialogPay(String url){

    showDialog(context: Get.context!,
      builder: (context) {
        return CustomDialogWidget(
            title: 'پرداخت',
            height: 200,
            messageDialog: 'لطفا کیف پول خود را شارژ کنید',
            textCancel: 'بستن',
            textOk: 'پرداخت از طریق درگاه',
            btnOkOnTap: (){
              CustomRoot.back();
              _launchUrl(url);
            }
        );
      },);
  }

  Future<void> _launchUrl(String url) async {
    try{
      if(await canLaunchUrl(Uri.parse(url))){
       await launchUrl(Uri.parse(url),
          mode: LaunchMode.externalApplication,);
      }
    }catch (e){
      print(e);
    }


  }


}

enum StatusPay {
  Init,
  Paid,
  Loading
}