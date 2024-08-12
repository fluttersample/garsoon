import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waiter/Core/Helper/ColorHelper.dart';
import 'package:waiter/Presentation/Widgets/Animations/AnimChangeNumber.dart';

class AddOrSubTracProduct extends StatelessWidget {
  const AddOrSubTracProduct(
      {super.key,
      required this.onAdd,
      required this.onSubtract,
      required this.count, this.height, this.width,
      });
  final Function onAdd;
  final Function onSubtract;
  final RxInt count;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildButton(),
          AnimChangeNumber(count: count),
          _buildButton(isPlus: false)
        ],
      ),
    );
  }

  _buildButton({bool isPlus = true}) {
    return InkWell(
      onTap: () {
        if (isPlus) {
          onAdd();
          return;
        }
        onSubtract();
      },
      child: Container(
        width: width??35,
        height: height??35,
        decoration: BoxDecoration(
          border: isPlus
              ? null
              : Border.all(
                  color: Colors.grey
                ),
          borderRadius: BorderRadius.circular(8),
          color: isPlus ? ColorHelper.red : Colors.white,
        ),
        child: Icon(isPlus ? Icons.add : Icons.remove,
            color: isPlus ? Colors.white : Colors.grey),
      ),
    );
  }
}
