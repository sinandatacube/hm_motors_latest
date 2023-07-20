import 'package:flutter/material.dart';
import 'package:hm_motors/url.dart';
import 'package:photo_view/photo_view.dart';

class Photoview extends StatelessWidget {
  final List images;
  final int index;
  Photoview({
    Key? key,
    required this.images,
    required this.index,
  }) : super(key: key);
  late PageController _controller;
  @override
  Widget build(BuildContext context) {
    _controller = PageController(initialPage: index);
    return Scaffold(
        appBar: AppBar(),
        body: PageView.builder(
            controller: _controller,
            itemCount: images.length,
            itemBuilder: (context, index) {
              return PhotoView(
                  minScale: PhotoViewComputedScale.contained,
                  maxScale: PhotoViewComputedScale.covered,
// loadingBuilder: ,
// errorBuilder: ,
                  imageProvider:
                      NetworkImage(budgetImagePath + images[index]["Car_Image"])
                  // NetworkImage(imgUrl),
                  );
            }));
  }
}
