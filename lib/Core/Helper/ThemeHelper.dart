import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:waiter/Core/Helper/AppTypography.dart';

import 'ColorHelper.dart';

class ThemeHelper {
  ThemeHelper._();

  static final BorderRadius borderRadius = BorderRadius.circular(10);
  static final BorderRadius borderRadius15 = BorderRadius.circular(15);
  static final BorderRadius borderRadius8 = BorderRadius.circular(8);
  static final BorderRadius borderRadius7 = BorderRadius.circular(7);



  static ThemeData get themeLight => ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.white,
        surfaceTint: Colors.white,),
      primaryColor: Colors.white,
      primaryColorLight: Colors.white,
      useMaterial3: true,
      fontFamily: FontsName.fontReg,
      dialogBackgroundColor: Colors.white,
      scaffoldBackgroundColor: Colors.white,
      brightness: Brightness.light,
      appBarTheme: const AppBarTheme(backgroundColor: Colors.white,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: ColorHelper.bgDark,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.dark,
        ),
      ),
    extensions: <ThemeExtension<dynamic>>[
       MyColors(
         borderGrey: ColorHelper.borderGrey,
         divider: ColorHelper.divider,
         text: ColorHelper.text,
         textField: ColorHelper.textField,
         icon: ColorHelper.icon,
         icon2: ColorHelper.black,
         bgAppbar: ColorHelper.white,
         bgAppbar2: ColorHelper.greyBackGround,
         hint: ColorHelper.hint,
         cart: ColorHelper.cart,
         detailPrice: ColorHelper.red.withOpacity(0.4)

      ),
    ]
  );


  static ThemeData get themeDark => ThemeData(
      // colorScheme: ColorScheme.fromSeed(seedColor: ColorHelper.red,
      //   surface: ColorHelper.bgDark,
      //   surfaceTint: const Color(0xff93B1A6)
      // ),
      useMaterial3: true,
      fontFamily: FontsName.fontReg,
      colorScheme: const ColorScheme.dark(),
      appBarTheme: const AppBarTheme(backgroundColor: ColorHelper.bgDark,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: ColorHelper.bgDark,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.light,
        ),
      ),
      scaffoldBackgroundColor: ColorHelper.bgDark,
      extensions: <ThemeExtension<dynamic>>[
        MyColors(
          borderGrey:  ColorHelper.borderGreyDark,
          divider: ColorHelper.dividerDark,
          text: ColorHelper.textDark,
          textField: ColorHelper.textFieldDark,
          icon: ColorHelper.iconDark,
          icon2: ColorHelper.iconDark,
          bgAppbar: ColorHelper.bgDark,
          bgAppbar2: ColorHelper.bgDark,
          hint: ColorHelper.hintDark,
          cart: ColorHelper.cartDark,
          detailPrice: ColorHelper.cartDark.withOpacity(0.4)


        ),
      ]
  );
}
