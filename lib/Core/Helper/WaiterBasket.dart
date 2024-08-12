

import 'package:get/get.dart';
import 'package:waiter/Core/Dto/Models/export_models.dart';
import 'dart:developer' as l;
class WaiterBasket {


  static final WaiterBasket _singleton = WaiterBasket._internal();

  factory WaiterBasket() {
    return _singleton;
  }

  WaiterBasket._internal();




  static final productChoiceOrder = <ProductsModel>[].obs;




  static void buyProduct({required ProductsModel product,List<ProductsModel>? tempList}) {
    if (product.Count!.value == 0) {
      product.IsAddToCart!.value = true;
      product.Count!.value++;
      _addProductToLocal(product: product,tempList: tempList);
      return;
    }
    product.Count!.value++;
    _addProductToLocal(product: product,tempList: tempList);

  }

 static void deleteProduct({required ProductsModel product,List<ProductsModel>? tempList}) {
    if (product.Count!.value == 1) {
      product.IsAddToCart?.value = false;
      product.Count!.value = 0;
      _removeProductToLocal(product: product,isFullRemove: true,tempList: tempList);
      return;
    }
    product.Count!.value--;
    _removeProductToLocal(product: product,tempList: tempList);
  }


 static void _addProductToLocal({required ProductsModel product,List<ProductsModel>? tempList}){
    for (var item in tempList??productChoiceOrder) {
      if (item.SchemaId!.toLowerCase() == product.SchemaId!.toLowerCase()) {
        item.Count!.value =product.Count!.value;
        // l.log("PRODUCTS COUNT Added ${tempList != null ? tempList.toString()  : productChoiceOrder.toString()}");
        return ;
      }
    }

    if (product.Count!.value <= 0) {
      product.Count!.value = 1;
    }
    if(tempList != null){
      tempList.add(product);
    }else {
    productChoiceOrder.add(product);
    }

    // l.log("PRODUCTS COUNT Added ${(tempList != null ? tempList.toString()  : productChoiceOrder.toString())}");
  }

 static void _removeProductToLocal({required ProductsModel product, bool isFullRemove =false,List<ProductsModel>? tempList}){

    for (var item in tempList??productChoiceOrder) {
      if (item.SchemaId!.toLowerCase() == product.SchemaId!.toLowerCase()) {
        if(isFullRemove){
          if(tempList != null){
            final index = tempList.indexWhere((element) => element.SchemaId!.toLowerCase() == product.SchemaId!.toLowerCase());
            tempList.removeAt(index);
          }else {
          final index = productChoiceOrder.indexWhere((element) => element.SchemaId!.toLowerCase() == product.SchemaId!.toLowerCase());
          productChoiceOrder.removeAt(index);
          }
          return ;
        }else {
          item.Count!.value =product.Count!.value;
          // l.log("PRODUCTS COUNT Removed ${(tempList != null ? tempList.toString()  : productChoiceOrder.toString())}");
          return ;
        }

      }
    }


  }









  static void checkCallBak(List<ProductsModel> newList) {
    for (var element in newList) {
      if(element.SchemaId != null){
        if (existInCart(element) == true) {
          element.IsAddToCart?.value = true;
          element.Count?.value = getInCart(element)!.Count!.value ?? 0;
        } else {
          element.IsAddToCart?.value = false;
          element.Count?.value = 0;
        }
      }
    }
  }

  static bool existInCart(ProductsModel? productChoice) {
    for (var item in productChoiceOrder) {
      if (item.SchemaId!.toLowerCase() == productChoice!.SchemaId!.toLowerCase()) {
        return true;
      }
    }
    return false;
  }

  static ProductsModel? getInCart(ProductsModel? productChoice) {
    for (var item in productChoiceOrder) {
      if (item.SchemaId!.toLowerCase() == productChoice!.SchemaId!.toLowerCase()) {
        return item;
      }
    }
    return null;
  }



  static int  calculateCart({List<ProductsModel>? tempList}) {
    var total = 0;
    for (var item in tempList ?? productChoiceOrder) {
      if (item.OffPrice != null && item.OffPrice! > 0) {
        total = total + ((item.Price! - (item.OffPrice ?? 0)) * item.Count!.value);
      } else {
        total = total + (item.Price! * item.Count!.value);
      }
    }
    return total;
  }

  static int  calculateOffCart({List<ProductsModel>? tempList}) {
    var total = 0;
    for (var item in  tempList ??productChoiceOrder) {
      if (item.OffPrice != null && item.OffPrice! > 0) {
        total = total + (item.OffPrice! * item.Count!.value);
      }
    }
    return total;
  }

  static int calculatePayable({List<ProductsModel>? tempList}) {
    var total = 0;
    total = calculateCart(tempList: tempList) - calculateOffCart(tempList: tempList);
    return total;
  }

  static clean() {
    for (var element in productChoiceOrder) {
      element.IsAddToCart?.value = false;
      element.Count?.value = 0;
    }
    productChoiceOrder.clear();
  }


}