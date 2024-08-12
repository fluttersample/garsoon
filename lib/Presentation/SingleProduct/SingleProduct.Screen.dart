import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waiter/Core/Dto/Models/Responses/Products/ProductsModel.dart';
import 'package:waiter/Core/Helper/AppTypography.dart';
import 'package:waiter/Core/Helper/ColorHelper.dart';
import 'package:waiter/Core/Helper/Extensions.dart';
import 'package:waiter/Core/Helper/WaiterBasket.dart';
import 'package:waiter/Infrastructure/Navigation/CustomRoot.dart';
import 'package:waiter/Infrastructure/Navigation/Routes.dart';
import 'package:waiter/Presentation/Widgets/Animations/AnimFadeWidget.dart';
import 'package:waiter/Presentation/Widgets/AppBars/CustomSliverAppBar.dart';
import 'package:waiter/Presentation/Widgets/Buttons/CustomButton.dart';
import 'package:waiter/Presentation/Widgets/CustomImage.dart';
import 'package:waiter/Presentation/Widgets/LoadingWidget.dart';
import 'package:waiter/Presentation/Widgets/PriceWidget.dart';
import 'package:waiter/Presentation/Widgets/Products/AddOrSubtractProduct.dart';
import 'Controller/SingleProduct.Controller.dart';

class SingleProductScreen extends GetView<SingleProductController> {
  const SingleProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: controller,
      builder: (_) {
        return SelectionArea(
          child: Scaffold(
              body: SafeArea(
            child: NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) => [
                          CustomSliverAppBar(onTapSearch: () {
                            CustomRoot.toNamed(Routes.SearchProduct);
                          })
                        ],
                body: _BuildBody(
                  controller: controller,
                )),
          )),
        );
      },
    );
  }
}

class _BuildBody extends StatelessWidget {
  const _BuildBody({required this.controller});

  final SingleProductController controller;

  @override
  Widget build(BuildContext context) {
    if (controller.isLoading) {
      return const LoadingWidget();
    }
    return SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
        child: Column(
          children: [
            _buildImageSlider(),
            const SizedBox(
              height: 15,
            ),
            Text(
              ('${controller.product.value.ProductName} ') +
                  (controller.product.value.ProductUnitNameString ?? ''),
              style: AppTypography.s20.copyWith(fontFamily: FontsName.fontBold),
            ),
            const SizedBox(
              height: 15,
            ),
            _buildProductChoice(),
            _buildButtonAndPrice(context),
            const SizedBox(
              height: 30,
            ),
            IngredientsSection(
                ingredients: controller.product.value.ProductContain.isNullOrEmpty?[] :
                    controller.product.value.ProductContain?.split(',') ?? []),
            const SizedBox(
              height: 30,
            ),
            _buildDescription(),
          ],
        ));
  }

  Widget _buildImageSlider() {
    return SizedBox(
      height: 200,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CarouselSlider.builder(
            itemCount: controller.product.value.Pictures?.length,
            options: CarouselOptions(
                onPageChanged: (value, reason) {
                  controller.currentSlider.value = value;
                },
                height: 200,
                autoPlay: false,
                autoPlayInterval: const Duration(seconds: 3),
                reverse: true,
                enableInfiniteScroll: false,
                viewportFraction: 1),
            itemBuilder: (context, index, realIndex) {
              final data = controller.product.value.Pictures?[index];
              return Hero(
                tag: controller.product.value.SchemaId ?? '',
                child: CustomImage(
                  url: data ?? '',
                  boxFit: BoxFit.fill,
                ),
              );
              //return _buildImage(image: data!);
            },
          ),
          Visibility(
            visible: (controller.product.value.Pictures?.length ?? 0) > 1,
            child: Positioned(
              bottom: 0,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10, right: 12, left: 12),
                child: Obx(
                  () => CarouselIndicator(
                    count: (controller.product.value.Pictures?.length ?? 0),
                    animationDuration: 200,
                    index: controller.currentSlider.value,
                    activeColor: ColorHelper.red.withOpacity(0.7),
                    color: Colors.grey.withOpacity(0.5),
                    width: 8,
                    height: 8,
                    cornerRadius: 8,
                  ),
                ),
                //_indicator()
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildButtonAndPrice(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                  bottom: 8,
                  left: (controller.product.value.OffPrice ?? 0) > 0 ? 0 : 15),
              child: PriceWidget(
                price: controller.product.value.Price ?? 0,
                offPrice: controller.product.value.OffPrice ?? 0,
                staticColor: context.theme.appColors.icon
              ).init(),
            ),
            SizedBox(
              height: 35,
              child: AnimFadeWidget(
                  condition: controller.product.value.IsAddToCart ?? false.obs,
                  widget1: CustomButton(
                    width: 85,
                    height: 35,
                    onTap: () {
                      WaiterBasket.buyProduct(
                          product: controller.product.value,);
                    },
                    text: 'خرید',
                    color: ColorHelper.red,
                    colorText: ColorHelper.white,
                  ),
                  widget2: SizedBox(
                    width: 85,
                    child: AddOrSubTracProduct(
                      height: 30,
                      width: 30,
                      onAdd: () {
                        WaiterBasket.buyProduct(
                            product: controller.product.value);
                      },
                      onSubtract: () {
                        WaiterBasket.deleteProduct(
                            product: controller.product.value);
                      },
                      count: controller.product.value.Count ?? 0.obs,
                    ),
                  )),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDescription() {
    return Visibility(
      visible: !controller.product.value.Description.isNullOrEmpty,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Align(
            alignment: Alignment.centerRight,
            child: Text(
              "توضیحات غذا :",
              style: AppTypography.s18.copyWith(color: const Color(0xffA94646),
                  fontFamily: FontsName.fontMed),
            )),
        const SizedBox(
          height: 8,
        ),
         Text(
          controller.product.value.Description??'',
          style: AppTypography.s12.copyWith(
            fontFamily: FontsName.fontReg
          ),
        ),
      ]),
    );
  }

  Widget _buildProductChoice() {
    return SetProductOptionsWidget(
      controller: controller,
    );
  }
}

