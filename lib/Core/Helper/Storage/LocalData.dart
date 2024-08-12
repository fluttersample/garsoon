

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:waiter/Core/Dto/Enums/StorageKey.dart';
import 'package:waiter/Core/Dto/Models/export_models.dart';
import 'package:waiter/Core/Helper/BaseBrain.dart';
import 'StorageHelper.dart';

class LocalData {

 static List<ProductsModel> get getProductList{
    List<ProductsModel> myList = [];
    if(StorageHelper.readStorage(storageKey: StorageKey.productList) != null) {
      final product = jsonDecode(StorageHelper.readStorage(storageKey: StorageKey.productList));
      for (var element in ( product as List<dynamic>)) {
        myList.add(ProductsModel.fromJson(element));
      }
    }

    return myList;
  }



 static List<ProductsGroupModel> get  getProductGroupList {
   List<ProductsGroupModel> myList = [];
   if(StorageHelper.readStorage(storageKey: StorageKey.productGroupList) != null) {
     final product = jsonDecode(StorageHelper.readStorage(storageKey: StorageKey.productGroupList));
     for (var element in ( product as List<dynamic>)) {
       myList.add(ProductsGroupModel.fromJson(element));
     }
   }

   return myList;
 }


 static SelectShopModel get getSelectedShop {
   var shop = SelectShopModel();
   if(StorageHelper.readStorage(storageKey: StorageKey.selectedShop) != null){
      shop = SelectShopModel.fromJson( StorageHelper.readStorage(storageKey: StorageKey.selectedShop));
   }

   return shop;



 }
 static List<SelectShopModel> get getShopList{
   List<SelectShopModel> myList = [];
   if(StorageHelper.readStorage(storageKey: StorageKey.shopList) != null) {
     final product = jsonDecode(StorageHelper.readStorage(storageKey: StorageKey.shopList));
     for (var element in ( product as List<dynamic>)) {
       myList.add(SelectShopModel.fromJson(element));
     }
   }

   return myList;
 }

 static TablesModel get getSelectedTable {
   var table = TablesModel();
   if(StorageHelper.readStorage(storageKey: StorageKey.tableName) != null){
     table = TablesModel.fromJson( StorageHelper.readStorage(storageKey: StorageKey.tableName));
   }
   return table;

 }

 static VMToken get getToken {
   var table = const VMToken();
   if(StorageHelper.readStorage(storageKey: StorageKey.token) != null){
     table = VMToken.fromJson( StorageHelper.readStorage(storageKey: StorageKey.token));
   }
   return table;
 }
 static List<InsertOrderRequestModel> get getQueueList {
   List<InsertOrderRequestModel> myList = [];
   if(StorageHelper.readStorage(storageKey: StorageKey.queueList) != null) {
     final product = jsonDecode(StorageHelper.readStorage(storageKey: StorageKey.queueList));

     for (var element in (product as List<dynamic>)) {
       myList.add(InsertOrderRequestModel.fromJson(element));
     }

   }
   return myList;
 }

 static DateTime get getDateTimeCallApi {
   DateTime? localDate ;
   if(StorageHelper.readStorage(storageKey: StorageKey.dateTimeCallApi) != null){
     final dateTime = StorageHelper.readStorage(storageKey: StorageKey.dateTimeCallApi)['dateTimeCallApi'] ;
     localDate = DateTime.parse(dateTime);
   }
   return localDate??DateTime.now();
 }

 static String get getBaseUrl {
   String baseUrl = '';
   if(StorageHelper.readStorage(storageKey: StorageKey.baseUrl) != null){
     final dateTime = StorageHelper.readStorage(storageKey: StorageKey.baseUrl)['baseUrl'] ;
     baseUrl = dateTime;
   }
   return baseUrl;
 }



 /// Sets \\\
 // products
 static Future<void> setProduct(List<ProductsModel> data)async{
   return await StorageHelper.writeListInStorage(storageKey: StorageKey.productList,
       data: data);
 }

 static Future<void> setProductGroups(List<ProductsGroupModel> data)async{
  return await StorageHelper.writeListInStorage(storageKey: StorageKey.productGroupList,
       data: data);
 }


 // token
 static Future<void> setToken(VMToken token)async{
 return  await StorageHelper.writeStorage(storageKey: StorageKey.token, data: token.toJson());
 }
 // selectedShop
 static Future<void> setSelectedShop(SelectShopModel selectShopModel)async{
   return await StorageHelper.writeStorage(storageKey: StorageKey.selectedShop,
       data: selectShopModel.toJson());
 }
 // selectedTable
 static Future<void> setSelectedTable(TablesModel tablesModel)async{
  return await StorageHelper.writeStorage(storageKey: StorageKey.tableName,
       data: tablesModel.toJson());
 }


 // queueList
 static Future<void> setQueueList([InsertOrderRequestModel? data])async{
   if(data != null){
   BaseBrain.orderListQueue.add(data);
   }
   return await StorageHelper.writeListInStorage(storageKey: StorageKey.queueList,
       data: BaseBrain.orderListQueue);
 }

 // dateTime
  static Future<void> setDateTimeCallApi()async{
     return await StorageHelper.writeStorage(storageKey: StorageKey.dateTimeCallApi, data: {
       StorageKey.dateTimeCallApi.name : DateTime.now().toString()
     },);
   }


 // shopList
 static Future<void> setShopList(List<SelectShopModel> data)async{
   await StorageHelper.removeStorage(storageKey: StorageKey.shopList);
   return await StorageHelper.writeListInStorage(storageKey: StorageKey.shopList,
       data: data);
 }
 // baseUrl
 static Future<void> setBaseUrl({required String url})async{
   await StorageHelper.removeStorage(storageKey: StorageKey.baseUrl);
   return await StorageHelper.writeStorage(storageKey: StorageKey.baseUrl,
       data: {'baseUrl' : url});
 }


 /// Delete











 static Future<void> checkTimeCallApi() async{
   if(LocalData.checkDataInLocal(StorageKey.dateTimeCallApi)){
     final yesterday = LocalData.getDateTimeCallApi;
     final now = DateTime.now();
     final difference = now.difference(yesterday).inDays;
     debugPrint("Difference $difference");
     if(difference >=1){
       await StorageHelper.removeStorage(storageKey: StorageKey.productList);
       await StorageHelper.removeStorage(storageKey: StorageKey.productGroupList);
     }
   }
 }
 static bool checkDataInLocal(StorageKey name){
   if(StorageHelper.readStorage(storageKey: name) != null){
     return true;
   }
   return false;
 }



}