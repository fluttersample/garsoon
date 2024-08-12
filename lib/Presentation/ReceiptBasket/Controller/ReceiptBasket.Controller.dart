import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:uuid/v6.dart';
import 'package:uuid/v7.dart';
import 'package:waiter/Core/Dto/Enums/StorageKey.dart';
import 'package:waiter/Core/Dto/Models/export_models.dart';
import 'package:waiter/Core/Helper/ArgName.dart';
import 'package:waiter/Core/Helper/BaseBrain.dart';
import 'package:waiter/Core/Helper/Globals/GlobalApis.dart';
import 'package:waiter/Core/Helper/Globals/GlobalFunc.dart';
import 'package:waiter/Core/Helper/Storage/LocalData.dart';
import 'package:waiter/Core/Helper/WaiterBasket.dart';
import 'package:waiter/Core/Interfaces/UseCases/IInsertOrderUseCase.dart';
import 'package:waiter/Infrastructure/Navigation/CustomRoot.dart';
import 'package:waiter/Infrastructure/Navigation/Routes.dart';

class ReceiptBasketController extends GetxController with GetTickerProviderStateMixin {


   TablesModel tableName = TablesModel();

   /// from Edit
   List<ProductsModel>? tempListProduct;
   String? trackingCode ;
   String? orderId ;
   bool fromIsEdit = false;

  @override
  void onInit() {
    super.onInit();

    setData();

  }


  @override
  void onReady() {
    super.onReady();
  }

  final phoneNumberController = TextEditingController();




  /// methods ///



  void setData(){
    if( LocalData.checkDataInLocal(StorageKey.tableName)){
      tableName = LocalData.getSelectedTable;
    }else {
      if(kDebugMode) {
        tableName = BaseBrain.selectedTable ?? TablesModel();
      }
    }
    GlobalFunc.checkParameter(argName: ArgName.trackingCode, result: (value) {
      trackingCode = value;
    },);
    GlobalFunc.checkParameter(argName: ArgName.orderId, result: (value) {
      orderId = value;
    },);

    GlobalFunc.checkArgument<bool>(argName: ArgName.fromEdit, result: (value) {
      fromIsEdit = value;
    },);

    GlobalFunc.checkArgument<List<ProductsModel>>(argName: ArgName.listProducts, result: (value) {
      tempListProduct = value;
    },);



    update();
  }

  void goToOrderPreview({required String orderId , required String trackingCode , bool isLocalInsert = false ,
    List<ProductsModel>? tempChoiceOrder})async{
    final params = {ArgName.orderId : orderId,
      ArgName.trackingCode : trackingCode};
    params.addIf(isLocalInsert, ArgName.insertFromWaiter, 'true');
     CustomRoot.offNameUtilAndGoToNewRoute(firstRoot: Routes.Home,
         secondRoot: Routes.PreviewChangeOrder,
         parameters: params,
       arguments: tempChoiceOrder != null ? {ArgName.tempChoiceOrder : tempChoiceOrder} : null,
       argumentsFirstRoot: {ArgName.fromUtil : true}
     );

  }

  /// Apis ///


  Future<void> addOrderToQueue({bool showOrder = false}) async {
    if(BaseBrain.isCustomer){
       String dateOrder = '';
      GlobalFunc.checkParameter(argName: ArgName.dateOrder, result: (value) {
        dateOrder = value;
      },);
      CustomRoot.toNamed(Routes.Payment,parameters: {
        ArgName.trackingCode : trackingCode??'',
        ArgName.dateOrder : dateOrder,
        ArgName.orderId : this.orderId??'',
      });
     return;
    }
    if(fromIsEdit){
      if(showOrder){
        goToOrderPreview(orderId: this.orderId! ,trackingCode: trackingCode!);
      }else {
        CustomRoot.offNamedUntil(Routes.Home,arguments: {ArgName.fromUtil : true});
      }
      return;
    }
    final orderId = const UuidV6().generate();
    final trackingCodeWaiter =  const UuidV7().generate();
    final dataRequest =InsertOrderRequestModel(
      PhoneNumber: phoneNumberController.text.isEmpty ? null : phoneNumberController.text.toEnglishDigit(),
      OrderId: orderId,
      TotalAmount: WaiterBasket.calculateCart(),
      TrackingCodeWaiter:trackingCodeWaiter,
      PosPay: 0,
      BonusUsed: 0,
      CashPay: 0,
      TableId: tableName.TableId,
      IsPaymentType : 4,
      CreatedAt : DateTime.now().toIso8601String(),
        Cart: WaiterBasket.productChoiceOrder.map((e) {
          e.ShowAddDescription?.value = false;
          return CartListModel(SchemaId: e.SchemaId, Quantity: e.Count!.value, Price: e.Price, OffPrice: e.OffPrice,
              CustomerDescription: e.textEditingController.text.isEmpty ? null : e.textEditingController.text);
        }).toList()
    );
    LocalData.setQueueList(dataRequest);
    final tempListChoiceOrder = <ProductsModel>[];
    tempListChoiceOrder.addAll(WaiterBasket.productChoiceOrder);
    WaiterBasket.productChoiceOrder.clear();
    GlobalApis().startInsertOrder();
    if(showOrder){
      goToOrderPreview(orderId: orderId ,trackingCode: trackingCodeWaiter,isLocalInsert: true,
      tempChoiceOrder: tempListChoiceOrder);
    }else {
      CustomRoot.offNamedUntil(Routes.Home,arguments: {ArgName.fromUtil : true});
    }




  }



}
