import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/video.dart';
import 'custom_player.dart';
import 'widgets/videos_card.dart';

class VideosList extends StatelessWidget {
  const VideosList({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: VideoController(),
        initState: (_) {
          VideoController.to.getYoutubeVideoOnly();
        },
        builder: (_) {
          return Scaffold(
            appBar: AppBar(
                title: const Text(
                  "Video List",
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.blue),
            body: Obx(() => VideoController.to.filteredVideos.isEmpty
                ? const Text("No YouTube Videos")
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 20),
                    itemCount: VideoController.to.filteredVideos.length,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      var data = VideoController.to.filteredVideos[index];
                      return VideosCard(
                        imageUrl: "${data['url']}",
                        videoName: "${data['name']}",
                        onTap: () {
                          Get.to(() => CustomPlayer(
                                url: "${data['url']}",
                                name: "${data['name']}",
                              ));
                        },
                      );
                    })),
          );
        });
  }
}
