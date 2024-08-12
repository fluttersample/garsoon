import 'package:flutter/material.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:waiter/Core/Helper/AppTypography.dart';
import 'package:waiter/Core/Helper/ColorHelper.dart';
import 'package:waiter/Core/Helper/Globals/GlobalFunc.dart';

class PriceWidget {
  int price;
  int offPrice;
  bool showCurrency;
  bool showPercent;
  Color? staticColor;

  PriceWidget(
      {required this.price,
      this.offPrice = 0,
      this.showCurrency = true,
      this.showPercent = true,
      this.staticColor});

  init() {
    if (offPrice > 0) {
      return SizedBox(
        height: _setPriceWidgetHeight(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: [
                    Visibility(
                      visible: showCurrency,
                      child: Image.asset(
                        'assets/images/ic_toman.png',
                        height: 15,
                        width: 15,
                        color: _setCurrencyColor(),
                      ),
                    ),
                    Visibility(
                      visible: showCurrency,
                      child: const SizedBox(
                        width: 4.0,
                      ),
                    ),
                    Text(
                      "$price".toPersianDigit().seRagham(),
                      style: AppTypography.s12.copyWith(
                        fontFamily: FontsName.fontReg,
                        height: 1.1,
                        color: _setOffPriceColor(),
                      )
                    ),
                  ],
                ),
                Text(
                  (price - offPrice).toString().toPersianDigit().seRagham(),
                  style: const TextStyle(
                    fontSize: 12,
                    fontFamily: "Vazir Bold",
                     
                    color: ColorHelper.red,
                    height: 1.1,
                  ),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
            const SizedBox(
              width: 5.0,
            ),
            Visibility(
              visible: showPercent,
              child: buildPercent(),
            ),
          ],
        ),
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Visibility(
            visible: showCurrency,
            child: Image.asset(
                'assets/images/ic_toman.png',
              height: 15,
              width: 15,
              color: _setCurrencyColor(),
            ),
          ),
          Visibility(
            visible: showCurrency,
            child: const SizedBox(
              width: 4.0,
            ),
          ),
          AutoSizeText(
              price.toString().toPersianDigit().seRagham(),
            maxLines: 1,
            minFontSize: 8.0,
            style: AppTypography.s16.copyWith(
            fontFamily: FontsName.fontBold,
            color: ColorHelper.red,
            )
          ),
        ],
      );
    }
  }

  Widget buildPercent({bool hideSizeBox = false}) {
    return Column(
      children: [
        Container(
          width: _setCurrencyBorderWidth(),
          height: _setCurrencyBorderHeight(),
          decoration: BoxDecoration(
            border: Border.all(
              color: ColorHelper.red,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Center(
            child: Text(
              setProductOffPercentage(),
              style: TextStyle(
                color: ColorHelper.red,
                fontSize: _setPercentFontSize(),
                fontFamily: "Vazir Bold",
                 
              ),
            ),
          ),
        ),
        Visibility(
          visible: hideSizeBox == false,
          child: const SizedBox(
            height: 4.0,
          ),
        ),
      ],
    );
  }

  setProductOffPercentage() {
    int percent = ((100 * offPrice) / price).round();
    return "$percent%";
  }

  Color _setOffPriceColor() {
    return Colors.grey;
  }

  Color _setCurrencyColor() {
    return staticColor ?? Colors.grey.shade800;
  }

  double _setPercentFontSize() {
    return 14.0;
  }

  double _setCurrencyFontSize() {
    return 14.0;
  }

  double _setCurrencyBorderWidth() {
    return 34.0;
  }

  double _setCurrencyBorderHeight() {
    return 27.0;
  }

  double _setPriceWidgetHeight() {
    return 32.0;
  }
}