class IngredientsSection extends StatelessWidget {
  const IngredientsSection({
    super.key,
    required this.ingredients,
  });

  final List<String> ingredients;

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: ingredients.isNotEmpty,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Align(
              alignment: Alignment.centerRight,
              child: Text(
                "مخلفات :",
                style: AppTypography.s18.copyWith(color: const Color(0xffA94646),
                fontFamily: FontsName.fontMed),
              )),
          buildItems(context)
        ]));
  }

  Wrap buildItems(BuildContext context) {
    return Wrap(
      children: List.generate(
        ingredients.length,
        (index) => Container(
          margin: const EdgeInsets.all(5),
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Get.isDarkMode ?  context.theme.appColors.cart : const Color(0XFFF5F5F5)),
          child: Text(
            ingredients[index] ?? '',
            style: AppTypography.s12.copyWith(color: context.theme.appColors.text),
          ),
        ),
      ),
    );
  }
}

class SetProductOptionsWidget extends StatelessWidget {
  const SetProductOptionsWidget({
    super.key,
    required this.controller,
  });

  final SingleProductController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Visibility(
        visible: controller.allOption!.isNotEmpty,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.allOption!.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Text(
                            controller.allOption![index].Name ?? '',
                            overflow: TextOverflow.ellipsis,
                            style: AppTypography.s16.copyWith(
                              fontFamily: FontsName.fontMed
                            ),
                            // style: FontProvider.medium_title,
                          ),
                        ),
                        SizedBox(
                          height: 42.0,
                          child: ListView.separated(
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const SizedBox(width: 8.0);
                            },
                            scrollDirection: Axis.horizontal,
                            itemCount:
                                controller.allOption![index].Items?.length??0,
                            padding: const EdgeInsets.only(
                              top: 8.0,
                              left: 8.0,
                              right: 8.0,
                            ),
                            itemBuilder: (context, ind) {
                              var item =
                                  controller.allOption![index].Items?[ind];
                              return CellItemProductOptionScreen(
                                controller: Get.put(
                                  CellItemProductOptionController(
                                    option: item!,
                                    callback: controller.selectOption,
                                  ),
                                  tag: (item.SpecificationTypeItemID ?? "").toLowerCase(),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CellItemProductOptionScreen extends GetView<CellItemProductOptionController> {
  final controller;

  const CellItemProductOptionScreen({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: controller,
      tag: controller.option.SpecificationTypeItemID?.toLowerCase(),
      builder: (_) {
        return InkWell(
          onTap: () {
            controller.itemOnTap();
          },
          borderRadius: BorderRadius.circular(8.0),
          child: Opacity(
            opacity: (controller.option.enabled ?? false) ? 1.0 : 0.4,
            child: Container(
              height: 30.0,
              padding: const EdgeInsets.only(
                left: 14.0,
                right: 12.0,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: (controller.option.selected ?? false)
                      ? ColorHelper.red
                      : const Color(0xffDDDDDD),
                  width: (controller.option.selected ?? false) ? 2.0 : 1.0,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: ((controller.option.Hex ?? "").isNotEmpty)
                  ? Row(
                      children: <Widget>[
                        Container(
                          height: 15.0,
                          width: 15.0,
                          // margin: EdgeInsets.all(2.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0x0d000000),
                              width: 1.0,
                            ),
                            shape: BoxShape.circle,
                            color:
                                HexColor.fromHex(controller.option.Hex!)
                                    .getOrElse(() {
                              return Colors.white;
                            }),
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        Center(
                          child: Text(
                            controller.option.Value ?? "",
                            maxLines: 1,
                            textAlign: TextAlign.center,
                            style: AppTypography.s13.copyWith(
                                fontFamily: FontsName.fontMed
                            ),
                          ),
                        )
                      ],
                    )
                  : Center(
                      child: Text(
                        controller.option.Value ?? "",
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        style: AppTypography.s13.copyWith(
                            fontFamily: FontsName.fontMed
                        ),
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }
}

class CellItemProductOptionController extends GetxController {
  final VMProductOptionValue option;
  final Function(VMProductOptionValue)? callback;

  CellItemProductOptionController({required this.option, this.callback});

  itemOnTap() {
    if ((option.enabled ?? false) && callback != null) {
      callback!(option);
    }
  }
}
