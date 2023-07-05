import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';


import '../../../core/colors/colors.dart';
import '../../../core/utilities/mediaquery.dart';
import '../../../generated/l10n.dart';
import '../../login/presentation/widgets/mainbutton.dart';

class BannerAds extends StatefulWidget {
  // final List images;
  const BannerAds({
    super.key,
    // required this.images
  });


  // images: [
  // ImageEntity(
  // "products/tozb2ip8bczwrfdkog2u",
  // "https://res.cloudinary.com/dqqtsxgyx/image/upload/v1673780373/products/tozb2ip8bczwrfdkog2u.webp"
  // ),
  // ImageEntity(
  // "products/j25amoybqh7bxwixnjlu",
  // "https://res.cloudinary.com/dqqtsxgyx/image/upload/v1673780374/products/j25amoybqh7bxwixnjlu.webp"
  // )
  // ]

  @override
  State<BannerAds> createState() => _BannerAdsState();
}

class _BannerAdsState extends State<BannerAds> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: [
        Stack(children: [
          Container(
            width: kWidth(context),
            height: kHeight(context) * 0.5,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/header.png"),
                    fit: BoxFit.cover)),
          ),
          Container(
              width: kWidth(context),
              height: kHeight(context) * 0.5,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/opacity.png"),
                      fit: BoxFit.cover))),
          Positioned(
            bottom: kHeight(context) * 0.05,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.current.headerTitle,
                  style: Theme.of(context)
                      .textTheme
                      .headline4!
                      .copyWith(color: ColorManager.white),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  S.current.headerSuTitle,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: ColorManager.white.withOpacity(0.9),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                    width: 200,
                    child: MainButton(
                        text: S.current.check, height: 40, ontab: () {}))
              ],
            ),
          ),
        ]),
        Stack(children: [
          Container(
            width: kWidth(context),
            height: kHeight(context) * 0.5,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/header.png"),
                    fit: BoxFit.cover)),
          ),
          Container(
              width: kWidth(context),
              height: kHeight(context) * 0.5,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/opacity.png"),
                      fit: BoxFit.cover))),
          Positioned(
            bottom: kHeight(context) * 0.05,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.current.headerTitle,
                  style: Theme.of(context)
                      .textTheme
                      .headline4!
                      .copyWith(color: ColorManager.white),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  S.current.headerSuTitle,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: ColorManager.white.withOpacity(0.9),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                    width: 200,
                    child: MainButton(
                        text: S.current.check, height: 40, ontab: () {}))
              ],
            ),
          ),
        ]),
        Stack(children: [
          Container(
            width: kWidth(context),
            height: kHeight(context) * 0.5,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/header.png"),
                    fit: BoxFit.cover)),
          ),
          Container(
              width: kWidth(context),
              height: kHeight(context) * 0.5,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/opacity.png"),
                      fit: BoxFit.cover))),
          Positioned(
            bottom: kHeight(context) * 0.05,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.current.headerTitle,
                  style: Theme.of(context)
                      .textTheme
                      .headline4!
                      .copyWith(color: ColorManager.white),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  S.current.headerSuTitle,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: ColorManager.white.withOpacity(0.9),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                    width: 200,
                    child: MainButton(
                        text: S.current.check, height: 40, ontab: () {}))
              ],
            ),
          ),
        ]),
      ],
      options: CarouselOptions(
        autoPlay: true,
        viewportFraction: 1,
        height: kHeight(context) * 0.4,
      ),
    );
  }
}
