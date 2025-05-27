import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mawidak/core/component/image/p_image.dart';
import 'package:mawidak/features/home/data/model/banner_response_model.dart';

class PCarousel extends StatefulWidget {
  final List<BannerData> itemList;
  const PCarousel({super.key,required this.itemList});

  @override
  State<PCarousel> createState() => _PCarouselState();
}

class _PCarouselState extends State<PCarousel> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height:130,width:MediaQuery.sizeOf(context).width,
          child: CarouselSlider(
            options: CarouselOptions(
              autoPlay: true,
              enlargeCenterPage: true,
              viewportFraction:1,
              aspectRatio: 2.0,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              enableInfiniteScroll: false,
              pauseAutoPlayOnTouch: true,
              onPageChanged: (index, reason) {
                setState(() {
                  currentIndex = index;
                });
              },
            ),
            items: widget.itemList.map((item) => SizedBox(
                height:120,width:MediaQuery.sizeOf(context).width,
                child: ClipRRect(borderRadius: BorderRadius.circular(16),
                  child: PImage(source: item.image ?? '',fit: BoxFit.fill,
                  ),
                ))).toList(),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.itemList.asMap().entries.map((entry) {
            return AnimatedContainer(
              duration: Duration(milliseconds: 300),
              // width: currentIndex == entry.key ? 12.0 : 8.0,
              width:  8.0,
              height:  8.0,
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: currentIndex == entry.key
                    ? Colors.blueAccent
                    : Colors.grey.shade400,
              ),
            );
          }).toList(),
        )
      ],
    );
  }
}
