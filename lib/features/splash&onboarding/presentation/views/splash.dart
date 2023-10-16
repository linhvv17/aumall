import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:aumall/core/colors/colors.dart';
import 'package:aumall/core/utilities/endpoints.dart';
import 'package:aumall/core/utilities/routes.dart';
import '../../../../core/local/shared_preference.dart';
import '../../../../generated/l10n.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  SplashViewState createState() => SplashViewState();
}

class SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  var _visible = true;

  AnimationController? animationController;
  Animation<double>? animation;

  startTime() async {
    var duration = const Duration(seconds: 1);
    return Timer(duration, navigationPage);
  }

  void navigationPage() {
    isLoggedIN =
        PreferenceHelper.getDataFromSharedPreference(key: 'IsLoggedIn');
    if (kDebugMode) {
      print("isLoggedIN $isLoggedIN");
    }
    isLoggedIN == true
        ? Navigator.of(context)
            .pushNamedAndRemoveUntil(AppRoutes.layout, (Route route) => false)
        : Navigator.pushReplacementNamed(context, AppRoutes.login);
  }

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    animation =
        CurvedAnimation(parent: animationController!, curve: Curves.easeOut);

    animation!.addListener(() => setState(() {}));
    animationController!.forward();

    setState(() {
      _visible = !_visible;
    });
    startTime();
  }

  @override
  void dispose() {
    animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo.png',
                width: animation!.value * 200,
                height: animation!.value * 200,
              ),
              const SizedBox(
                height: 18,
              ),
              Text(
                S.current.appName,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: ColorManager.orangeLight,
                    ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
