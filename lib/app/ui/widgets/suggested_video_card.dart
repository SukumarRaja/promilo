import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'cache_image_card.dart';

class SuggestedVideoCard extends StatelessWidget {
  const SuggestedVideoCard(
      {super.key,
      required this.imageUrl,
      required this.videoName,
      required this.onTap});

  final String imageUrl;
  final String videoName;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(.3),
                              spreadRadius: 1,
                              blurRadius: 1)
                        ]),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: CommonCachedImageCard(
                          height: 150,
                          width: media.width,
                          placeholder: 'assets/images/placeholder.jpg',
                          fit: BoxFit.cover,
                          image: YoutubePlayer.getThumbnail(
                              videoId: YoutubePlayer.convertUrlToId(imageUrl)!,
                              quality: ThumbnailQuality.standard)),
                    ))
              ],
            ),
            const SizedBox(height: 10),
            Text(
              videoName,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
