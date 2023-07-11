import 'package:aumall/features/home/data/models/banner_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';


import '../../../core/colors/colors.dart';
import '../../../core/utilities/mediaquery.dart';
import '../../../generated/l10n.dart';
import '../../login/presentation/widgets/mainbutton.dart';

class BannerAds extends StatefulWidget {
  final List images;
  const BannerAds({
    super.key,
    required this.images
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
    final imageURL = (widget.images[0][1] as ImageModel).src;
    final imageURL2 = (widget.images[0][2] as ImageModel).src;
    return CarouselSlider(
      items: createListBanner(widget.images),
      options: CarouselOptions(
        autoPlay: true,
        viewportFraction: 1,
        height: kHeight(context) * 0.3,
      ),
    );
  }



  createListBanner (List images){
    var banners  = <Image>[];
    // // var list = List<int>.generate(images.length, (i) =>i + 1 );
    for (int i = 0 ; i  < images[0].length; i++) {
      var img  = Image.network((widget.images[0][i] as ImageModel).src);
      print('createListBanner ${(widget.images[0][i] as ImageModel).src} ');
      banners.add(img);
    }
    print('createListBanner ${images[0].length} ');
    // final imageURL0 = (widget.images[0][0] as ImageModel).src;
    // final imageURL1 = (widget.images[0][1] as ImageModel).src;
    // final imageURL2 = (widget.images[0][2] as ImageModel).src;
    // banners.add(Image.network(imageURL0));
    // banners.add(Image.network(imageURL1));
    // banners.add(Image.network(imageURL2));
    return banners;
  }


}
