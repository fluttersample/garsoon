import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waiter/Core/Dto/Models/export_models.dart';
import 'package:waiter/Core/Helper/AppTypography.dart';
import 'package:waiter/Core/Helper/ArgName.dart';
import 'package:waiter/Core/Helper/ColorHelper.dart';
import 'package:waiter/Core/Helper/Globals/GlobalFunc.dart';
import 'package:waiter/Infrastructure/Navigation/CustomRoot.dart';

import 'package:waiter/Infrastructure/Navigation/Routes.dart';
import 'package:waiter/Presentation/Orders/Controller/OrdersController.dart';
import 'package:waiter/Presentation/Widgets/AppBars/CustomAppBar.dart';
import 'package:waiter/Presentation/Widgets/CustomAuoTextSize.dart';
import 'package:waiter/Presentation/Widgets/CustomDivider.dart';
import 'package:waiter/Presentation/Widgets/CustomDropDownButton.dart';
import 'package:waiter/Presentation/Widgets/LoadingWidget.dart';

class OrdersScreen extends GetView<OrdersController> {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: controller,
      builder: (_) {
        return SelectionArea(
          child: Scaffold(
            appBar: CustomAppBar(
              title: 'سفارش ها',
              iconBack: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(
                    () => DropDownButtonOfFurther(items: controller.items,
                      hint: 'همه',
                      onChange: (p0) {
                        controller.dropdownValue.value = p0!;
                        controller.changeSort(p0);
                      },
                      itemSelected: controller.dropdownValue.value,),
                  ),
                ],
              ),

            ),
            body: _buildBody(context)
          ),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context){
    return controller.obx((state) {
      return GridView.builder(
        gridDelegate:
        const SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 0.0,
            crossAxisSpacing: 0.0,
            crossAxisCount: 2,
            mainAxisExtent: 200),
        itemCount: state?.length,
        itemBuilder: (_, index) {
          final item = state![index];
          return _buildItemList(index: index,item: item,context: context);
        },);
    },onLoading: const LoadingWidget(),
    onEmpty: const Center(child: Text("سفارشی وجود ندارد !"),),
    onError: (error) => const Center(child: Text('خطایی رخ داده است'),));

  }

  Widget _buildItemList({required int index,required OrdersModel item,required BuildContext context}){
    return InkWell(
      onTap: () {
        CustomRoot.toNamed(Routes.PreviewChangeOrder,
        parameters: {ArgName.orderId : item.OrderId??'',
          ArgName.trackingCode : item.TrackingCode??'',
        });
      },
      child: Container(
        padding:  EdgeInsets.only(right: 8,left: 8,top: index<2 ? 0:4),
        decoration: BoxDecoration(
            border: Border(
              left: BorderSide(
                color: index.isEven ? ColorHelper.borderGrey : Colors.transparent,
                width: 1,
              ),
              top: BorderSide(
                color: index > 1 ? ColorHelper.borderGrey: Colors.transparent,
                width: 1,
              ),
            ),
            color: context.theme.appColors.cart),
        child: Column(children: [
          const SizedBox(height: 15,),
          _buildStatusOrder(status: item.IsStatus??1,context: context),
          const SizedBox(height: 15,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/ic_factor.png',
                color: context.theme.appColors.icon2,
                height: 28,
                width: 28,),
              const SizedBox(width: 8,),
              Text(item.TrackingCode!??'',
              style: AppTypography.s17.copyWith(
                fontFamily: FontsName.fontMed,
              ),)
            ],
          ),
          const SizedBox(height: 8,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/ic_table.png',
                color: context.theme.appColors.icon2,
                height: 28,
                width: 28,),
              const SizedBox(width: 8,),
              Text(item.TableCode??'',
                style: AppTypography.s18.copyWith(
                    fontFamily: FontsName.fontMed
                ),),
            Visibility(
              visible: item.IsPaid == true,
              child: Row(
                children: [
                  const SizedBox(width: 4,),
                  Image.asset('assets/images/ic_isPaid.png',
                    width: 30,
                    height: 30,)
                ],
              ),
            )
            ],
          ),
          const SizedBox(height: 8,),

           Text(GlobalFunc.convertPrice(item.TotalAmount??0),
          style: AppTypography.s14.copyWith(
            fontFamily: FontsName.fontMed
          ),),
          const SizedBox(height: 8,),

          Text(GlobalFunc.convertDate(item.CreatedAt),
          style: AppTypography.s12.copyWith(
            color: Colors.grey
          ),)

        ]),
      ),
    );
  }

  _buildStatusOrder({int status =1,required BuildContext context}){
    Widget currentWidget;
    switch(status) {
      case 1:
        currentWidget = Text('آماده سازی',style: AppTypography.s16.copyWith(
          fontFamily: FontsName.fontBold,
          color:  const Color(0xff26D176)
        ),);
        break;
      default :
        currentWidget = Text('تحویل داده شده',style: AppTypography.s14.copyWith(
            fontFamily: FontsName.fontBold,

            color: const Color(0xff808080)
        ),);

    }

    return Container(
      height: 24,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        color: Get.isDarkMode? context.theme.appColors.cart : const Color(0xffF6F5F5)
      ),
      child: currentWidget,
    );
  }

}
