


import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:waiter/Core/Dto/Enums/StorageKey.dart';
import 'package:waiter/Core/Dto/Enums/StorageServiceTables.dart';
import 'package:waiter/Core/Dto/Models/Responses/Token/TokenModel.dart';
import 'package:waiter/Core/Dto/Models/export_models.dart';
import 'package:waiter/Core/Helper/BaseBrain.dart';

class StorageHelper {
 static const String _storageName = 'waiterStorage';

 static GetStorage get getStorage =>  GetStorage(_storageName);

 static Future<void> initStorage ()async{
     await GetStorage.init(_storageName);
  }
  static T? readStorage<T>({required StorageKey storageKey}) {
    final box = GetStorage(_storageName);
    return box.read<T>(storageKey.name);
  }
 static Future<void> writeStorage({required StorageKey storageKey, required Map<String,dynamic> data}) async {
   final box = GetStorage(_storageName);
   return await box.write(storageKey.name, data);
 }



 static Future<void> removeStorage({required StorageKey storageKey}) async {
   final box = GetStorage(_storageName);
   return await box.remove(storageKey.name);
 }

 static Future<void> clean() async {
   final box = GetStorage(_storageName);
   return await box.erase();
 }












 static Future<void> writeListInStorage({required StorageKey storageKey,required List data}) async {
   final box = GetStorage(_storageName);
   return await box.write(storageKey.name,jsonEncode(data));
 }








}
