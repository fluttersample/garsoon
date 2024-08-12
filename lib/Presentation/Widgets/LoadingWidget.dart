import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return _loading;
  }

  Widget get _loading =>
      const Center(
        child: CircularProgressIndicator(),
      );
}
