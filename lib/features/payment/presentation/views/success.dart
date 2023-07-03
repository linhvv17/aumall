
import 'package:flutter/material.dart';
import 'package:aumall/core/utilities/mediaquery.dart';
import 'package:aumall/core/utilities/routes.dart';
import 'package:aumall/core/utilities/strings.dart';

import '../../../../generated/l10n.dart';

class SuccessView extends StatelessWidget {
  const SuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SizedBox(
        width: kWidth(context)/1.12,
        height: kHeight(context) / 12,
        child: FloatingActionButton.extended(
            onPressed: () {
              Navigator.pushReplacementNamed(context, AppRoutes.layout);
            },
            label:  Text(S.current.continueShopping)),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset('assets/images/success.png'),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "${S.current.success}!",
            style: Theme.of(context).textTheme.headline5,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(S.current.successMsg,
              style: Theme.of(context).textTheme.bodyMedium)
        ],
      ),
    );
  }
}
