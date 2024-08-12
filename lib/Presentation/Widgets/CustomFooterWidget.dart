
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:waiter/Core/Helper/AppTypography.dart';


import 'LoadingWidget.dart';

class CustomFooterWidget extends StatelessWidget {
  const CustomFooterWidget({super.key, required this.onTap});
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return CustomFooter(
      builder: (context, mode) {
        Widget body;
        if (mode == LoadStatus.loading) {
          body = const LoadingWidget();
        } else {
          body = const SizedBox();
          if(kIsWeb && mode != LoadStatus.noMore){
            body= OutlinedButton(
              onPressed: onTap,
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.all(8),
                fixedSize: const Size(120,35),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                textStyle: AppTypography.s15.copyWith(
                  fontFamily: FontsName.fontMed
                )
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('دیدن بیشتر',),
                  SizedBox(width: 4,),
                  Icon(Icons.add,size: 22,)
                ],
              ),


            );
          }
        }
        return SizedBox(
          height: 55.0,
          child: Center(child: body),
        );
      },
    );
  }
}
