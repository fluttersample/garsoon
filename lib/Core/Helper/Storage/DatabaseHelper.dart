import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:waiter/Core/Interfaces/Storage/StorageService.dart';
import '../../Dto/Enums/StorageServiceTables.dart';



part 'DatabaseHelper.g.dart';


@HiveType(typeId: 0)
class VMDatabase extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? property;

  @HiveField(2)
  String? record;

  @HiveField(3)
  String? value;
}

class DatabaseHelper extends StorageService {
  static var dbBoxName = "waiterBox";

  static final DatabaseHelper _singleton = DatabaseHelper._internal();

  factory DatabaseHelper() {
    return _singleton;
  }

  DatabaseHelper._internal();

  @override
  Future insert({required Map<dynamic, dynamic> data, required StorageServiceTables storageServiceTables}) async {
    var vmDatabase = VMDatabase();
    vmDatabase.property = storageServiceTables.name;
    vmDatabase.record = storageServiceTables.name;
    vmDatabase.value = jsonEncode(data);
    var box = await Hive.openBox<VMDatabase>(dbBoxName);
    box.put(storageServiceTables.name, vmDatabase);
  }

  @override
  Future deleteByProperty(StorageServiceTables storageServiceTables) async {
    var box = await Hive.openBox<VMDatabase>(dbBoxName);
    await box.delete(storageServiceTables.name);
  }

  @override
  Future<Map<String,dynamic>?> getByProperty(StorageServiceTables storageServiceTables) async {
    await Hive.openBox<VMDatabase>(dbBoxName);
    var box = Hive.box<VMDatabase>(dbBoxName);
    var data = box.get(storageServiceTables.name);
    if (data != null) {
      var map = jsonDecode(data.value!);
      return map;
    }
    return null;
  }

  @override
  Future<void> clearHive() async{
    await Hive.openBox<VMDatabase>(dbBoxName);
    var box = Hive.box<VMDatabase>(dbBoxName);
    box.clear();

  }


}
