import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:waiter/Core/Dto/Models/Responses/Products/ProductsModel.dart';
import 'package:waiter/Core/Helper/AppTypography.dart';
import 'package:waiter/Core/Helper/ArgName.dart';
import 'package:waiter/Core/Helper/BaseBrain.dart';
import 'package:waiter/Core/Helper/ColorHelper.dart';
import 'package:waiter/Core/Helper/Extensions.dart';
import 'package:waiter/Core/Helper/WaiterBasket.dart';
import 'package:waiter/Infrastructure/Navigation/CustomRoot.dart';
import 'package:waiter/Infrastructure/Navigation/Routes.dart';
import 'package:waiter/Presentation/Widgets/Animations/AnimFadeWidget.dart';
import 'package:waiter/Presentation/Widgets/AppBars/CustomSliverAppBar.dart';
import 'package:waiter/Presentation/Widgets/Buttons/CustomButton.dart';
import 'package:waiter/Presentation/Widgets/CustomAuoTextSize.dart';
import 'package:waiter/Presentation/Widgets/CustomImage.dart';
import 'package:waiter/Presentation/Widgets/LoadingWidget.dart';
import 'package:waiter/Presentation/Widgets/PriceWidget.dart';
import 'package:waiter/Presentation/Widgets/Products/AddOrSubtractProduct.dart';
import 'Controller/ProductList.Controller.dart';
class ProductListScreen extends GetView<ProductListController> {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: controller,
      builder: (_) {
        return FocusDetector(
          onVisibilityGained: () {
            WaiterBasket.checkCallBak(controller.listProducts);
          },
          child: Scaffold(
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.startFloat,
              floatingActionButton: _buildFloatActionButton(),
              body: SafeArea(
                child: NestedScrollView(
                  controller: controller.scController,
                    headerSliverBuilder:
                        (BuildContext context, bool innerBoxIsScrolled) => [
                          CustomSliverAppBar(onTapSearch: () {
                            if(!controller.isLoading) {
                              CustomRoot.toNamed(Routes.SearchProduct,arguments: {
                                ArgName.listProducts : controller.listProducts.toList()
                              });
                            }
                          },showBackButton: !BaseBrain.isCustomer,
                          ),
                            ],
                    body: _BuildBody(
                      controller: controller,
                    )),
              )),
        );
      },
    );
  }


  Widget _buildFloatActionButton() {
    return Obx(
      () => AnimatedOpacity(
        opacity: controller.showGroupPanel.value ? 0 : 1,
        duration: const Duration(milliseconds: 500),
        child: FloatingActionButton(
          elevation: 0,
          shape: RoundedRectangleBorder(
              side: const BorderSide(width: 1, color: Color(0xff9AAEFF)),
              borderRadius: BorderRadius.circular(100)),
          backgroundColor: Colors.white,
          onPressed: () {
            controller.showGroupPanel.value = true;
          },
          child: Image.asset(
            'assets/images/ic_path.png',
            height: 20,
            width: 20,
          ),
        ),
      ),
    );
  }
}

class _BuildBody extends StatelessWidget {
  const _BuildBody({required this.controller});

  final ProductListController controller;

