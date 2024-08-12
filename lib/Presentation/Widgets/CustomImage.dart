import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'ImagePlaceHolder.dart';

class CustomImage extends StatelessWidget {
  const CustomImage(
      {super.key,
      required this.url,
      this.height,
      this.width,
      this.boxFit,
      this.borderRadius = 15,
      this.staticImage = false});
  final String url;
  final double? height;
  final double? width;
  final double? borderRadius;
  final BoxFit? boxFit;
  final bool? staticImage;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius ?? 0.0),
      child: staticImage== true ? Image.asset('assets/images/peach.jpg',
      height: height,
      fit: boxFit??BoxFit.cover,
      width: width,):CachedNetworkImage(
        imageUrl: url,
        height: height,
        width: width,
        fit: boxFit??BoxFit.cover,
        placeholder: (_, __) =>  ImagePlaceHolder(height: height,
        borderRadius: borderRadius,
        isError: false),
        errorWidget: (_,__,___) =>  ImagePlaceHolder(height: height,
        borderRadius: borderRadius,
        isError: true),
      ),
    );
  }
}
