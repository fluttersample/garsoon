
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:waiter/Infrastructure/Navigation/CustomRoot.dart';
import 'package:waiter/Infrastructure/Navigation/Routes.dart';

class DeveloperButton extends StatelessWidget {
  const DeveloperButton({super.key});

  @override
  Widget build(BuildContext context) {
    return  kDebugMode ? Container(
      width: 80,
      margin: const EdgeInsets.only(left: 15,),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            fixedSize: const Size.fromHeight( 30)
        ),
        onPressed: (){
          CustomRoot.toNamed(Routes.DEVELOPER_TOOLS);
        },
        child: const Center(child: Icon(Icons.developer_mode_rounded)),),
    ) : const SizedBox();
  }
}
