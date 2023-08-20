import 'package:aumall/core/utilities/strings.dart';

import '../../../../generated/l10n.dart';

class OnBoardingContents {
  final String title;
  final String image;
  final String desc;

  OnBoardingContents({
    required this.title,
    required this.image,
    required this.desc,
  });
}

List<OnBoardingContents> contents = [
  OnBoardingContents(
    title: S.current.onBoardingTitle1,
    image: "assets/images/1.png",
    desc: S.current.onBoardingSubTitle1,
  ),
  OnBoardingContents(
    title: S.current.onBoardingTitle2,
    image: "assets/images/sale.png",
    desc: S.current.onBoardingSubTitle2,
  ),
  OnBoardingContents(
    title: S.current.onBoardingTitle3,
    image: "assets/images/payment.png",
    desc: S.current.onBoardingSubTitle3,
  ),
  OnBoardingContents(
    title: S.current.onBoardingTitle4,
    image: "assets/images/delivery.png",
    desc: S.current.onBoardingSubTitle4,
  ),
];
