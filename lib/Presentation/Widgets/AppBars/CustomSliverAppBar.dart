

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waiter/Core/Helper/AppTypography.dart';
import 'package:waiter/Core/Helper/ArgName.dart';
import 'package:waiter/Core/Helper/WaiterBasket.dart';
import 'package:waiter/Infrastructure/Navigation/CustomRoot.dart';
import 'package:waiter/Infrastructure/Navigation/Routes.dart';
import 'package:waiter/Presentation/Widgets/CustomDivider.dart';
import 'package:waiter/Presentation/Widgets/DeveloperButton.dart';

import '../../../Core/Helper/ColorHelper.dart';

class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({super.key, required this.onTapSearch , this.showBackButton= true});
  final void Function() onTapSearch;
  final bool showBackButton ;
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: context.theme.appColors.bgAppbar,
      forceElevated: false,
      floating: false,
      pinned: true,
      elevation: 0,
      toolbarHeight: 80,
      scrolledUnderElevation: 0,
      snap: false,
      automaticallyImplyLeading: false,
      leadingWidth: 38,
      leading: showBackButton?IconButton(
        onPressed: () {
          CustomRoot.back();
        },
        icon: const Icon(
          Icons.arrow_back_rounded,
          color: Colors.grey,
          size: 35.0,
        ),
      ) : null,
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
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: onTapSearch,
              child: TextField(
                enabled: false,
                decoration: InputDecoration(
                  label: Text("جستجو در بخش رستوران و غذا",
                      style: AppTypography.s12.copyWith(
                          fontFamily: FontsName.fontReg, color: context.theme.appColors.hint)),
                  disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                        color: ColorHelper.borderTextFieldGrey,
                        width: 1.0,
                      )),
                  prefixIcon:  Icon(Icons.search, color: context.theme.appColors.icon,),
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
              child: Obx(
                () => Badge(
                    alignment: Alignment.topRight,
                    backgroundColor: Colors.red,
                    isLabelVisible: WaiterBasket.productChoiceOrder.isNotEmpty,
                    child:  Icon(
                      Icons.shopping_bag_outlined,
                      color: context.theme.appColors.icon,
                    )),
              ),
            ),
          ),
        ),
        const DeveloperButton()
      ],
    );
  }
}
