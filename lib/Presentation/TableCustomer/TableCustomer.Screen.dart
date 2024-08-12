
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waiter/Core/Dto/Enums/StorageKey.dart';
import 'package:waiter/Core/Dto/Models/Responses/Tables/TablesModel.dart';
import 'package:waiter/Core/Helper/AppTypography.dart';
import 'package:waiter/Core/Helper/ColorHelper.dart';
import 'package:waiter/Core/Helper/Storage/LocalData.dart';
import 'package:waiter/Core/Helper/Storage/StorageHelper.dart';
import 'package:waiter/Infrastructure/Navigation/CustomRoot.dart';
import 'package:waiter/Infrastructure/Navigation/Routes.dart';
import 'package:waiter/Presentation/Widgets/Buttons/CustomButton.dart';
import 'package:waiter/Presentation/Widgets/AppBars/CustomAppBar.dart';
import 'package:waiter/Presentation/Widgets/CustomDivider.dart';
import 'package:waiter/Presentation/Widgets/Dialogs/CustomDialogWidget.dart';
import 'package:waiter/Presentation/Widgets/LoadingWidget.dart';
import 'Controller/TableCustomer.Controller.dart';

class TableCustomerScreen extends GetView<TableCustomerController> {
  const TableCustomerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: controller,
      builder: (_) {
        return SelectionArea(
          child: Scaffold(
            appBar: const CustomAppBar(withDivider: false),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [_buildTopPart(), _buildBottomPart(context)],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTopPart() {
    return Column(
      children: [
        SizedBox(
          height: 247,
          width: 200,
          child: Image.asset('assets/images/img_table_customer.png'),
        ),
        const SizedBox(
          height: 30,
        ),
        Text(
          'تعیین شماره میز',
          style: AppTypography.s18.copyWith(fontFamily: FontsName.fontBold),
        )
      ],
    );
  }

  Widget _buildBottomPart(BuildContext context) {
    return Column(
      children: [
        Obx(
          () => IgnorePointer(
            ignoring: controller.isLoading.value,
            child: InkWell(
              borderRadius: BorderRadius.circular(15),
              onTap: () {
                showDialog(
                  context: Get.context!,
                  builder: (context) {
                    return CustomDialogWidget(
                      title: 'انتخاب میز',
                      child: controller.listTables.isEmpty? const Center(
                        child: Text("دیتا وجود ندارد !"),
                      ): ListView.separated(
                        itemCount: controller.listTables.length,
                        itemBuilder: (context, index) {
                          final item = controller.listTables[index];
                          return Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Center(
                                child: TextButton(
                              style: TextButton.styleFrom(
                                  fixedSize: Size.fromWidth(Get.width),
                                  foregroundColor: context.theme.appColors.text,
                                  textStyle: AppTypography.s18.copyWith(
                                    fontFamily: FontsName.fontMed,
                                  )),
                              child: Text(
                                item.TableCode ?? '',
                                style: AppTypography.s18.copyWith(
                                  fontFamily: FontsName.fontMed,
                                  color: context.theme.appColors.text
                                ),
                              ),
                              onPressed: () {
                                controller.selectedTable.value = item;
                                LocalData.setSelectedTable(item);
                                print(item.toJson());
                                CustomRoot.back(closeOverlays: true);
                              },
                            )),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const CustomDivider(
                            height: 1,
                            width: 170,
                          );
                        },
                      ),
                    );
                  },
                );
              },
              child: Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: context.theme.appColors.textField,
                    border: Border.all(
                      color: ColorHelper.grey,
                    )),
                padding: const EdgeInsets.only(
                    left: 10, top: 10, right: 10, bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(
                      () {
                        if (controller.selectedTable.value.TableCode != null) {
                          return Row(
                            children: [
                              Text('میز انتخاب شده :  ',
                                style: AppTypography.s14.copyWith(
                                  color: ColorHelper.greyText,
                                ),),
                              Text(controller.selectedTable.value.TableCode??'',
                              style: AppTypography.s18
                            .copyWith(color: context.theme.appColors.text,))
                            ],
                          );
                        }
                        return Text('انتخاب میز',
                            style: AppTypography.s18
                                .copyWith(color: ColorHelper.greyText,
                            fontFamily: FontsName.fontReg));
                      },
                    ),
                    Visibility(
                      visible: controller.isLoading.value,
                      child: const SizedBox(
                          height: 30, width: 30, child: LoadingWidget()),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        CustomButton(
          text: 'تایید',
          onTap: () {
            controller.goToProductList();
          },
        ),
        const SizedBox(
          height: 40,
        ),
      ],
    );
  }
}
