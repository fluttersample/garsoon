import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waiter/Core/Helper/AppTypography.dart';
import 'package:waiter/Core/Helper/ArgName.dart';
import 'package:waiter/Core/Helper/ColorHelper.dart';
import 'package:waiter/Core/Helper/WaiterBasket.dart';
import 'package:waiter/Infrastructure/Navigation/CustomRoot.dart';
import 'package:waiter/Infrastructure/Navigation/Routes.dart';
import 'package:waiter/Presentation/PreviewChangeOrder/Controller/PreviewChangeOrder.Controller.dart';
import 'package:waiter/Presentation/Widgets/AppBars/CustomAppBar.dart';
import 'package:waiter/Presentation/Widgets/Buttons/BackButtonWidget.dart';
import 'package:waiter/Presentation/Widgets/Buttons/CustomButton.dart';
import 'package:waiter/Presentation/Widgets/CustomBottomBar.dart';
import 'package:waiter/Presentation/Widgets/CustomDivider.dart';
import 'package:waiter/Presentation/Widgets/Dialogs/CustomDialogWidget.dart';
import 'package:waiter/Presentation/Widgets/LoadingWidget.dart';
import 'package:waiter/Presentation/Widgets/Products/VerticalItemProduct.dart';

class PreviewChangeOrderScreen extends GetView<PreviewChangeOrderController> {
  const PreviewChangeOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: controller,
      builder: (_) {
        return SelectionArea(
          child: Scaffold(
            bottomSheet: _buildBottom(context),
            appBar:  CustomAppBar(
             // title: 'بررسی سفارش',
              iconLeading: Align(
                alignment: Alignment.centerRight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        const BackButtonWidget(),
                        const SizedBox(width: 8,),
                        Text("سفارش ${controller.trackingCode}",textAlign: TextAlign.center,
                        style: AppTypography.s18.copyWith(
                          fontFamily: FontsName.fontBold
                        )),
                      ],
                    ),
                  ],
                ),
              ),
              leadingWidth: Get.width/2,
            ),
            body: _BuildBody(controller: controller,)
          ),
        );
      },
    );
  }

  _buildBottom(BuildContext context){
    return Visibility(
      visible: !controller.isLoading && (controller.orderInfo.Status != 9 && controller.orderInfo.Status != 10),
      child: CustomBottomBar(
        height: 130,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 15,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomButton(onTap: () {
                  controller.startApiEditOrder();
                },
                  height: 40,
                  width: double.infinity,
                  text: 'تایید تغییرات',
                  textStyle: AppTypography.s16.copyWith(
                    fontFamily: FontsName.fontBold,
                    color:  ColorHelper.black
                  ),
                ),
              ),
              const SizedBox(height: 8,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomButton(onTap: () async{
                      if(controller.isLoading)return;
                      await CustomRoot.toNamed(Routes.ChangeProductOrder,
                      arguments: {ArgName.tempListProductOrder : controller.listProducts,
                        ArgName.trackingCode : controller.trackingCode},);
                      controller.update();
                    },
                      colorText: context.theme.appColors.text,
                      color: context.theme.appColors.text,
                      isOutLineButton: true,
                      text: 'افزودن کالا',),


                    Visibility(
                      visible: !controller.isLoading &&
                          (controller.orderInfo.HasPhoneNumber == null ||
                              controller.orderInfo.HasPhoneNumber == false),
                      child: CustomButton(onTap: () async{
                        controller.phoneNumberController.clear();
                        showDialog(
                          context: context,
                          builder: (context) {
                            return CustomDialogWidget(
                              height: 100,
                              textOk: 'تایید شماره',
                              textCancel: 'انصراف',
                              title: 'شماره تماس مشتری',
                              btnCancelOnTap: (){
                                controller.phoneNumberController.clear();
                              },
                              btnOkOnTap: (){
                                  CustomRoot.back();
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(
                                    child: Container(
                                      height: 50,
                                      padding: const EdgeInsets.only(right: 10),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(15),
                                          border: Border.all(color: context.theme.appColors.text),
                                          color: context.theme.appColors.cart
                                      ),
                                      child: TextField(
                                        style: AppTypography.s16
                                            .copyWith(fontFamily: FontsName.fontBold),
                                        controller: controller.phoneNumberController,
                                        keyboardType: TextInputType.number,
                                        maxLength: 11,
                                        decoration: InputDecoration(
                                          hintText: 'شماره تماس مشتری را وارد کنید',
                                          hintStyle: AppTypography.s14.copyWith(
                                            fontFamily: FontsName.fontReg,
                                          ),
                                          enabledBorder: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          counterText: "",
                                        ),
                                      )
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                        colorText: context.theme.appColors.text,
                        color: context.theme.appColors.text,
                        isOutLineButton: true,
                        text: 'افزودن شماره',),
                    ),

                    CustomButton(onTap: () {
                      showDialog(context: Get.context!,
                        builder: (context) {
                          return CustomDialogWidget(
                              title: 'لغو سفارش',
                              height: 200,
                              messageDialog: 'آیا از لغو سفارش مطمعئن هستید ؟',
                              btnOkOnTap: (){
                                CustomRoot.back();
                                controller.startApiCancelOrder();

                              }
                          );
                        },);
                    },
                      color: Colors.red,
                      colorText: Colors.red,
                      isOutLineButton: true,
                      text: 'لغو سفارش',),


              ]),
              const SizedBox(height: 15,),

            ],
          ),
        ),
      ),
    );
  }
}


class _BuildBody extends StatelessWidget {
  const _BuildBody({ required this.controller});
  final PreviewChangeOrderController controller;
  @override
  Widget build(BuildContext context) {
    if(controller.isLoading){
      return const LoadingWidget();
    }
    if(controller.listProducts.isEmpty){
      return const Center(child: Text('سفارش شما خالی است !'));
    }
    return ListView.separated(
      itemCount: controller.listProducts.length,
      padding: const EdgeInsets.symmetric(horizontal: 15) + const EdgeInsets.only(
        bottom: 130
      ),
      itemBuilder: (context, index) {
        final item  = controller.listProducts[index];
        return VerticalItemProduct(
          item: item,
          showDescription: true,
          goToSingleProduct: false,
          onTapAddOrRemove: (isAdded) {
            if(isAdded){
              WaiterBasket.buyProduct(product: item,tempList: controller.listProducts);
            }else {
              WaiterBasket.deleteProduct(product: item,tempList: controller.listProducts);
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
  }
}

