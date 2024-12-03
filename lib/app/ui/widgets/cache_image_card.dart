import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CommonCachedImageCard extends StatelessWidget {
  final String image;
  final double height;
  final double width;
  final BoxFit fit;
  final bool isNotification;
  final String placeholder;

  const CommonCachedImageCard({
    super.key,
    required this.image,
    this.height = 0,
    this.width = 0,
    this.fit = BoxFit.cover,
    this.isNotification = false,
    this.placeholder = '',
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: image,
      height: height,
      width: width,
      fit: fit,
      errorWidget: (context, url, error) {
        return Image.asset('assets/images/placeholder.jpg', fit: fit);
      },
      progressIndicatorBuilder: (context, _, __) {
        return Center(
            child: SizedBox(
                height: 30,
                width: 30,
                child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor, strokeWidth: 1)));
      },
    );
  }
}
