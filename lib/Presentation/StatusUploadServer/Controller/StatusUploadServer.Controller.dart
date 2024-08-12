

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waiter/Core/Dto/Enums/StorageKey.dart';
import 'package:waiter/Core/Dto/Models/export_models.dart';
import 'package:waiter/Core/Helper/Storage/LocalData.dart';
import 'package:waiter/Core/Helper/Storage/StorageHelper.dart';

class StatusUploadServerController extends GetxController {

  bool isLoading = false;

  late List<InsertOrderRequestModel> listQueue ;

  @override
  void onInit() {
    super.onInit();
    StorageHelper.getStorage.listenKey(StorageKey.queueList.name,
            (value) {
              listQueue = LocalData.getQueueList;
              update();
            });
    listQueue = LocalData.getQueueList;

  }



}