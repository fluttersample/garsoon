import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waiter/Core/Helper/AppTypography.dart';
import 'package:waiter/Core/Helper/ColorHelper.dart';
import 'package:waiter/Core/Helper/WaiterBasket.dart';
import 'package:waiter/Presentation/CheckOrder/Controller/CheckOrder.Controller.dart';
import 'package:waiter/Presentation/Widgets/AppBars/CustomAppBar.dart';
import 'package:waiter/Presentation/Widgets/Buttons/CustomButton.dart';
import 'package:waiter/Presentation/Widgets/CustomBottomBar.dart';
import 'package:waiter/Presentation/Widgets/CustomDivider.dart';
import 'package:waiter/Presentation/Widgets/LoadingWidget.dart';
import 'package:waiter/Presentation/Widgets/Products/VerticalItemProduct.dart';

class CheckOrderScreen extends GetView<CheckOrderController> {
  const CheckOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: controller,
      builder: (_) {
        return Scaffold(
            bottomSheet: _buildBottom(),
            appBar: const CustomAppBar(
              title: 'بررسی سفارش',
            ),
            body: IgnorePointer(
              ignoring: controller.isLoadingInsert,
              child: _BuildBody(
                controller: controller,
              ),
            ));
      },
    );
  }

  _buildBottom() {
    return CustomBottomBar(
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text.rich(
          TextSpan(
              text: 'شماره میز : ',
              style: AppTypography.s18.copyWith(fontFamily: FontsName.fontBold),
              children: [
                TextSpan(
                    text: controller.tableName.TableCode,
                    style: AppTypography.s18
                        .copyWith(fontFamily: FontsName.fontMed))
              ]),
        ),
        Visibility(
          visible: controller.isLoadingInsert,
            replacement: CustomButton(
              onTap: () {
                controller.insertOrder();

              },
              width: 115,
              text: 'ثبت سفارش',
            ),
            child:  CustomButton(
              onTap: () {

              },
              color: ColorHelper.greyConst.withOpacity(0.3),
              text: 'در حال ثبت سفارش',
              width: 160,
              textStyle: AppTypography.s14.copyWith(
                  fontFamily: FontsName.fontMed
              ),
              child: Container(
                  height: 20,
                  width: 20,
                  margin: const EdgeInsets.only(left: 8),
                  child: const LoadingWidget()),
            ))

      ]),
    );
  }
}

class _BuildBody extends StatelessWidget {
  const _BuildBody({required this.controller});

  final CheckOrderController controller;

  @override
  Widget build(BuildContext context) {
    if (controller.listProducts.isEmpty) {
      return const Center(child: Text('سبد خرید شما خالی است !'));
    }
    return ListView.separated(
      itemCount: controller.listProducts.length,
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15) +
          const EdgeInsets.only(bottom: 70),
      itemBuilder: (context, index) {
        final item =controller.listProducts[index];
        return VerticalItemProduct(
          item: controller.listProducts[index],
          showDescription: true,
          onTapAddOrRemove: (isAdded) {
            if(isAdded){
              WaiterBasket.buyProduct(product: item);
              controller.update();
            }else {
              WaiterBasket.deleteProduct(product: item);
              controller.update();
            }
          },
        );
      },
      separatorBuilder: (context, index) {
        return CustomDivider(
          width: Get.width / 2,
        );
      },
    );
  }
}
