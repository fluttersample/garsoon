import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waiter/Core/Helper/AppTypography.dart';
import 'package:waiter/Core/Helper/ColorHelper.dart';

import 'package:waiter/Presentation/Widgets/Buttons/BackButtonWidget.dart';

import '../CustomDivider.dart';
import '../DeveloperButton.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar(
      {super.key,
       this.iconBack,
       this.iconLeading,
       this.title,
        this.leadingWidth,
        this.titleWidget,
        this.withDivider = true,
      });

  final Widget? iconBack;
  final Widget? iconLeading;
  final Widget? titleWidget;
  final bool withDivider;
  final String? title;
  final double? leadingWidth;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: Padding(
        padding: const EdgeInsets.only(right: 8),
        child: iconLeading ??  const BackButtonWidget(),
      ),
      bottom: withDivider? const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: CustomDivider(
            height: 1,
            color: Color(0xffE8E8E8),
          )) : null,
      titleTextStyle: AppTypography.s18
          .copyWith(fontFamily: FontsName.fontBold,
          color: context.theme.appColors.text),
      title: titleWidget ?? Text(title??''),
      leadingWidth: leadingWidth ??38,
      actions: [
        Container(
            margin: const EdgeInsets.only(left: 8,),
            child: iconBack ),
        const DeveloperButton()

      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(55);
}
