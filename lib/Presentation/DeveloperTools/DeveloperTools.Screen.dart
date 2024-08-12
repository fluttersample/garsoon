import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';
import 'package:get/get.dart';
import 'package:waiter/Core/Dto/Enums/StorageKey.dart';
import 'package:waiter/Core/Dto/Models/export_models.dart';
import 'package:waiter/Core/Helper/API.dart';
import 'package:waiter/Core/Helper/AppTypography.dart';
import 'package:waiter/Core/Helper/ArgName.dart';
import 'package:waiter/Core/Helper/BaseBrain.dart';
import 'package:waiter/Core/Helper/ColorHelper.dart';
import 'package:waiter/Core/Helper/Globals/GlobalFunc.dart';
import 'package:waiter/Core/Helper/Storage/LocalData.dart';
import 'package:waiter/Core/Helper/Storage/StorageHelper.dart';
import 'package:waiter/Core/Helper/WaiterBasket.dart';
import 'package:waiter/Infrastructure/Navigation/CustomRoot.dart';
import 'package:waiter/Infrastructure/Navigation/Routes.dart';

import 'Controller/DeveloperTools.Controller.dart';

class DeveloperToolsScreen extends GetView<DeveloperToolsController> {
  const DeveloperToolsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Developer'),
      ),
      body: GetBuilder(
        init: controller,
        builder:
        (_) =>  Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  OutlinedButton(onPressed: () async{
                    await StorageHelper.removeStorage(storageKey: StorageKey.productList);
                    await StorageHelper.removeStorage(storageKey: StorageKey.productGroupList);
                    await StorageHelper.removeStorage(storageKey: StorageKey.dateTimeCallApi);
                  }, child: const Text('remove List')),
                  const SizedBox(height: 20,),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: context.theme.appColors.text),
                      borderRadius: BorderRadius.circular(15)
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Wrap(
                          runSpacing: 15,
                          spacing: 10,
                          children: controller.listOrderIds.asMap().entries.map((e) {
                            final item = e.value;
                            return ActionChip(label: Text('نمونه ${e.key+1}'),
                              onPressed: () {
                                controller.routeTextController.text = item;
                              },
                            );
                          }).toList(),
                        ),
                        SizedBox(height: 8,),
                        Row(children: [
                          Expanded(child: SizedBox(
                            height: 45,
                            child: TextField(
                              controller: controller.routeTextController,
                             style: AppTypography.s14,
                            decoration: InputDecoration(
                              hintText: 'وارد کردن orderId',
                              hintStyle: AppTypography.s14.copyWith(
                                  fontFamily: FontsName.fontReg, color: context.theme.appColors.hint),
                              contentPadding: const EdgeInsets.only(right: 10),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: const BorderSide(
                                    color: ColorHelper.borderTextFieldGrey,
                                    width: 1.0,
                                  )),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: const BorderSide(
                                    color: ColorHelper.borderTextFieldGrey,
                                    width: 1.0,
                                  )),
                              disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: const BorderSide(
                                    color: ColorHelper.borderTextFieldGrey,
                                    width: 1.0,
                                  )),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  controller.routeTextController.clear();
                                },
                                icon: Icon(Icons.clear),
                              )

                            ),
                            ),
                          )),

                          // ElevatedButton(onPressed: () {
                          //
                          // }, child: Text("ورود به یک سفارش"))
                        ],),
                        const SizedBox(height: 15,),
                        ElevatedButton(onPressed: () {
                          controller.goToOrder();
                        }, child: const Text("ورود به سفارش"))
                      ],
                    ),
                  ),
                  const SizedBox(height: 20,),

                  DropdownButton<int>(items: const [
                    DropdownMenuItem(child: Text('سرور ایران'),
                        value: 0),
                    DropdownMenuItem(child: Text('سرور لوکال'),
                        value: 1),

                  ],
                    hint: Text(LocalData.getBaseUrl.contains('3soot.ir')? 'سرور ایران' : 'سرور لوکال'),
                    onChanged: (value) async{
                      GlobalFunc.changeBaseUrl(value!);
                      if(value == 0){
                        if(BaseBrain.isCustomer){
                          await controller.logoutCustomer();
                        }else {
                          GlobalFunc.logout();
                        }
                        await LocalData.setBaseUrl(url: API.baseUrlIran);
                      }else {
                        if(BaseBrain.isCustomer){
                          await controller.logoutCustomer();
                        }else {
                          GlobalFunc.logout();
                        }
                        await LocalData.setBaseUrl(url: API.baseDomainLocal);
                      }

                    },),

                  const SizedBox(height: 20,),
                  Obx(() =>  Switch(value: BaseBrain.isDarkTheme.value,
                      onChanged: (value) {
                        controller.changeTheme();
                      },),
                  ),
                  const SizedBox(height: 20,),

                  ElevatedButton(
                    onPressed: () async{
                      await StorageHelper.clean();
                      BaseBrain.clean();
                    },
                    child: const Text(
                      "پاک کردن دیتا",
                      style: TextStyle(
                        fontFamily: "Vazir Reg",
                        package: "package_base",
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),

                  ElevatedButton(
                    onPressed: () async{
                    controller.logoutCustomer();
                    },
                    child: const Text(
                      "ورود مشتری",
                      style: TextStyle(
                        fontFamily: "Vazir Reg",
                        package: "package_base",
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  ElevatedButton(
                    onPressed: () async{
                      GlobalFunc.logout();
                    },
                    child: const Text(
                      "ورود گارسون",
                      style: TextStyle(
                        fontFamily: "Vazir Reg",
                        package: "package_base",
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),

                  ElevatedButton(
                    onPressed: () async{
                      CustomRoot.offNameUtilAndGoToNewRoute(firstRoot: Routes.Home,
                      argumentsFirstRoot: {ArgName.fromUtil : true},
                      secondRoot: Routes.TableCustomer);

                    },
                    child: const Text(
                      "Home",
                      style: TextStyle(
                        fontFamily: "Vazir Reg",
                        package: "package_base",
                      ),
                    ),
                  ),
                  const SizedBox(height: 50,),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}
