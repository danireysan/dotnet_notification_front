import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ProgressHUD extends StatelessWidget {
  final Widget? child;
  final Widget? subtitle;
  final bool? inAsyncCall;
  final double? opacity;
  final Color? color;
  final Animation<Color>? valueColor;

  const ProgressHUD({
    super.key,
    required this.child,
    this.subtitle,
    required this.inAsyncCall,
    this.color = Colors.black,
    this.valueColor,
    this.opacity = 0.3,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = [];
    widgetList.add(child!);
    if (inAsyncCall!) {
      final modal = Stack(
        children: [
          Opacity(
            opacity: 0.3,
            child: ModalBarrier(dismissible: false, color: color),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LoadingAnimationWidget.fourRotatingDots(
                  color: color!,
                  size: 50,
                ),
                if (subtitle != null) ...[SizedBox(height: 16), subtitle!],
              ],
            ),
          ),
        ],
      );
      widgetList.add(modal);
    }
    return Stack(children: widgetList);
  }
}
