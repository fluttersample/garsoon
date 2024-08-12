import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waiter/main.dart';

import 'Failure.dart';

class ColorHelper {
  static final ColorHelper _singleton = ColorHelper._internal();

  factory ColorHelper() {
    return _singleton;
  }

  ColorHelper._internal();

  static const Color _color = Color(0xffD0BCFF);

  /// Greys
  static const Color borderGrey = Color(0xffE6E6E6);

  // static const Color borderGreyDark = Colors.white;
  static const Color borderGreyDark = _color;

  static const Color divider = Color(0xffD2D2D2);
  static const Color dividerDark = Colors.white;

  static const Color text = Colors.black;
  static const Color textDark = Colors.white;

  static const Color textField = white;
  static const Color textFieldDark = Color(0xff363640);

  static const Color icon = Color(0xff606060);
  static const Color iconDark = _color;

  static const Color hint = Colors.grey;
  static const Color hintDark = greyText;

  static const Color cart = white;
  static const Color cartDark = surfaceDark;

  static const Color borderTextFieldGrey = Color(0xffDDDDDD);
  static const Color grey = Color(0xffF2F2F2);
  static const Color greyConst = Color(0xff999999);
  static const Color greyText = Color(0xffB1B1B1);
  static const Color greyWhite = Color(0xffF8F8F8);
  static const Color greyBackGround = Color(0xffF4F4F4);

  static const Color yellow = Color(0xffFFC727);
  static const Color red = Color(0xffF94143);
  static const Color greyAccent = Color(0xffFCFCFC);
  static const Color green = Color(0xff30ED80);
  static const Color blue = Color(0xff008CFF);

  static const Color white = Colors.white;

  static const Color black = Color(0xff222222);

  static Color hexColor(int hex) {
    return Color(0xff + hex);
  }

  /// DarkBg
  static const Color bgDark = Color(0xff272829);
  static const Color surfaceDark = Color(0xff363640);
}

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Either<Failure, Color> fromHex(String hexString) {
    hexString = hexString.trim();
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceAll('#', ''));
    try {
      int integer = int.parse(buffer.toString(), radix: 16);
      if (integer < 0) throw const FormatException();
      return Right(Color(integer));
    } on FormatException {
      return Left(HexColorFailure());
    }
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

class HexColorFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class MyColors extends ThemeExtension<MyColors> {
  MyColors({
    required this.borderGrey,
    required this.divider,
    required this.text,
    required this.textField,
    required this.icon,
    required this.icon2,
    required this.bgAppbar,
    required this.bgAppbar2,
    required this.hint,
    required this.cart,
    required this.detailPrice,
  });

  final Color borderGrey;

  final Color divider;

  final Color text;

  final Color textField;

  final Color icon;

  final Color icon2;

  final Color bgAppbar;

  final Color bgAppbar2;
  final Color hint;

  final Color cart;
  final Color detailPrice;



  @override
  ThemeExtension<MyColors> copyWith({
    Color? borderGrey,
    Color? divider,
    Color? text,
    Color? textField,
    Color? icon,
    Color? bgAppbar,
    Color? bgAppbar2,
    Color? hint,
    Color? cart,
    Color? icon2,
    Color? detailPrice,
  }) {
    return MyColors(
      borderGrey: borderGrey ?? this.borderGrey,
      divider: divider ?? this.divider,
      text: text ?? this.text,
      textField: textField ?? this.textField,
      icon: icon ?? this.icon,
      icon2: icon2 ?? this.icon2,
      bgAppbar: bgAppbar ?? this.bgAppbar,
      bgAppbar2: bgAppbar2 ?? this.bgAppbar2,
      hint: hint ?? this.hint,
      cart: cart ?? this.cart,
      detailPrice: detailPrice ?? this.detailPrice,
    );
  }

  @override
  ThemeExtension<MyColors> lerp(
      covariant ThemeExtension<MyColors>? other, double t) {
    if (other is! MyColors) {
      return this;
    }
    return MyColors(
      borderGrey: Color.lerp(borderGrey, other.borderGrey, t)!,
      divider: Color.lerp(divider, other.divider, t)!,
      text: Color.lerp(text, other.text, t)!,
      textField: Color.lerp(textField, other.textField, t)!,
      icon: Color.lerp(icon, other.icon, t)!,
      bgAppbar: Color.lerp(bgAppbar, other.bgAppbar, t)!,
      bgAppbar2: Color.lerp(bgAppbar2, other.bgAppbar2, t)!,
      hint: Color.lerp(hint, other.hint, t)!,
      cart: Color.lerp(cart, other.cart, t)!,
      icon2: Color.lerp(icon2, other.icon2, t)!,
      detailPrice: Color.lerp(detailPrice, other.detailPrice, t)!,
    );
  }
}

extension ThemeDataExtensions on ThemeData {
  MyColors get appColors => extension<MyColors>()!;
}
