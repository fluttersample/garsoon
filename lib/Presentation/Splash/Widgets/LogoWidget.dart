

import 'package:flutter/material.dart';

class LogoWidget extends StatefulWidget {
  const LogoWidget({super.key});

  @override
  State<LogoWidget> createState() => _LogoWidgetState();
}

class _LogoWidgetState extends State<LogoWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnim ;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this,
      duration: const Duration(milliseconds: 300),
    )..forward();
    _slideAnim = Tween<Offset>(
    begin:  const Offset(0.0, 0.1),
    end: Offset.zero,
  ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(animation: _controller,
        builder: (context, child) {
          return  FadeTransition(
            opacity: Tween<double>(begin: 0.0,end: 1.0).animate(_controller),
            child: SlideTransition(
              position: _slideAnim,
              child:  Padding(
                padding: const EdgeInsets.all(8.0),
                child:   Padding(
                  padding: const EdgeInsets.all(70),
                  child: Center(
                    child: Image.asset(
                      'assets/images/3soot_logo.png',
                    ),
                  ),
                ),
              ),
            ),
          );
        },);
  }
}
