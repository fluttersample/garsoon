import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waiter/Core/Dto/Enums/OrderStepType.dart';
import 'package:waiter/Core/Helper/AppTypography.dart';
import 'package:waiter/Core/Helper/ColorHelper.dart';
import 'package:waiter/Core/Helper/Globals/GlobalFunc.dart';
import 'package:waiter/Presentation/Widgets/Buttons/CustomButton.dart';
import 'package:waiter/Presentation/Widgets/CustomBottomBar.dart';
import 'package:waiter/Presentation/Widgets/CustomDivider.dart';
import 'package:waiter/Presentation/Widgets/LoadingWidget.dart';
import 'package:waiter/Presentation/Widgets/Products/VerticalItemProduct.dart';
import '../Widgets/Buttons/BackButtonWidget.dart';
import 'Controller/Payment.Controller.dart';

class PaymentScreen extends GetView<PaymentController> {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: controller,
      builder: (_) {
        return SelectionArea(
          child: Scaffold(
              backgroundColor: context.theme.appColors.bgAppbar2,
              bottomSheet: _buildBottom(context),
              appBar: AppBar(
                leadingWidth: controller.fromDirectLink ? 10 : 40,
                systemOverlayStyle:
                    context.theme.appBarTheme.systemOverlayStyle,
                leading: controller.fromDirectLink ? const SizedBox.shrink() : const BackButtonWidget(),
                backgroundColor: context.theme.appColors.bgAppbar2,
                title: Text("سفارش ${controller.trackingCode}"),
                titleTextStyle: AppTypography.s19.copyWith(
                  color: context.theme.appColors.text,
                  fontFamily: FontsName.fontBold,
                ),
              ),
              body: _BuildBody(
                controller: controller,
              )),
        );
      },
    );
  }

  _buildBottom(BuildContext context) {
    return CustomBottomBar(
      child: Row(
        children: [
          const SizedBox(
            width: 15,
          ),
          Text(
            'پرداخت سفارش به صورت اینترنتی ',
            style: AppTypography.s17.copyWith(fontFamily: FontsName.fontMed),
          ),
          const Spacer(),
          Obx(
            () {
              if(controller.statusButtonPay.value == StatusPay.Loading){
                return Container(
                  width: 130,
                  height: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: context.theme.appColors.bgAppbar2,
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("لطفا صبر کنید ... ",
                      style: AppTypography.s12,),
                      SizedBox(
                        height: 20,
                          width: 20,
                          child: LoadingWidget())
                    ],
                  ),
                );
              }else if(controller.statusButtonPay.value == StatusPay.Paid){
                return Container(
                  width: 130,
                  height: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.green.shade300,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.done),
                      const SizedBox(width: 4,),
                      Text('پرداخت شد',
                      style: AppTypography.s16.copyWith(
                        fontFamily: FontsName.fontBold
                      ),),

                    ],
                  ),

                );
              }
              return CustomButton(
                onTap: () {
                  controller.startApiCheckPayment();
                },
                width: 120,
                text: 'پرداخت',
                child: Container(
                  margin: const EdgeInsets.only(left: 8),
                  child: Image.asset(
                    'assets/images/ic_online_pay.png',
                    width: 30,
                    color: ColorHelper.black,
                    height: 30,
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}

class _BuildBody extends StatelessWidget {
  const _BuildBody({required this.controller});

  final PaymentController controller;

  @override
  Widget build(BuildContext context) {
    if (controller.isLoading) {
      return const LoadingWidget();
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        color: context.theme.appColors.cart,
      ),
      margin: const EdgeInsets.only(bottom: 70),
      child: ListView.separated(
        itemCount: controller.listProducts.length,
        padding: const EdgeInsets.only(top: 15),
        itemBuilder: (_, index) {
          final item = controller.listProducts[index];
          if (item.Id?.contains('0') ?? false) {
            return _buildHeadPart(context);
          }
          if (item.Id?.contains('1') ?? false) {
            return _buildPriceDetailWidget;
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: VerticalItemProduct(
              item: item,
              showDescription: false,
              goToSingleProduct: false,
              showAddButtonOrRemove: false,
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return CustomDivider(
            width: Get.width / 1.5,
          );
        },
      ),
    );
  }

  Widget _buildHeadPart(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: controller.fromDirectLink,
          child: Center(
            child: Text(controller.orderInfo.ShopName ?? '',
                style: AppTypography.s19.copyWith(
                    fontFamily: FontsName.fontBold,
                    color: context.theme.appColors.text)),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Container(
          margin: const EdgeInsets.only(right: 12),
          child: RichText(
            text: TextSpan(
                text: 'تاریخ سفارش : ',
                style: AppTypography.s14.copyWith(
                  fontFamily: FontsName.fontReg,
                  color: context.theme.appColors.text,
                ),
                children: [
                  TextSpan(
                      text: GlobalFunc.convertDate(controller.dateOrder),
                      style: AppTypography.s14.copyWith(
                          fontFamily: FontsName.fontBold,
                          color: context.theme.appColors.text))
                ]),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        _buildStatusOrder(),
        const SizedBox(
          height: 20,
        )
      ],
    );
  }

  Widget _buildStatusOrder() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            Opacity(
              opacity: controller.orderInfo.StatusType == OrderStepType.NONE ?
              0.3 : 1,
              child: Image.asset(
                'assets/images/img_preparing.png',
                width: 70,
                height: 70,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Opacity(
              opacity: controller.orderInfo.StatusType == OrderStepType.NONE ?
              0.3 : 1,
              child: Text(
                "آماده سازی",
                style: AppTypography.s12.copyWith(
                    fontFamily: FontsName.fontBold, color: ColorHelper.blue),
              ),
            )
          ],
        ),
        const SizedBox(
          width: 12,
        ),
        Opacity(
         opacity: controller.orderInfo.StatusType  == OrderStepType.DELIVERED
         ? 1:0.3,
          child: Container(
            height: 6,
            width: 30,
            decoration: BoxDecoration(
                color: const Color(0xff00CAF5),
                borderRadius: BorderRadius.circular(20)),
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Column(
          children: [
            Opacity(
              opacity: controller.orderInfo.StatusType  == OrderStepType.DELIVERED
                  ? 1:0.3,
              child: Image.asset(
                'assets/images/img_delivered.png',
                width: 70,
                height: 70,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Opacity(
              opacity: controller.orderInfo.StatusType  == OrderStepType.DELIVERED
                  ? 1 : 0.3,
              child: Text(
                "تحویل به مشتری",
                style: AppTypography.s12.copyWith(
                    fontFamily: FontsName.fontBold, color: ColorHelper.blue),
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget get _buildPriceDetailWidget {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      decoration: const BoxDecoration(color: ColorHelper.greyBackGround),
      child: Column(
        children: [
          const SizedBox(
            height: 8,
          ),
          _buildItemPriceDetail(
              price: controller.moneyCalculateModel.priceProducts ?? 0,
              title: 'قیمت کالا'),
          _buildItemPriceDetail(
              price: controller.moneyCalculateModel.yourBenefit ?? 0,
              title: 'سود شما',
              textColor: true),
          _buildItemPriceDetail(
              price: controller.moneyCalculateModel.calMustBePay,
              title: 'قابل پرداخت',
              bgColor: true),
        ],
      ),
    );
  }

  _buildItemPriceDetail(
      {required int price,
      required String title,
      bool bgColor = false,
      bool textColor = false}) {
    return Builder(
      builder: (context) => Container(
        decoration: BoxDecoration(
            color: bgColor ? context.theme.appColors.detailPrice : null),
        child: ListTile(
          visualDensity: const VisualDensity(vertical: -4),
          title: Text(title),
          tileColor: ColorHelper.black,
          titleTextStyle: AppTypography.s16.copyWith(
            fontFamily: FontsName.fontReg,
            color: textColor ? ColorHelper.red : ColorHelper.black,
          ),
          trailing: Text(
            GlobalFunc.convertPrice(price),
            style: AppTypography.s16.copyWith(
                fontFamily: FontsName.fontMed,
                color: textColor ? ColorHelper.red : ColorHelper.black),
          ),
        ),
      ),
    );
  }
}
