import 'package:flutter/material.dart';

class FloatingActionButtonWidget extends StatelessWidget {
  final Color backgroundColor;
  final Icon child;
  final Future Function() onPress;
  const FloatingActionButtonWidget({
    Key? key,
    required this.backgroundColor,
    required this.child,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15, bottom: 15),
      child: Align(
          alignment: Alignment.bottomRight,
          child: FloatingActionButton(
            backgroundColor: backgroundColor,
            child: child,
            onPressed: onPress,
          )),
    );
  }
}
