

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waiter/Core/Dto/Models/export_models.dart';
import 'package:waiter/Core/Helper/AppTypography.dart';
import 'package:waiter/Core/Helper/ArgName.dart';
import 'package:waiter/Core/Helper/ColorHelper.dart';
import 'package:waiter/Core/Helper/WaiterBasket.dart';
import 'package:waiter/Infrastructure/Navigation/CustomRoot.dart';
import 'package:waiter/Infrastructure/Navigation/Routes.dart';
import 'package:waiter/Presentation/Widgets/Animations/AnimFadeWidget.dart';
import 'package:waiter/Presentation/Widgets/Buttons/CustomButton.dart';
import 'package:waiter/Presentation/Widgets/CustomImage.dart';
import 'package:waiter/Presentation/Widgets/PriceWidget.dart';
import 'package:waiter/Presentation/Widgets/Products/AddOrSubtractProduct.dart';

class VerticalItemProduct extends StatelessWidget {
  const VerticalItemProduct({super.key, required this.item,  this.showDescription = false,  this.goToSingleProduct= true,
    this.showAddButtonOrRemove = true,
     this.onTapAddOrRemove});
  final ProductsModel item;
  final bool showDescription;
  final bool goToSingleProduct;
  final bool showAddButtonOrRemove;
  final void Function(bool isAdded)? onTapAddOrRemove;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: (){
        if(!goToSingleProduct)return;
        CustomRoot.toNamed(Routes.SingleProduct,
        parameters: {ArgName.schemaId : item.SchemaId??''});
      },
      child: Container(
        margin: const EdgeInsets.only(top: 15),
        child: Padding(
          padding:  const EdgeInsets.only(top: 15,right: 15,bottom: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CustomImage(
                    url: item.Picture ?? '',
                    height: 85,
                    borderRadius: 15,
                    width: 85,
                  ),
                  const SizedBox(width: 8,),
                  Expanded(
                    child: AutoSizeText.rich(
                      maxLines: 2,
                      TextSpan(
                        text: '${item.ProductName??''} ',
                        style: AppTypography.s16,
                        children: [
                          TextSpan(text: item.ProductUnitNameString??'',
                          style: AppTypography.s14.copyWith(
                            color: ColorHelper.greyConst
                          ))
                        ]
                      )
                    ),
                  ),
                ],
              ),



              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _buildDescription(context),
                  _buildButtonAndPrice(context)
              ],),
              Visibility(
                visible: showDescription,
                child: Obx(
                  () =>  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height:  item.ShowAddDescription!.value ? 100 : 0,
                    margin: const EdgeInsets.only(
                      top: 10
                    ),
                    width: Get.width,
                    child: Visibility(
                      visible:  item.ShowAddDescription!.value,
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                        child: Container(
                          color: context.theme.appColors.cart,
                          child: TextField(
                            textInputAction: TextInputAction.done,
                            controller: item.textEditingController,
                            onChanged: (value) {
                              // if (value.isNotEmpty) {
                              //   controller.checkOrderShopList.Description = value;
                              // } else {
                              //   controller.checkOrderShopList.Description = "";
                              // }
                            },

                            decoration: InputDecoration(
                              labelText: "توضیحات",
                              alignLabelWithHint: true,
                              border:  OutlineInputBorder(
                                borderSide:  const BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            maxLines: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
  Widget _buildButtonAndPrice(BuildContext context) {
    final bool isChoice = (item.ProductChoices?.length??0) >=2;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 8,left: (item.OffPrice??0) > 0 ? 0:15),
          child: PriceWidget(
            price: item.Price ?? 0,
            offPrice: item.OffPrice ?? 0,
              staticColor: context.theme.appColors.icon

          ).init(),
        ),
        Visibility(
          replacement: Text('${(item.Count!.value == 0? item.Quantity : item.Count!.value)} عدد',
          style: AppTypography.s17.copyWith(
            fontFamily: FontsName.fontReg,
            color: const Color(0xff707070)
          ),),
          visible: showAddButtonOrRemove,
          child: SizedBox(
            height: 35,
            child: AnimFadeWidget(
                condition: item.IsAddToCart!,
                widget1: CustomButton(
                  width: 85,
                  height: 35,
                  onTap: () {
                    if(onTapAddOrRemove != null){
                      onTapAddOrRemove!(true);
                    }else {
                      if(isChoice){
                        CustomRoot.toNamed(Routes.SingleProduct,
                            parameters: {ArgName.schemaId : item.SchemaId??''}
                        );
                      }else {

                        WaiterBasket.buyProduct(product: item,);

                      }
                    }

                  },
                  text: onTapAddOrRemove != null ? 'خرید' :isChoice ? 'انتخاب' :'خرید',
                  color: ColorHelper.red,
                  colorText: ColorHelper.white,
                ),
                widget2: SizedBox(
                  width: 85,
                  child: AddOrSubTracProduct(
                    height: 30,
                    width: 30,
                    onAdd: () {
                      if(onTapAddOrRemove != null){
                        onTapAddOrRemove!(true);
                      }else {
                      WaiterBasket.buyProduct(product: item);
                      }
                    },
                    onSubtract: () {
                      if(onTapAddOrRemove != null){
                        onTapAddOrRemove!(false);
                      }else {
                      WaiterBasket.deleteProduct(product: item);
                      }
                    },
                    count: item.Count!,
                  ),
                )),
          ),
        ),
      ],
    );
  }


   _buildDescription(BuildContext context){
     return Visibility(
       visible: showDescription,
       child: Column(
         children: [
           Obx(
             () =>  InkWell(
               borderRadius: BorderRadius.circular(8),
               onTap: () {
                item.ShowAddDescription!.value =  !item.ShowAddDescription!.value;
               },
               child: Container(
                 decoration: BoxDecoration(
                   border: Border.all(color:  item.ShowAddDescription!.value ?
                   Colors.red : Colors.grey.withOpacity(0.5), width: 1.0),
                   borderRadius: BorderRadius.circular(8.0),
                   color: context.theme.appColors.cart
                 ),
                 padding: const EdgeInsets.all(4.0),
                 child: Center(
                   child: Row(
                     children: [
                       Text(
                         item.ShowAddDescription!.value ? "ثبت توضیحات" : "توضیحات",
                         style: AppTypography.s14.copyWith(
                           fontFamily: FontsName.fontBold
                         )
                       ),
                       const SizedBox(width: 2.0),
                       const Icon(Icons.edit_note),

                     ],
                   ),
                 ),
               ),
             ),
           ),



         ],
       ),
     );
  }
}
