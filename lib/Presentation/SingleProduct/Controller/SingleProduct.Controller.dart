

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:waiter/Core/Dto/Models/export_models.dart';
import 'package:waiter/Core/Helper/ArgName.dart';
import 'package:waiter/Core/Helper/Globals/GlobalFunc.dart';
import 'package:waiter/Core/Helper/Storage/LocalData.dart';
import 'package:waiter/Core/Helper/WaiterBasket.dart';
import 'package:waiter/Core/Interfaces/UseCases/ISingleProductUseCase.dart';
import 'dart:developer' as l;

class SingleProductController extends GetxController  {





  @override
  void onInit() {
    super.onInit();
    GlobalFunc.checkParameter(argName: ArgName.schemaId, result: (value) {
      productSchemaId = value;
    },);
  }


  @override
  void onReady() {
    super.onReady();
    setDataInit();

  }






  /// variables
  // booleans
  bool isLoading = true;
  // strings
  String productSchemaId = '';

  // obx
  final showIconSuffix = false.obs;
  final currentSlider = 0.obs;

  // models
  final product = ProductsModel().obs;
  List<VMProductOptionValue> gpSelectedOptions = [];
  var vmProductChoice = VMProductChoice().obs;
  final productChoicesList = <VMProductChoice>[].obs;
  final allOption = <VMProductOption>[].obs;
  final availableProductChoices = <VMProductChoice>[].obs;


  /// Methods \\\


  void setDataInit(){
    product.value = LocalData.getProductList.firstWhere((element) => element.SchemaId?.toLowerCase() == productSchemaId.toLowerCase());
    checkedCallBack();
    handleProductChoice();
    isLoading = false;
    update();
  }



  void checkedCallBack(){
    if(WaiterBasket.existInCart(product.value)){
      product.value.Count?.value = WaiterBasket.getInCart(product.value)?.Count?.value ?? 0;
      product.value.IsAddToCart?.value = true;
    }
  }

  void handleProductChoice(){
    List<VMProductChoice>? productChoicesJson = product.value.ProductChoices;
    List<VMProductChoice> productChoices = [];
    allOption.clear();
    if (productChoicesJson != null) {
      for (var shopProductChoice in productChoicesJson) {

        VMProductChoice productChoice = shopProductChoice;
        VMProductChoice mProductChoice = shopProductChoice;
        mProductChoice.ProductName = product.value.ProductName;
        mProductChoice.Picture = product.value.Picture;

        List<VMProductOption> newOptions = [];
        for (VMProductOption newOption in productChoice.Options!) {
          if (allOption.isEmpty) {
            newOption.Items!.add(newOption.Item);
            allOption.add(newOption);

            continue;
          }
          for (VMProductOption oldOption in allOption) {
            if (newOption.SpecificationTypeID == oldOption.SpecificationTypeID) {
              if (oldOption.Items!.isEmpty) {
                oldOption.Items!.add(newOption.Item);
                continue;
              }
              bool found = false;
              for (VMProductOptionValue? mValue in oldOption.Items!) {
                if (mValue!.SpecificationTypeItemID == newOption.Item!.SpecificationTypeItemID) {
                  found = true;
                  break;
                }
              }
              if (!found) oldOption.Items!.add(newOption.Item);
            } else {
              newOptions.add(newOption);
            }
          }
        }
        for (VMProductOption option in newOptions) {
          bool found = false;
          for (VMProductOption mOption in allOption) {
            if (mOption.SpecificationTypeID == option.SpecificationTypeID) {
              found = true;
              break;
            }
          }
          if (!found) {
            option.Items!.add(option.Item);
            allOption.add(option);
          }
        }
        productChoices.add(mProductChoice);
      }
      availableProductChoices.addAll(productChoices);
      productChoicesList.obs.update((val) {
        productChoicesList!.value = productChoices;
      });


      updateProduct(productsModel: product.value);
    }
  }

  updateProduct({required ProductsModel productsModel}) {
    product.value = productsModel;


    if (product.value.ProductChoices != null &&
        product.value.ProductChoices!.isNotEmpty) {
      for (var element in product.value.ProductChoices![0].Options!) {
        selectOption(element.Item!);
      }
    }
  }