  @override
  Widget build(BuildContext context) {
    if (controller.isLoading) {
      return const LoadingWidget();
    }
    return Stack(
      children: [
        Obx(
          () {
            if (controller.listProducts.isEmpty) {
              return const Center(
                child: Text('در این دسته بندی کالای وجود ندارد .'),
              );
            }
            return GridView.builder(
              padding: const EdgeInsets.symmetric(vertical: 20),
              itemCount: controller.listProducts.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 0.0,
                  crossAxisSpacing: 0.0,
                  crossAxisCount: 2,
                  mainAxisExtent: 270),
              itemBuilder: (_, index) {
                return _buildItemGridView(index,context);
              },
            );
          },
        ),
        Obx(
          () => AnimatedPositioned(
              right: controller.showGroupPanel.value ? 0 : -130,
              top: controller.scController.position.pixels >= 80? 80:20,
              bottom: 20,
              curve: Curves.fastOutSlowIn,
              duration: const Duration(milliseconds: 500),
              child: Container(
                width: 120,
                decoration: BoxDecoration(
                    color: context.theme.appColors.cart,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        bottomLeft: Radius.circular(15)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ]),
                child: _buildGroups(),
              )),
        ),
        Obx(
          () => controller.showGroupPanel.value
              ? Positioned(
                  top: 0,
                  bottom: 0,
                  right: 120,
                  left: 0,
                  child: GestureDetector(
                    onVerticalDragEnd: (details) {
                      controller.showGroupPanel.value = false;
                    },
                    onTap: () {
                      controller.showGroupPanel.value = false;
                    },
                  ))
              : const SizedBox.shrink(),
        )
      ],
    );
  }

  Widget _buildItemGridView(int index,BuildContext context) {
    final item = controller.listProducts[index];
    return InkWell(
      onTap: () {
        CustomRoot.toNamed(Routes.SingleProduct,
        parameters: {ArgName.schemaId : item.SchemaId??''});
      },
      child: Container(
        padding: EdgeInsets.only(
            right: 8, left: 8, top: index < 2 ? 0 : 8, bottom: 8),
        decoration: BoxDecoration(
            border: Border(
              left: BorderSide(
                color:
                    index.isEven ? ColorHelper.borderGrey : Colors.transparent,
                width: 1,
              ),
              top: BorderSide(
                color: index > 1 ? ColorHelper.borderGrey : Colors.transparent,
                width: 1,
              ),
            ),
            color: context.theme.appColors.cart),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Hero(
              tag: item.SchemaId ?? '',
              child: CustomImage(
                url: item.Picture ?? '',
                height: 120,
                borderRadius: 15,
                width: 120,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: CustomAutoTextSize(
                item.ProductName ?? '',
                maxLines: 2,
                textAlign: TextAlign.center,
                style:
                    AppTypography.s14.copyWith(fontFamily: FontsName.fontReg),
              ),
            ),
            item.ProductUnitNameString.isNullOrEmpty
                ? const SizedBox.shrink()
                : Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        item.ProductUnitNameString!,
                        style: AppTypography.s13.copyWith(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
            _buildButtonAndPrice(item: item,context: context)
          ],
        ),
      ),
    );
  }

  Widget _buildButtonAndPrice({required ProductsModel item, required BuildContext context}) {
    final bool isChoice = (item.ProductChoices?.length??0) >=2;
    return SizedBox(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            height: 35,
            margin: const EdgeInsets.only(bottom: 8),
            child: PriceWidget(
              price: item.Price ?? 0,
              offPrice: item.OffPrice ?? 0,
              staticColor: context.theme.appColors.icon
            ).init(),
          ),
          AnimFadeWidget(
              condition: item.IsAddToCart!,
              widget1: CustomButton(
                width: 85,
                height: 35,
                onTap: () {
                  if(isChoice) {
                    CustomRoot.toNamed(Routes.SingleProduct,
                        parameters: {ArgName.schemaId: item.SchemaId ?? ''}
                    );
                  }else {
                  WaiterBasket.buyProduct(product: item);
                  }
                },
                text: isChoice ? 'انتخاب' :'خرید',
                color: ColorHelper.red,
                colorText: ColorHelper.white,
              ),
              widget2: SizedBox(
                width: 85,
                child: AddOrSubTracProduct(
                  height: 30,
                  width: 30,
                  onAdd: () {
                    WaiterBasket.buyProduct(product: item);
                  },
                  onSubtract: () {
                    WaiterBasket.deleteProduct(product: item);
                  },
                  count: item.Count!,
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildGroups() {
    return Obx(
      () {
        if (controller.isLoadingGroup.value) {
          return const LoadingWidget();
        }
        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 20),
          controller: ScrollController(),
          itemCount: controller.listGroups.length,
          itemBuilder: (context, index) {
            final item = controller.listGroups[index];
            // if(item.GroupId == '0'){
            //   return Container(
            //     height: 124,
            //     width: 90,
            //     margin: const EdgeInsets.only(bottom: 10, right: 14, left: 14),
            //     decoration: BoxDecoration(
            //         color: ColorHelper.greyWhite,
            //         borderRadius: BorderRadius.circular(10)),
            //
            //   );
            // }
            return InkWell(
              onTap: () {
                controller.selectCategory(item: item);
              },
              child: Obx(
                () => Container(
                  height: 128,
                  width: 90,
                  padding: EdgeInsets.symmetric(horizontal: 2),
                  margin:
                      const EdgeInsets.only(bottom: 10, right: 14, left: 14),
                  decoration: BoxDecoration(
                      color: context.theme.appColors.cart,
                      border: controller.selectedGroup.value == item
                          ? Border.all(color: Colors.red)
                          : Border.all(color: context.theme.appColors.borderGrey),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 8,
                      ),
                      CustomImage(
                        url: item.Picture ?? '',
                        height: 60,
                        borderRadius: 15,
                        width: 60,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomAutoTextSize(
                        item.GroupName ?? '',
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        style: AppTypography.s14.copyWith(
                            color: context.theme.appColors.text),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
