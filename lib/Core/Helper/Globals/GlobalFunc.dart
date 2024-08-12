import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:waiter/Core/Dto/Enums/StorageKey.dart';
import 'package:waiter/Core/Dto/Enums/StorageServiceTables.dart';
import 'package:waiter/Core/Dto/Models/export_models.dart';
import 'package:waiter/Core/Helper/API.dart';
import 'package:waiter/Core/Helper/BaseBrain.dart';
import 'package:waiter/Core/Helper/Extensions.dart';
import 'package:waiter/Core/Helper/Services/BaseDio.dart';
import 'package:waiter/Core/Helper/Storage/LocalData.dart';
import 'package:waiter/Core/Helper/Storage/StorageHelper.dart';
import 'package:waiter/Core/Helper/WaiterBasket.dart';
import 'package:waiter/Infrastructure/Navigation/CustomRoot.dart';
import 'package:waiter/Infrastructure/Navigation/Routes.dart';
import 'package:waiter/waiter_injection_container.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'dart:developer' as l;

class GlobalFunc {
  static final GlobalFunc _singleton = GlobalFunc._internal();

  factory GlobalFunc() {
    return _singleton;
  }

  GlobalFunc._internal();



 static List<ProductsModel> convertVMProductToProductsModel(List<ProductsModel> rawProducts){
    List<ProductsModel> myList =[];
    for (var element in rawProducts) {
      myList.add(ProductsModel(
          LimitCount: element.LimitCount,
          SchemaId: element.SchemaId,
          ShowAddDescription: element.ShowAddDescription,
          Price: element.Price,
          OffPrice: element.OffPrice,
          ProductName: element.ProductName,
          ProductUnitNameString: element.ProductUnitNameString,
          ShopId: element.ShopId,
          Picture: element.Picture,
          ProductId: element.ProductId,
          Quantity: element.Quantity,
          IsAddToCart: element.IsAddToCart,
          Count: element.Count,
          ExpireDate: element.ExpireDate,
          MyOffPrice: element.MyOffPrice,
          ProductChoiceName: element.ProductChoiceName,
          Redirect: element.Redirect,
          ShopName: element.ShopName,
          SupplyTime: element.SupplyTime,
          Pictures: element.Pictures,
          Badge: element.Badge
      ));
    }
    return myList;
  }



  static String convertDate(String? date) {
    if (date.isNullOrEmpty) {
      return '';
    }
    try{
      final tempDate = DateTime.parse(date!);
      final f =Jalali.fromDateTime(tempDate).formatter;
      // print('${f.yyyy}/${f.mm}/${f.dd} ${f.date.hour}:${f.date.minute}');
      final result = '${f.date.hour}:${f.date.minute} ${f.yyyy}/${f.mm}/${f.dd} ';
      return result;
    }catch (e){
      rethrow;
    }

  }

  static void closeKeyboard() {
    FocusScope.of(Get.context!).requestFocus(FocusNode());
  }

  static void initialDio(){
    BaseBrain.dio = BaseDio().dio;
  }

  static String convertPrice(int price){
    return '${'$price'.toPersianDigit().seRagham()} تومان';
  }

  Future<void> appInfo() async {
    try {
      PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
        BaseBrain.appName.value = packageInfo.appName;
        BaseBrain.packageName.value = packageInfo.packageName;
        BaseBrain.appVersion.value = packageInfo.version;
        BaseBrain.appBuildNumber.value = packageInfo.buildNumber;
        BaseBrain.buildSignature.value = packageInfo.buildSignature;
        BaseBrain.installerStore.value = packageInfo.installerStore ?? "";
      });

      if (GetPlatform.isAndroid) {
        BaseBrain.os = "Android";
      } else if (GetPlatform.isIOS) {
        BaseBrain.os = "iOS";
      } else if (GetPlatform.isWindows) {
        BaseBrain.os = "Windows";
      } else if (GetPlatform.isLinux) {
        BaseBrain.os = "Linux";
      } else if (GetPlatform.isMacOS) {
        BaseBrain.os = "MacOS";
      } else if (GetPlatform.isFuchsia) {
        BaseBrain.os = "Fuchsia";
      } else {
        BaseBrain.os = "";
      }

      if (kIsWeb) {
        BaseBrain.platform = "webApp";
      } else {
        if (GetPlatform.isAndroid) {
          BaseBrain.platform = "Android";
          AndroidDeviceInfo androidDeviceInfo = await DeviceInfoPlugin().androidInfo;
          sl.registerSingleton(androidDeviceInfo);
        } else if (GetPlatform.isIOS) {
          BaseBrain.platform = "iOS";
        } else if (GetPlatform.isWindows) {
          BaseBrain.platform = "Windows";
        } else if (GetPlatform.isLinux) {
          BaseBrain.platform = "Linux";
        } else if (GetPlatform.isMacOS) {
          BaseBrain.platform = "MacOS";
        } else if (GetPlatform.isFuchsia) {
          BaseBrain.platform = "Fuchsia";
        }
      }
    } catch (e) {
      print(e);
    }
  }

  static void checkParameter({required String argName , required void Function(String value) result}){
    if(Get.parameters[argName] != null){
      result.call(Get.parameters[argName]??'');
    }
  }

  static void checkArgument<T>({required String argName , required void Function(T value) result}){
    if(Get.arguments != null){
      if(Get.arguments[argName] != null){
        result.call(Get.arguments[argName] as T);
      }
    }
  }




  static bool get isLogin {
    if (!BaseBrain.token.AccessToken.isNullOrEmpty) {
      return true;
    }
    return false;
  }



  static Future<void> updateVmToken({required VMToken account , bool fromGust = false})async{
   if(fromGust){
     LocalData.setToken(account);
     BaseBrain.token = account;
     return;
   }
    if ((account.AccessToken ?? "").isNotEmpty && (account.RefreshToken ?? "").isNotEmpty) {
        VMToken vmToken = VMToken(AccessToken:  account.AccessToken, RefreshToken:  account.RefreshToken,
        isCustomer: account.isCustomer,
        phoneNumber: account.phoneNumber,
        TokenType: account.TokenType);
      LocalData.setToken(vmToken);
      BaseBrain.token = vmToken;

      // await BaseBrain.storageService.insert(data: account.toJson(),
      //     storageServiceTables:  StorageServiceTables.TABLE_USER).then((data) async {
      //   VMToken vmToken = VMToken(AccessToken:  account.AccessToken, RefreshToken:  account.RefreshToken);
      //   await BaseBrain.storageService.insert(data: vmToken.toJson(), storageServiceTables:
      //   StorageServiceTables.TABLE_TOKEN).then((data) async {
      //     BaseBrain.token = vmToken;
      //   });
      // });
    }


  }

  static void changeBaseUrl(int value){
    /// 0 Iran
    /// 1 Local
    if(value == 0){
      BaseBrain.baseDomain = API.baseUrlIran;
      BaseBrain.baseDomainNew = API.baseUrlIranNew;
    }else {
      BaseBrain.baseDomain = API.baseDomainLocal;
      BaseBrain.baseDomainNew = API.baseDomainNewLocal;
    }
  }
  static logout({String root = Routes.Login}) async {
    await StorageHelper.clean();
    BaseBrain.clean();
    GlobalFunc.initialDio();
    CustomRoot.offAllNamed(root);
  }

















}
