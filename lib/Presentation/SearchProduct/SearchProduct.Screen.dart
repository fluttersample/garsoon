import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:waiter/Core/Dto/Models/Responses/Products/ProductsModel.dart';
import 'package:waiter/Core/Helper/AppTypography.dart';
import 'package:waiter/Core/Helper/ArgName.dart';
import 'package:waiter/Core/Helper/ColorHelper.dart';
import 'package:waiter/Core/Helper/Extensions.dart';
import 'package:waiter/Core/Helper/Globals/GlobalFunc.dart';
import 'package:waiter/Core/Helper/WaiterBasket.dart';
import 'package:waiter/Infrastructure/Navigation/CustomRoot.dart';
import 'package:waiter/Infrastructure/Navigation/Routes.dart';
import 'package:waiter/Presentation/Widgets/Animations/AnimFadeWidget.dart';
import 'package:waiter/Presentation/Widgets/Buttons/CustomButton.dart';
import 'package:waiter/Presentation/Widgets/AppBars/CustomAppBar.dart';
import 'package:waiter/Presentation/Widgets/CustomAuoTextSize.dart';
import 'package:waiter/Presentation/Widgets/CustomImage.dart';
import 'package:waiter/Presentation/Widgets/DeveloperButton.dart';
import 'package:waiter/Presentation/Widgets/LoadingWidget.dart';
import 'package:waiter/Presentation/Widgets/PriceWidget.dart';
import 'package:waiter/Presentation/Widgets/Products/AddOrSubtractProduct.dart';
import 'package:waiter/Presentation/Widgets/Products/VerticalItemProduct.dart';
import '../Widgets/CustomDivider.dart';
import 'Controller/SearchProduct.Controller.dart';

class SearchProductScreen extends GetView<SearchProductController> {
  const SearchProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: controller,
      builder: (_) {
        return FocusDetector(
          onVisibilityGained: () {
            WaiterBasket.checkCallBak(controller.listProducts);
          },
          child: SelectionArea(
            child: Scaffold(
                body: SafeArea(
                  child: NestedScrollView(
                      headerSliverBuilder:
                          (BuildContext context, bool innerBoxIsScrolled) =>
                      [
                        _buildAppBar(context),
                      ],
                      body: _BuildBody(
                        controller: controller,
                      )),
                )),
          ),
        );
      },
    );
  }

  _buildAppBar(BuildContext context) {
    return SliverAppBar(
      backgroundColor: context.theme.appColors.bgAppbar,
      forceElevated: false,
      floating: true,
      elevation: 0,
      toolbarHeight: 80,
      scrolledUnderElevation: 0,
      snap: true,
      automaticallyImplyLeading: false,
      leadingWidth: 38,
      leading: IconButton(
        onPressed: () {
          CustomRoot.back();
        },
        icon: const Icon(
          Icons.arrow_back_rounded,
          color: Colors.grey,
          size: 35.0,
        ),
      ),
      bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: CustomDivider(
            height: 1,
          )),
      title: Hero(
        tag: ArgName.heroTextField,
        child: Material(
          child: SizedBox(
            height: 48.0,
            child: Obx(
                  () =>
                  TextField(
                    focusNode: controller.focusSearch,
                    controller: controller.ctnSearch,
                    onChanged: (value) {
                      controller.searchProduct();
                    },
                    decoration: InputDecoration(
                      hintText: 'جستجو در بخش رستوران و غذا ',
                      hintStyle: AppTypography.s12.copyWith(
                          fontFamily: FontsName.fontReg, color: context.theme.appColors.hint),

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
                      prefixIcon: controller.showIconSuffix.value
                          ? null
                          :  Icon(Icons.search, color: context.theme.appColors.icon),
                      suffixIcon: controller.showIconSuffix.value
                          ? InkResponse(
                          borderRadius: BorderRadius.circular(15),
                          radius: 15,
                          onTap: () {
                            controller.searchProduct();
                          },
                          child:  Icon(Icons.search, color: context.theme.appColors.icon))
                          : null,
                    ),
                  ),
            ),
          ),
        ),
      ),
      actions: [
        Container(
          height: 48,
          width: 54,
          margin: const EdgeInsets.only(left: 12),
          decoration: BoxDecoration(
              border: Border.all(color: ColorHelper.borderTextFieldGrey),
              borderRadius: BorderRadius.circular(10)),
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: (){
              CustomRoot.toNamed(Routes.CheckOrder);

            },

            child:  Center(
              child: Badge(
                  alignment: Alignment.topRight,
                  backgroundColor: Colors.red,
                  child: Icon(
                    Icons.shopping_bag_outlined,
                    color: context.theme.appColors.icon,
                  )),
            ),
          ),
        ),
        // const DeveloperButton()
      ],
    );
  }

}

class _BuildBody extends StatelessWidget {
  const _BuildBody({required this.controller});

  final SearchProductController controller;

  @override
  Widget build(BuildContext context) {
    return  Obx(
          () {
        if (controller.listProducts.isEmpty) {
          return const Center(
            child: Text('موردی یافت نشد !'),
          );
        }
        return ListView.separated(
          itemCount: controller.listProducts.length,
          padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 15),
          itemBuilder: (context, index) {
            return VerticalItemProduct(
              item: controller.listProducts[index],);
          },
          separatorBuilder: (context, index) {
            return  CustomDivider(
              width: Get.width/2,
            );
          },
        );
      },
    );
  }

}
