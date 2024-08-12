import 'package:waiter/Core/Dto/Enums/StorageServiceTables.dart';


abstract class StorageService {
  Future insert({required Map data, required StorageServiceTables storageServiceTables});

  Future deleteByProperty(StorageServiceTables storageServiceTables);

  Future<Map<String,dynamic>?> getByProperty(StorageServiceTables storageServiceTables);
  Future<void> clearHive();

}
