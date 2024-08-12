


import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waiter/Core/Dto/Enums/StorageKey.dart';
import 'package:waiter/Core/Dto/Enums/StorageServiceTables.dart';
import 'package:waiter/Core/Dto/Models/export_models.dart';
import 'package:waiter/Core/Helper/AppTypography.dart';
import 'package:waiter/Core/Helper/ArgName.dart';
import 'package:waiter/Core/Helper/BaseBrain.dart';
import 'package:waiter/Core/Helper/ColorHelper.dart';
import 'package:waiter/Core/Helper/Globals/GlobalApis.dart';
import 'package:waiter/Core/Helper/Globals/GlobalFunc.dart';
import 'package:waiter/Core/Helper/Storage/LocalData.dart';
import 'package:waiter/Core/Helper/Storage/StorageHelper.dart';
import 'package:waiter/Core/Interfaces/UseCases/IGetShopsUseCase.dart';
import 'package:waiter/Infrastructure/Navigation/CustomRoot.dart';
import 'package:waiter/Presentation/Widgets/CustomDivider.dart';
import 'package:waiter/Presentation/Widgets/Dialogs/CustomDialogWidget.dart';
import 'package:waiter/Presentation/Widgets/ToastNotification/ShowMessage.dart';
class HomeController extends GetxController {

  final IGetShopsUseCase _iGetShopsUseCase;
  HomeController({required IGetShopsUseCase iGetShopsUseCase}) :
  _iGetShopsUseCase = iGetShopsUseCase;

   bool fromUtil = false;
  @override
  void onInit() {
    super.onInit();
    GlobalFunc.checkArgument<bool>(argName: ArgName.fromUtil, result: (value) {
      fromUtil = value;
      isLoading = false;
      getShops = BaseBrain.getShops;
    },);
    _handlerCheckProgressOrders();

  }

  @override
  void onReady() {
    super.onReady();
    if(!fromUtil) {
      startApiGetShops();
    }

  }

  @override
  void onClose() {
    super.onClose();
    _clearTimer();
  }

// variables

  bool isLoading = true;
  List<SelectShopModel> getShops = [];


  /// Methods
  void selectedShop(SelectShopModel item) async{
    if (BaseBrain.selectedShop != null &&
        BaseBrain.selectedShop!.ShopId!.toLowerCase() == item.ShopId!.toLowerCase()) {
      CustomRoot.back();
    } else {
      await updateTableShop(item);
      CustomRoot.back(result: 'selected');

    }
    debugPrint('Shop ID ${item.ShopId}');
  }

  Future<void> updateTableShop(SelectShopModel item)async{
    await StorageHelper.removeStorage(storageKey: StorageKey.productList);
    await StorageHelper.removeStorage(storageKey: StorageKey.productGroupList);
    await StorageHelper.removeStorage(storageKey: StorageKey.queueList);
    LocalData.setSelectedShop(item);
    BaseBrain.selectedShop = item;


  }

  void checkShopIsSelected({required void Function() func})async{
    if(isLoading){
      ShowMessage().showToastWithoutCnt(message: 'لطفا صبر کنید' );
      return;
    }
    if(BaseBrain.selectedShop == null){
      final result =await showDialogSelectShop(isSelected: false);
      if(result != null){
        func.call();
      }
      return;
    }
    func.call();
  }

  Future<String?> showDialogSelectShop({bool isSelected = true}) async{
   final result = await showDialog(
      context: Get.context!,
      builder: (context) {
        return CustomDialogWidget(
            title: isSelected? 'انتخاب رستوران': 'لطفا رستوران خود را انتخاب کنید',
            child: ListView.separated(
              itemCount: getShops.length,
              itemBuilder: (context, index) {
                var item = getShops[index];
                return Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Center(
                      child: TextButton(
                        style: TextButton.styleFrom(
                            fixedSize: Size.fromWidth(Get.width),
                            foregroundColor: context.theme.appColors.text,
                            textStyle: AppTypography.s14.copyWith(
                              fontFamily: FontsName.fontMed,
                            )),
                        child: Text(
                          item.ShopName ?? '',
                        ),
                        onPressed: () {
                          selectedShop(item);
                        },
                      )),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const CustomDivider();
              },
            ));
      },
    );
   return result;
  }

  Timer? timer;
  void _handlerCheckProgressOrders(){
    _clearTimer();
    timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      print("TIME ${timer.tick}");
      GlobalApis().startInsertOrder(fromHandler: true);
    });
  }

  void _clearTimer(){
    timer?.cancel();
    timer = null;
  }


  /// apis
  void startApiGetShops() async {
    await _iGetShopsUseCase.handler().then((value) {
      isLoading = false;
      value.fold((l) {

      }, (result) {
        getShops = result;
        BaseBrain.getShops = result;
        LocalData.setShopList(getShops);
        if(getShops.length == 1){
          updateTableShop(result.first);
        }else {
          checkShopIsSelected(func: () {  });
        }
      });
    }).catchError((e){
      isLoading = false;

    });

    update();

  }




}