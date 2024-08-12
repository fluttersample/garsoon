import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:waiter/Core/Dto/Enums/StorageServiceTables.dart';
import 'package:waiter/Core/Dto/Models/Responses/Token/TokenModel.dart';
import 'package:waiter/Core/Dto/Models/export_models.dart';
import 'package:waiter/Core/Interfaces/Storage/StorageService.dart';
import 'package:waiter/Infrastructure/Navigation/CustomRoot.dart';
import 'package:waiter/Infrastructure/Navigation/Routes.dart';

class BaseBrain {
  static late Dio dio;

  static String baseDomain = "";
  static String baseDomainNew = "";
  static VMToken token = const VMToken();
  static SelectShopModel? selectedShop;
  static TablesModel? selectedTable;
  static List<SelectShopModel> getShops = [];
  static List<InsertOrderRequestModel> orderListQueue = [];

  static final isDarkTheme = false.obs;

  // Info
  static Rx<String> appVersion = "".obs;
  static Rx<String> appBuildNumber = "0".obs;
  static Rx<String> appName = "".obs;
  static Rx<String> packageName = "".obs;
  static Rx<String> buildSignature = "".obs;
  static Rx<String> installerStore = "".obs;
  static String platform = "";
  static String version = "";
  static String os = "";

  // static  StorageService storageService;

  static bool get isCustomer {
    if (token.isCustomer == true) {
      return true;
    }
    return false;
  }

  static bool get isGuest {
    if(token.isCustomer == true && token.phoneNumber == 'Guest'){
      return true;
    }
    return false;
  }

  static void clean() {
    token = const VMToken();
    selectedShop = null;
    selectedTable = null;
    getShops.clear();
    orderListQueue.clear();
  }
}
