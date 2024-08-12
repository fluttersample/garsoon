import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:waiter/Core/Helper/AppTypography.dart';
import 'package:waiter/Core/Helper/BaseBrain.dart';
import 'package:waiter/Core/Helper/ColorHelper.dart';
import 'package:waiter/Core/Helper/Globals/GlobalFunc.dart';
import 'package:waiter/Core/Helper/WaiterBasket.dart';
import 'package:waiter/Infrastructure/Navigation/CustomRoot.dart';
import 'package:waiter/Infrastructure/Navigation/Routes.dart';
import 'package:waiter/Presentation/Widgets/AppBars/CustomAppBar.dart';
import 'package:waiter/Presentation/Widgets/Buttons/CustomButton.dart';
import 'package:waiter/Presentation/Widgets/CustomBottomBar.dart';

import 'Controller/ReceiptBasket.Controller.dart';

class ReceiptBasketScreen extends GetView<ReceiptBasketController> {
  const ReceiptBasketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: controller,
      builder: (_) {
        return SelectionArea(
          child: Scaffold(
            bottomSheet: _buildBottomBar(),
            appBar:  CustomAppBar(
              title: 'بررسی سفارش',
              iconLeading: BaseBrain.isCustomer ? const SizedBox() : null,
              iconBack: const SizedBox.shrink(),
            ),
            body: Container(
              margin: const EdgeInsets.only(bottom: 70),
              child: SingleChildScrollView(
                  child: Center(
                child: Column(
                  children: [
                    _rabbitWidget(),
                    FadeInUp(
                      delay: const Duration(milliseconds: 500),
                      duration: const Duration(milliseconds: 500),
                      from: 20,
                      child: ReceiptView(
                        child: Container(
                          width: 250.0,
                          padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Tracking code
                              _receiptInfo(
                                  title: "شماره سفارش",
                                  context: context,
                                  text: controller.trackingCode != null
                                      ? controller.trackingCode!
                                      : '----'),

                              // Total amount
                              DashLineView(width: 235),
                              _receiptInfo(
                                  title: "مبلغ کل فاکتور",
                                  context: context,
                                  text: GlobalFunc.convertPrice(
                                      WaiterBasket.calculateCart(
                                          tempList: controller.tempListProduct))),

                              // Your profit
                              DashLineView(width: 235),
                              _receiptInfo(
                                title: "سود شما",
                                context: context,
                                text: GlobalFunc.convertPrice(
                                    WaiterBasket.calculateOffCart(
                                        tempList: controller.tempListProduct)),
                                textColor: const Color(0xffF94143),
                              ),

                              // Payable amount
                              DashLineView(width: 235),
                              _receiptInfo(
                                title: "مبلغ قابل پرداخت",
                                context: context,
                                text: GlobalFunc.convertPrice(
                                    WaiterBasket.calculatePayable(
                                        tempList: controller.tempListProduct)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    _buildPhoneNumber(context)
                  ],
                ),
              )),
            ),
          ),
        );
      },
    );
  }

  _buildBottomBar() {
    return FadeInUp(
      delay: const Duration(milliseconds: 1000),
      from: 20,
      child: CustomBottomBar(
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [

              !controller.fromIsEdit  ?  Text.rich(
              TextSpan(
                text: 'شماره میز : ',
                style:
                    AppTypography.s18.copyWith(fontFamily: FontsName.fontBold),
                children: [
                  TextSpan(
                      text: controller.tableName.TableCode,
                      style: AppTypography.s18
                          .copyWith(fontFamily: FontsName.fontMed))
                ]),
             ) : const SizedBox.shrink(),
             Visibility(
               visible: !BaseBrain.isGuest,
               child: CustomButton(
                onTap: () {
                controller.addOrderToQueue(showOrder: true);
                           },
                           width: 150,
                           text: 'مشاهده سفارش',
                         ),
             )
        ]),
      ),
    );
  }

  Widget _rabbitWidget() {
    return Stack(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeInDown(
              delay: const Duration(milliseconds: 300),
              duration: const Duration(milliseconds: 500),
              from: 20,
              child: Column(
                children: [
                  SizedBox(
                    width: 240.0,
                    height: 200.0,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 10),
                          child: Image.asset(
                            "assets/images/img_blob.png",
                            width: 250.0,
                          ),
                        ),
                        Image.asset(
                          "assets/images/successful_purchase.png",
                          width: 160.0,
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.done, color: ColorHelper.green, size: 30),
                  const SizedBox(
                    height: 15,
                  )
                ],
              ),
            ),
          ],
        ),
        Visibility(
          visible: !BaseBrain.isGuest,
          child: Positioned(
              top: 10,
              right: 10,
              child: IconButton(
                onPressed: () {
                  controller.addOrderToQueue();
                },
                icon: const Icon(Icons.close),
              )),
        )
      ],
    );
  }

  Widget _receiptInfo(
      {required String title, required String text, required BuildContext context,Color? textColor}) {
    return Container(
      height: 40.0,
      padding: const EdgeInsets.only(
        left: 15.0,
        right: 15.0,
      ),
      child: Row(
        children: [
          Text(title,
              style: AppTypography.s14.copyWith(
                fontFamily: FontsName.fontMed,
              )),
          const Spacer(),
          Text(text,
              style: AppTypography.s14.copyWith(
                color: textColor ,
                fontFamily: FontsName.fontMed,
              )),
        ],
      ),
    );
  }

  Widget _buildPhoneNumber(BuildContext context) {
    return Visibility(
      visible: !BaseBrain.isCustomer  && !controller.fromIsEdit,
      child: Column(
        children: [
          FadeInUp(
            from: 20,
            delay: const Duration(milliseconds: 700),
            child: Container(
              height: 50,
              width: 300,
              padding: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: ColorHelper.grey),
                  color: context.theme.appColors.cart
              ),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                    style: AppTypography.s16
                        .copyWith(fontFamily: FontsName.fontBold),
                    controller: controller.phoneNumberController,
                    keyboardType: TextInputType.number,
                    maxLength: 11,
                    decoration: InputDecoration(
                      hintText: 'شماره تماس مشتری',
                      hintStyle: AppTypography.s18.copyWith(
                          fontFamily: FontsName.fontReg,
                      ),
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      counterText: "",
                    ),
                  )),
                  InkResponse(
                    radius: 15,
                    onTap: () {
                      GlobalFunc.closeKeyboard();
                      controller.addOrderToQueue();
                    },
                    child: const Row(
                      children: [
                        VerticalDivider(color: ColorHelper.grey),
                        SizedBox(
                          width: 3,
                        ),
                        Icon(Icons.done, size: 30),
                        SizedBox(
                          width: 15,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          _buildTextInfo('ارسال لینک سفارش و مشاهده سفارش',context),
          const SizedBox(
            height: 8,
          ),
          _buildTextInfo('امکان پرداخت آنلاین سفارش',context),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }

  Widget _buildTextInfo(
    String text,
      BuildContext context
  ) {
    return FadeInUp(
      from: 20,
      delay: const Duration(milliseconds: 800),
      child: SizedBox(
        width: 300,
        child: Row(
          children: [
            Container(
              height: 6,
              width: 6,
              decoration:  ShapeDecoration(
                  shape: const CircleBorder(), color: context.theme.appColors.text),
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              text,
              style: AppTypography.s17.copyWith(
                fontFamily: FontsName.fontReg
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DashLineView extends StatelessWidget {
  final double? width;

  DashLineView({this.width});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DashLineCustomPaint(),
      size: Size(width != null ? width! : context.width, 1.0),
    );
  }
}

class DashLineCustomPaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    RRect backgroundRect = RRect.fromLTRBR(
        0, 0, size.width, size.height, const Radius.circular(0));

    drawDashedLine(
        canvas,
        Offset(backgroundRect.left, backgroundRect.height / 2),
        Offset(backgroundRect.right, backgroundRect.height / 2));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  Path getDashedPath({
    required Offset a,
    required Offset b,
    required gap,
  }) {
    Size size = Size(b.dx - a.dx, b.dy - a.dy);
    Path path = Path();
    path.moveTo(a.dx, a.dy);
    bool shouldDraw = true;
    Point currentPoint = Point(a.dx, a.dy);

    num radians = atan(size.height / size.width);

    num dx =
        cos(radians) * gap < 0 ? cos(radians) * gap * -1 : cos(radians) * gap;

    num dy =
        sin(radians) * gap < 0 ? sin(radians) * gap * -1 : sin(radians) * gap;

    while (currentPoint.x <= b.dx && currentPoint.y <= b.dy) {
      shouldDraw
          ? path.lineTo(currentPoint.x as double, currentPoint.y as double)
          : path.moveTo(currentPoint.x as double, currentPoint.y as double);
      shouldDraw = !shouldDraw;
      currentPoint = Point(
        currentPoint.x + dx * 1.5,
        currentPoint.y + dy * 1.5,
      );
    }
    return path;
  }

  void drawDashedLine(Canvas canvas, Offset start, Offset end) {
    Offset a, b;
    if (start.dy == end.dy) {
      a = start.dx < end.dx ? start : end;
      b = start.dx > end.dx ? start : end;
    } else {
      a = start;
      b = end;
    }
    Path path = getDashedPath(a: a, b: b, gap: 4);

    Paint dashLinePaint = Paint();
    dashLinePaint.color = const Color(0x1a000000);
    dashLinePaint.style = PaintingStyle.stroke;
    dashLinePaint.strokeWidth = 1.0;
    dashLinePaint.strokeCap = StrokeCap.round;

    canvas.drawPath(path, dashLinePaint);
  }
}

class ReceiptView extends StatelessWidget {
  final Widget? child;

  const ReceiptView({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ReceiptCustomPaint(bgColor: context.theme.appColors.cart),
      child: Container(
        child: child,
      ),
    );
  }
}

class ReceiptCustomPaint extends CustomPainter {

  final Color bgColor;

  ReceiptCustomPaint({super.repaint, required this.bgColor});
  @override
  void paint(Canvas canvas, Size size) {
    Paint backgroundPaint = Paint();
    backgroundPaint.color = bgColor;
    backgroundPaint.style = PaintingStyle.fill;

    Paint borderPaint = Paint();
    borderPaint.color = const Color(0x1a000000);
    borderPaint.style = PaintingStyle.stroke;
    borderPaint.strokeCap = StrokeCap.round;
    borderPaint.strokeWidth = 1.0;

    Path path = Path();

    path.lineTo(0, 0);
    double x = 0;
    double y = 0;
    double increment = size.width / 40;

    while (x < size.width) {
      x += increment;
      y = (y == 0) ? 6.0 : 0;
      path.lineTo(x, y);
    }

    path.lineTo(size.width, 0.0);

    y = size.height;

    path.lineTo(size.width, size.height);

    while (x > 0) {
      x -= increment;
      y = (y == size.height) ? size.height - 6.0 : size.height;
      path.lineTo(x, y);
    }

    path.close();

    canvas.drawPath(path, backgroundPaint);
    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
