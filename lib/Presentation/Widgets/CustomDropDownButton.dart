



import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waiter/Core/Helper/AppTypography.dart';
import 'package:waiter/Core/Helper/ColorHelper.dart';

class DropDownButtonOfFurther extends StatelessWidget {
  const DropDownButtonOfFurther({super.key, required this.items, required this.itemSelected,
    required this.hint, required this.onChange});
  final List<String> items ;
  final int? itemSelected  ;
  final String hint  ;
  final void Function(int?) onChange;
  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xffD1D1D1))
      ),
      height: 40,
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          borderRadius: BorderRadius.circular(10),
            iconSize: 40,
            iconEnabledColor: Colors.black,
            value:  itemSelected,
            icon:  Icon(Icons.arrow_drop_down,
            color:  context.theme.appColors.icon),
            hint: Container(
              margin: const EdgeInsets.only(right: 8),
              child: Text(hint,
                  style: AppTypography.s16.copyWith(
                      color:  context.theme.appColors.text
                  )),
            ),
            isExpanded: false,
            items: items.asMap().map((key, value) {
              return MapEntry(key,  DropdownMenuItem<int>(
                value: key,
                child: Container(
                  margin: const EdgeInsets.only(right: 8),
                  child: Text(value,
                      style: AppTypography.s16.copyWith(
                          color:  context.theme.appColors.text,
                        fontFamily: FontsName.fontReg
                      )),
                ),
              ));
            },).values.toList(),
            onChanged: onChange),
      ),
    );
  }
}
