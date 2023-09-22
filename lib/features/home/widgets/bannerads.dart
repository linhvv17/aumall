import 'package:aumall/features/home/data/models/banner_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../../../core/utilities/mediaquery.dart';
class BannerAds extends StatefulWidget {
  final List images;
  const BannerAds({super.key, required this.images});

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
      items: createListBanner(widget.images),
      options: CarouselOptions(
        autoPlay: true,
        viewportFraction: 1,
        height: kHeight(context) * 0.3,
      ),
    );
  }

  createListBanner(List images) {
    var banners = <Image>[];
    // // var list = List<int>.generate(images.length, (i) =>i + 1 );
    for (int i = 0; i < images[0].length; i++) {
      var img = Image.network((widget.images[0][i] as ImageModel).src);
      banners.add(img);
    }
    return banners;
  }
}
