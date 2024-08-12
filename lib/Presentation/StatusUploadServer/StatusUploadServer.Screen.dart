import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waiter/Core/Dto/Models/export_models.dart';
import 'package:waiter/Core/Helper/AppTypography.dart';
import 'package:waiter/Core/Helper/ColorHelper.dart';

import 'package:waiter/Presentation/Widgets/AppBars/CustomAppBar.dart';
import 'Controller/StatusUploadServer.Controller.dart';

class StatusUploadServerScreen extends GetView<StatusUploadServerController>{
  const StatusUploadServerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: controller,
      builder: (_) {
        return SelectionArea(
          child: Scaffold(
            appBar: const CustomAppBar(
              title: 'درحال ارسال به سرور',
            ),
            body: controller.listQueue.isEmpty ?
            const Center(child: Text('دیتا وجود ندارد  !'))
                :ListView.builder(
              itemCount: controller.listQueue.length,
              padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 30),
              itemBuilder: (_, index) {
                final item = controller.listQueue[index];
              return _buildItem(item,context);
            },)
          ),
        );
      },);
  }


  Widget _buildItem(InsertOrderRequestModel item, BuildContext context){
    return Container(
      height: 85,
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color(0xffD8D8D8),)
      ),
      padding: const EdgeInsets.only(right: 10,top: 8,left: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(item.StatusOrder == 0? 'ثبت سفارش' : 'تغییر در سفارش',
              style: AppTypography.s18.copyWith(
                fontFamily: FontsName.fontBold
              ),),
              Text(item.StatusSend ==  0?'درحال ارسال به سرور' : 'خطا در ارتباط با سرور',
                style: AppTypography.s14.copyWith(
                  color: Colors.grey
                ),),

            ],
          ),
          const SizedBox(height: 8,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            RichText(
                text: TextSpan(
                  style: AppTypography.s18.copyWith(
                      fontFamily: FontsName.fontBold,
                      color: context.theme.appColors.text
                  ),
                  text: 'میز  ',
                  children: [
                    TextSpan(
                      style: AppTypography.s18.copyWith(
                          fontFamily: FontsName.fontBold,
                          color: context.theme.appColors.text
                      ),
                      text: item.TableName,

                    )
                  ]
                ),
            ),
              _buildStatusIcon(item.StatusSend??1)

          ],)

        ],
      ),
    );
  }


  Widget _buildStatusIcon(int status){

    if(status == 1){
      return Container(
        margin: const EdgeInsets.only(left: 50),
        child: Image.asset('assets/images/ic_error_sync.png',height: 24,
        width: 24,),
      );
    }
    return Container(
      margin: const EdgeInsets.only(left: 50),
      child: Image.asset('assets/images/ic_sync.png',width: 24,
      height: 24,),
    );
  }

}