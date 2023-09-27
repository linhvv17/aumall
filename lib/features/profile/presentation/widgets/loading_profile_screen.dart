import 'package:aumall/app/widgets/skeleton.dart';
import 'package:aumall/features/shopping/presentation/widgets/loading_shopping_product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/utilities/mediaquery.dart';

class LoadingProfileScreen extends StatelessWidget {
  const LoadingProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 5,
              ),
              const Center(child: Skeleton(100, 100)),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: SizedBox(
                  child: Column(
                    children: [
                      Skeleton(80, 15),
                      SizedBox(
                        height: 4,
                      ),
                      Skeleton(120, 15),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 3,
              ),
              ListTile(
                  title: const Skeleton(80, 15),
                  subtitle: SizedBox(
                    width: kWidth(context) / 4,
                    child: const Skeleton(120, 15),
                  ),
                  dense: true,
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                    color: Colors.black.withOpacity(0.04),
                  )),
              ListTile(
                  title: const Skeleton(80, 15),
                  subtitle: SizedBox(
                    width: kWidth(context) / 4,
                    child: const Skeleton(120, 15),
                  ),
                  dense: true,
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                    color: Colors.black.withOpacity(0.04),
                  )),
              ListTile(
                  title: const Skeleton(80, 15),
                  subtitle: SizedBox(
                    width: kWidth(context) / 4,
                    child: const Skeleton(120, 15),
                  ),
                  dense: true,
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                    color: Colors.black.withOpacity(0.04),
                  )),
              ListTile(
                  title: const Skeleton(80, 15),
                  subtitle: SizedBox(
                    width: kWidth(context) / 4,
                    child: const Skeleton(120, 15),
                  ),
                  dense: true,
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                    color: Colors.black.withOpacity(0.04),
                  )),
              ListTile(
                  title: const Skeleton(80, 15),
                  subtitle: SizedBox(
                    width: kWidth(context) / 4,
                    child: const Skeleton(120, 15),
                  ),
                  dense: true,
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                    color: Colors.black.withOpacity(0.04),
                  )),
              ListTile(
                  title: const Skeleton(80, 15),
                  subtitle: SizedBox(
                    width: kWidth(context) / 4,
                    child: const Skeleton(120, 15),
                  ),
                  dense: true,
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                    color: Colors.black.withOpacity(0.04),
                  )),
              ListTile(
                  title: const Skeleton(80, 15),
                  subtitle: SizedBox(
                    width: kWidth(context) / 4,
                    child: const Skeleton(120, 15),
                  ),
                  dense: true,
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                    color: Colors.black.withOpacity(0.04),
                  )),

            ],
          ),
        ),
      ),
    );
  }
}
