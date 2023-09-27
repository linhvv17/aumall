import 'package:flutter/material.dart';

class Skeleton extends StatelessWidget {
  const Skeleton(this.width, this.height, {super.key});
  final double? width;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.04),
        borderRadius: const BorderRadius.all(Radius.circular(16))
      ),
    );
  }

}