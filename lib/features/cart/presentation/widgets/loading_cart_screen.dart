import 'package:flutter/material.dart';
import 'cart_item_loading.dart';

class LoadingCartScreen extends StatelessWidget {
  const LoadingCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 22),
      itemCount: 4,
      itemBuilder: (context, index) {
        return const CartItemLoading();
      },
    );
  }
}
