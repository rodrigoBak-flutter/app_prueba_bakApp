import 'package:flutter/cupertino.dart';

class PageAnimationRoutes extends PageRouteBuilder {
  final Widget widget;

  PageAnimationRoutes({
    required this.widget,
  }) : super(
            transitionDuration: const Duration(milliseconds: 500),
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secAnimation,
                Widget child) {
              animation =
                  CurvedAnimation(parent: animation, curve: Curves.easeOutBack);
              return ScaleTransition(
                scale: animation,
                child: child,
              );
            },
            pageBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secAnimation,
            ) {
              return widget;
            });
}
