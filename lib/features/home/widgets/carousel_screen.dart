import 'package:aumall/features/home/data/models/banner_model.dart';
import 'package:flutter/material.dart';


// Main page of the widget (Carousel)
class CarouselScreen extends StatefulWidget {
  final List<ImageEntity> images;
  const CarouselScreen({
    Key? key, required this.images,
  }) : super(key: key);

  @override
  State<CarouselScreen> createState() => _CarouselScreenState();
}

class _CarouselScreenState extends State<CarouselScreen> {
  int activePage = 0;
  late PageController _pageController;


  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.8, initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 250,
            child: PageView.builder(
                itemCount: widget.images.length,
                pageSnapping: true,
                controller: _pageController,
                onPageChanged: (page) {
                  setState(() => activePage = page);
                },
                itemBuilder: (context, pagePosition) {
                  bool active = pagePosition == activePage;
                  return slider(widget.images, pagePosition, active);
                }),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: imageIndicator(widget.images.length, activePage),
          ),
        ),
      ],
    );
  }
}

// Animated container widget
AnimatedContainer slider(images, pagePosition, active) {
  double margin = active ? 10 : 20;

  return AnimatedContainer(
    duration: const Duration(milliseconds: 500),
    curve: Curves.easeInOutCubic,
    margin: EdgeInsets.all(margin),
    decoration: BoxDecoration(
      image: DecorationImage(
        image: NetworkImage(
          (images[pagePosition]as ImageEntity).src,
        ),
        fit: BoxFit.cover,
      ),
    ),
  );
}

// Widget for image animation while sliding carousel
imageAnimation(PageController animation, images, pagePosition) {
  return AnimatedBuilder(
    animation: animation,
    builder: (context, widget) {
      return SizedBox(
        width: 200,
        height: 200,
        child: widget,
      );
    },
    child: Container(
      margin: const EdgeInsets.all(10),
      child: Image.network(images[pagePosition]),
    ),
  );
}

// Widget for showing image indicator
List<Widget> imageIndicator(imagesLength, currentIndex) {
  return List<Widget>.generate(imagesLength, (index) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 4),
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color: currentIndex == index ? Colors.teal.shade400 : Colors.black26,
        shape: BoxShape.circle,
      ),
    );
  });
}