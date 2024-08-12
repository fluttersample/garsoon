import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomRoot {
  static Future? toNamed(String page, {
    dynamic arguments,
    int? id,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
  }) {
    // Get.rootDelegate.toNamed(page,
    //     arguments: arguments,
    //     parameters: parameters);
    return Get.toNamed(page, arguments:
    arguments, id: id,
        preventDuplicates: preventDuplicates,
        parameters: parameters);
  }

  static void back<T>({
    T? result,
    bool closeOverlays = false,
    bool canPop = true,
    int? id,
  }) {
    // Get.rootDelegate.popRoute(result: result,);
    return Get.back(
        result: result, closeOverlays: closeOverlays, canPop: canPop,
        id: id);
  }

  static Future? offAllNamed<T>(String newRouteName, {
    RoutePredicate? predicate,
    dynamic arguments,
    int? id,
    Map<String, String>? parameters,
  }) {
    // Get.rootDelegate.offNamed(newRouteName);
    return Get.offAllNamed(newRouteName, predicate: predicate,
        arguments: arguments,
        id: id,
        parameters: parameters);
  }

  static void offAndToNamed<T>(String newRouteName, {
    RoutePredicate? predicate,
    dynamic arguments,
    int? id,
    Map<String, String>? parameters,
  }) {
    // Get.rootDelegate.offNamed(newRouteName);
    Get.offAndToNamed(newRouteName,
        arguments: arguments,
        id: id,
        parameters: parameters);
  }

  static Future? offNamedUntil<T>(String newRouteName, {
    RoutePredicate? predicate,
    dynamic arguments,
    int? id,
    Map<String, String>? parameters,
  }) {
    // Get.rootDelegate.offNamed(newRouteName);
    return Get.offNamedUntil(newRouteName, (route) => false,
        arguments: arguments,
        id: id,
        parameters: parameters);
  }

  static Future? offNameUtilAndGoToNewRoute(
      {required String firstRoot, required String secondRoot,
        dynamic arguments,
        dynamic argumentsFirstRoot,
        int? id,
        Map<String, String>? parameters,}) async {
    offNamedUntil(firstRoot,arguments: argumentsFirstRoot);
    await Future.delayed(Durations.long1,() {
      toNamed(secondRoot,
      arguments: arguments,
      parameters: parameters,
      id: id);
    },);
  }
}
