import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hm_motors/model/homepage_model.dart';

import '../../url.dart';

class AdsSlider extends StatefulWidget {
  final List<OfferwallModel> imagesList;
  const AdsSlider({super.key, required this.imagesList});

  @override
  State<AdsSlider> createState() => _AdsSliderState();
}

class _AdsSliderState extends State<AdsSlider> {
  double currentIndexPage = 0;
  @override
  Widget build(BuildContext context) {
    // print("images");
    // print(images);
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: CarouselSlider.builder(
          itemCount: widget.imagesList.length,
          itemBuilder: (context, index, i) {
            var current = widget.imagesList[index];
            return ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: CachedNetworkImage(
                memCacheWidth: 800,
                imageUrl: offerwallImagePath + current.wallImg,
                errorWidget: (context, url, error) =>
                    Image.asset("assets/noImages.png"),
                placeholder: (context, url) =>
                    Image.asset("assets/placeholder.png"),
              ),
            );

            // Image.asset(
            //   ads[index]["image"],
            //   fit: BoxFit.cover,
            // ));
          },
          options: CarouselOptions(
            viewportFraction: 1,
            pauseAutoPlayOnManualNavigate: true,
            aspectRatio: 16 / 9,
            autoPlay: true,
            enlargeCenterPage: true,
            scrollPhysics: const AlwaysScrollableScrollPhysics(),
            autoPlayInterval: const Duration(seconds: 3),
          )),
    );
  }
}
