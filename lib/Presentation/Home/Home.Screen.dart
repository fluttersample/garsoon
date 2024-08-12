import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waiter/Core/Helper/AppTypography.dart';
import 'package:waiter/Core/Helper/ArgName.dart';
import 'package:waiter/Core/Helper/ColorHelper.dart';
import 'package:waiter/Core/Helper/Globals/GlobalFunc.dart';
import 'package:waiter/Infrastructure/Navigation/CustomRoot.dart';
import 'package:waiter/Infrastructure/Navigation/Routes.dart';
import 'package:waiter/Presentation/Home/Controller/Home.Controller.dart';
import 'package:waiter/Presentation/Widgets/AppBars/CustomAppBar.dart';
import 'package:waiter/Presentation/Widgets/CustomDivider.dart';
import 'package:waiter/Presentation/Widgets/Dialogs/CustomDialogWidget.dart';
import 'package:waiter/Presentation/Widgets/LoadingWidget.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: controller,
      builder: (_) {
        return SelectionArea(
          child: Scaffold(
            floatingActionButton: kDebugMode
                ? Row(
              mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FloatingActionButton(
                      heroTag: UniqueKey(),
                      key: UniqueKey(),
                        onPressed: () {
                        },
                      child: const Icon(Icons.remove),
                      ),
                    const SizedBox(width: 14,),
                    // FloatingActionButton(
                    //   onPressed: () {
                    //
                    //
                    //   },
                    //   child: Icon(Icons.add),
                    // )
                  ],
                )
                : null,
            appBar: CustomAppBar(
              withDivider: false,
              titleWidget: _buildSelectedShopWidget(context) ,
              iconLeading: InkResponse(
                radius: 10,
                onTap: () {
                  controller.checkShopIsSelected(func: () {
                    CustomRoot.toNamed(Routes.StatusUploadServer);
                  });
                },
                child: Image.asset(
                  'assets/images/ic_cloud_upload.png',
                  height: 15,
                  color: context.theme.appColors.icon,
                  width: 15,
                ),
              ),
              iconBack: InkResponse(
                radius: 10,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return CustomDialogWidget(
                        height: 200,
                        btnOkOnTap: (){
                          GlobalFunc.logout();
                        },
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 32, vertical: 20),
                              child: Image.asset(
                                'assets/images/img_warning.png',
                                height: 100.0,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 8.0),
                              child: Text(
                                "آیا می خواهید از حساب کاربری خود خارج شوید؟",
                                style: AppTypography.s17.copyWith(
                                  fontFamily: FontsName.fontMed,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: Image.asset(
                  'assets/images/ic_logout.png',
                  width: 24,
                  color: context.theme.appColors.icon,
                  height: 24,
                ),
              ),
            ),
            body: DoubleBackToCloseApp(
              snackBar:  const SnackBar(
                content: Text(
                  "لطفا برای خروج مجددا ضربه بزنید",
                  style: TextStyle(fontFamily: FontsName.fontReg, ),
                  textAlign: TextAlign.center,
                ),
                duration: Duration(milliseconds: 1500),
              ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(15),
                      onTap: () {
                        controller.checkShopIsSelected(func: () {
                          CustomRoot.toNamed(Routes.TableCustomer);
                        });
                      },
                      child: Container(
                        height: 180,
                        width: 180,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: context.theme.appColors.borderGrey)),
                        padding: const EdgeInsets.all(10),
                        child: Image.asset('assets/images/img_table.png'),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const CustomDivider(
                      width: 220,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(15),
                      onTap: () {
                        controller.checkShopIsSelected(func: () {
                          CustomRoot.toNamed(Routes.Orders);
                        });
                      },
                      child: Container(
                        height: 180,
                        width: 180,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: context.theme.appColors.borderGrey)),
                        padding: const EdgeInsets.all(10),
                        child: Image.asset('assets/images/img_food_waiter.png'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget  _buildSelectedShopWidget(BuildContext context) {
    if(controller.getShops.isEmpty){
      if(controller.isLoading){
        return const SizedBox(
            height: 25,
            width: 25,
            child: LoadingWidget());
      }
      return const SizedBox.shrink();
    }
    if(controller.getShops.length == 1){
      return const SizedBox.shrink();
    }
    return  Container(
      margin: const EdgeInsets.only(top: 4),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
            foregroundColor: context.theme.appColors.text),
        onPressed: () {
          controller.showDialogSelectShop();
        },
        child:  Text('انتخاب رستوران',
            style: AppTypography.s14.copyWith(
                fontFamily: FontsName.fontMed
            )),
      ),
    );


  }
}