  selectOption(VMProductOptionValue itemsOptions) {
    if (itemsOptions.selected! &&
        gpSelectedOptions.contains(itemsOptions)) {
      itemsOptions.selected = false;
      gpSelectedOptions.remove(itemsOptions);
      if (gpSelectedOptions.isEmpty) {
        vmProductChoice.value = product.value.ProductChoices![0];
      }
    } else {
      for (VMProductChoice productChoice in productChoicesList!) {
        bool found = false;
        for (VMProductOption option in productChoice.Options!) {
          if (option.Item!.SpecificationTypeItemID == itemsOptions.SpecificationTypeItemID) {
            for (VMProductOptionValue? mOptionValue in getOptionInList(
                option, allOption!)!.Items!) {
              mOptionValue!.selected = false;
              gpSelectedOptions.remove(mOptionValue);
            }
            itemsOptions.selected = true;
            gpSelectedOptions.add(itemsOptions);
            vmProductChoice.value = productChoice;
            found = true;
            break;
          }
        }
        if (found) break;
      }
    }

    filterProductChoices(gpSelectedOptions);

    List<VMProductOption> listOption = List.empty(growable: true);
    Map<VMProductOption, List<String?>> optionsMap = {};

    for (var productChoice in productChoicesList!) {
      List<String?> map = List.empty(growable: true);

      for (var option in productChoice.Options!) {
        map.add(option.Item!.SpecificationTypeItemID);
      }

      for (var option in productChoice.Options!) {
        optionsMap[option] = map;
        listOption.add(option);
      }
    }

    List<FilterTest> lstFilter = List.empty(growable: true);
    lstFilter.addAll(gpSelectedOptions.map((e) =>
        FilterTest(e.SpecificationTypeItemID, getValueOption(e)!.SpecificationTypeID)));


    for (int i = 0; i < lstFilter.length; i++) {
      listOption = listOption
          .where((option) =>
      optionsMap[option]!.contains(lstFilter[i].selectItem) ||
          option.SpecificationTypeID == lstFilter[i].specificationTypeID)
          .toList();
    }

    List<String?> allSelectedValues = listOption.map((e) =>
    e.Item!.SpecificationTypeItemID).toList();
    List<String?> distinctSelectedValues = List.empty(growable: true);

    for (var item in allSelectedValues) {
      if (distinctSelectedValues
          .where((element) => element == item)
          .isEmpty) distinctSelectedValues.add(item);
    }


    for (VMProductOption option in allOption!) {
      for (VMProductOptionValue? value in option.Items!) {
        value!.enabled = false;
      }
    }


    for (VMProductOption option in listOption) {
      for (VMProductOptionValue? value in getOptionInList(option, allOption)!.Items!) {
        for (var id in distinctSelectedValues) {
          if (id == value?.SpecificationTypeItemID) value?.enabled = true;
        }
      }
    }

    update();
  }

  VMProductOption? getOptionInList(VMProductOption option,
      List<VMProductOption> list) {
    for (VMProductOption mOption in list) {
      if (mOption.SpecificationTypeID == option.SpecificationTypeID) return mOption;
    }
    return null;
  }

  VMProductOption? getValueOption(VMProductOptionValue value) {
    for (VMProductOption option in allOption!) {
      for (VMProductOptionValue? mValue in option.Items!) {
        if (mValue!.SpecificationTypeItemID == value.SpecificationTypeItemID) {
          return option;
        }
      }
    }
    return null;
  }

  void filterProductChoices(List<VMProductOptionValue> selectedOptionsValues) {
    availableProductChoices.clear();
    for (VMProductChoice productChoice in productChoicesList!) {
      int i = selectedOptionsValues.length;
      for (VMProductOption option in productChoice.Options!) {
        for (VMProductOptionValue value in selectedOptionsValues) {
          if (option.Item!.SpecificationTypeItemID == value.SpecificationTypeItemID) {
            if (!availableProductChoices.contains(productChoice)) i--;
          }
        }
      }
      bool containsAllSelectedOptionsValues = i == 0;
      if (containsAllSelectedOptionsValues) {
        availableProductChoices.add(productChoice);
      }
    }
  }





}







class FilterTest {
  String? specificationTypeID;
  String? selectItem;

  FilterTest(this.selectItem, this.specificationTypeID);
}