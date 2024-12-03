import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../config/config.dart';
import '../controller/video.dart';
import 'widgets/suggested_video_card.dart';

class CustomPlayer extends StatelessWidget {
  const CustomPlayer({super.key, required this.url, required this.name});

  final String url, name;

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: VideoController(),
        initState: (_) {
          VideoController.to.initializeController(url: url);
        },
        dispose: (e) {
          VideoController.to.controller!
              .removeListener(VideoController.to.checkSuggestionShow);
          VideoController.to.controller!.dispose();
        },
        builder: (_) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Video- $name"),
            ),
            body: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 400,
                    child: YoutubePlayer(
                      controller: VideoController.to.controller!,
                      showVideoProgressIndicator: true,
                      bottomActions: const [
                        CurrentPosition(),
                        ProgressBar(isExpanded: true),
                        RemainingDuration()
                      ],
                    ),
                  ),
                ),
                Obx(
                  () => VideoController.to.isShowSuggestion
                      ? Positioned.fill(
                          child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.black.withOpacity(0.5),
                              ),
                              margin: const EdgeInsets.all(10),
                              // height: 150,
                              child: GridView.builder(
                                  shrinkWrap: true,
                                  itemCount: AppConfig.suggestionVideos.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                  ),
                                  itemBuilder: (context, index) {
                                    var data =
                                        AppConfig.suggestionVideos[index];
                                    return SuggestedVideoCard(
                                      imageUrl: '${data['url']}',
                                      videoName: '${data['name']}',
                                      onTap: () {
                                        VideoController.to.playSuggestionVideo(
                                            url: "${data['url']}");
                                      },
                                    );
                                  })),
                        )
                      : const SizedBox.shrink(),
                ),
              ],
            ),
          );
        });
  }
}
