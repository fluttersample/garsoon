import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waiter/Core/Dto/Models/Responses/SelectShop/SelectShopModel.dart';
import 'package:waiter/Core/Helper/ArgName.dart';
import 'package:waiter/Core/Helper/BaseBrain.dart';
import 'package:waiter/Core/Helper/Storage/StorageHelper.dart';

import '../../../Core/Dto/Models/Responses/Tables/TablesModel.dart';
import '../../../Core/Helper/Storage/LocalData.dart';
import '../../../Infrastructure/Navigation/CustomRoot.dart';
import '../../../Infrastructure/Navigation/Routes.dart';


class DeveloperToolsController extends GetxController {
  TextEditingController routeTextController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }


  List<String> listOrderIds =[
    '1eec0234-0745-6c20-bb8d-9d5031a512b6',
    '1eec0179-e349-6110-ae7e-393d5947931e',
    '1eec012f-a27f-6110-87f5-0bf5ade1218c',
  ];


  void changeTheme(){
    Get.changeThemeMode(
      Get.isDarkMode ? ThemeMode.light : ThemeMode.dark,
    );
    BaseBrain.isDarkTheme.value = !BaseBrain.isDarkTheme.value;
  }


  Future<void> logoutCustomer()async{
    BaseBrain.clean();
    await StorageHelper.clean();
    final selectShop = SelectShopModel(IsType: 1,
        ShopId: '23156CE2-F6C6-4094-8303-E6B55390DE32',
        ShopName: 'دارچین');
    final selectTable = TablesModel(
        TableId: 'e99f9b86-bb01-4537-9e9f-65644db0bb19',
        TableCode: '1'
    );
    LocalData.setSelectedShop(selectShop);
    LocalData.setSelectedTable(selectTable);
    BaseBrain.selectedShop =selectShop;
    CustomRoot.offAllNamed( Routes.LoginCustomer);
  }

  void goToOrder(){
    CustomRoot.toNamed(Routes.Payment,
        parameters: {ArgName.orderId : routeTextController.text ,
          ArgName.fromDirectLink : 'true'});
  }


}
