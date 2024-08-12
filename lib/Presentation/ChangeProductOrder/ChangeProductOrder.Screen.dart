import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:waiter/Core/Helper/AppTypography.dart';
import 'package:waiter/Core/Helper/ColorHelper.dart';
import 'package:waiter/Core/Helper/Globals/GlobalFunc.dart';
import 'package:waiter/Core/Helper/WaiterBasket.dart';
import 'package:waiter/Infrastructure/Navigation/CustomRoot.dart';
import 'package:waiter/Infrastructure/Navigation/Routes.dart';
import 'package:waiter/Presentation/PreviewChangeOrder/Controller/PreviewChangeOrder.Controller.dart';
import 'package:waiter/Presentation/Widgets/AppBars/CustomAppBar.dart';
import 'package:waiter/Presentation/Widgets/Buttons/CustomButton.dart';
import 'package:waiter/Presentation/Widgets/CustomBottomBar.dart';
import 'package:waiter/Presentation/Widgets/CustomDivider.dart';
import 'package:waiter/Presentation/Widgets/LoadingWidget.dart';
import 'package:waiter/Presentation/Widgets/Products/VerticalItemProduct.dart';
import 'Controller/ChangeProductOrder.Controller.dart';

class ChangeProductOrderScreen extends GetView<ChangeProductOrderController> {
  const ChangeProductOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: controller,
      builder: (_) {
        return SelectionArea(
          child: Scaffold(
            backgroundColor: context.theme.appColors.bgAppbar2,
            bottomSheet: _buildBottom(),
            appBar: AppBar(
              leadingWidth: 50,
              systemOverlayStyle: context.theme.appBarTheme.systemOverlayStyle ,
              backgroundColor: context.theme.appColors.bgAppbar2,
              title:  Text("سفارش ${controller.trackingCode}"),
              titleTextStyle: AppTypography.s19.copyWith(
                fontFamily: FontsName.fontBold,
                color:  context.theme.appColors.text
              ),
            ),
            body: _BuildBody(controller: controller,)
          ),
        );
      },
    );
  }

  _buildBottom(){
    return CustomBottomBar(
      child: Column(
        children: [
          const SizedBox(height: 15,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomButton(onTap: () {
              CustomRoot.back(result: controller.tempListProduct);
              print( controller.tempListProduct.length);
            },
              height: 40,
              width: double.infinity,
              text: 'ذخیره',
            ),
          ),
          const SizedBox(height: 15,),

        ],
      ),
    );
  }
}


class _BuildBody extends StatelessWidget {
  const _BuildBody({required this.controller});
  final ChangeProductOrderController controller;
  @override
  Widget build(BuildContext context) {
    if(controller.isLoading){
      return const LoadingWidget();
    }
    return Container(
      decoration:  BoxDecoration(
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
        color: context.theme.appColors.cart
      ),
      child: Column(
        children: [
          _buildCategory(context),
          Expanded(
            child: Obx(
              () {
                if(controller.listProducts.isEmpty){
                  return Container(
                      decoration:  BoxDecoration(
                        borderRadius: const BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
                        color:  context.theme.appColors.cart,
                      ),
                      child: const Center(child: Text('موردی یافت نشد !')));
                }
                return ListView.separated(
                itemCount: controller.listProducts.length,
                padding: const EdgeInsets.symmetric(horizontal: 15) + const EdgeInsets.only(
                  bottom: 130
                ),
                itemBuilder: (context, index) {
                  final item = controller.listProducts[index];
                  return VerticalItemProduct(
                    item: item,
                    goToSingleProduct: false,
                    onTapAddOrRemove: (isAdded) {
                      if(isAdded){
                       WaiterBasket.buyProduct(product: item,tempList: controller.tempListProduct);
                      }else {
                        WaiterBasket.deleteProduct(product: item,tempList: controller.tempListProduct);

                      }
                    },
                  );
                },
                separatorBuilder: (context, index) {
                  return  CustomDivider(
                    width: Get.width/2,
                  );
                },
              );
              },
            ),
          ),
        ],
      ),
    );
  }


  Widget  _buildCategory(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20,bottom: 8),
      height: 35,
      child: ListView.builder(
        itemCount: controller.listGroups.length,
        padding: const EdgeInsets.only(right: 8),
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          final item = controller.listGroups[index];
        return Container(
          margin: const EdgeInsets.only(left: 8),
          child: Obx(
            () =>  CustomButton(
              color: ColorHelper.red,
              colorText: controller.selectedGroup.value == item ? ColorHelper.white : context.theme.appColors.text,
              backGroundColor: controller.selectedGroup.value == item ? ColorHelper.red :context.theme.appColors.cart,
              text: item.GroupName,
              onTap: () {
                controller.selectCategory(item: item);
              },
              isOutLineButton: true,
            ),
          ),
        );
      },),
    );
  }
}

