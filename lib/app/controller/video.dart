import 'package:get/get.dart';
import 'package:promilo/app/config/config.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoController extends GetxController {
  static VideoController get to => Get.put(VideoController());

  final _isShowSuggestion = false.obs;

  get isShowSuggestion => _isShowSuggestion.value;

  set isShowSuggestion(value) {
    _isShowSuggestion.value = value;
  }

  final _filteredVideos = <dynamic>[].obs;

  get filteredVideos => _filteredVideos.value;

  set filteredVideos(value) {
    _filteredVideos.value = value;
  }

  YoutubePlayerController? controller;

  initializeController({url}) {
    controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(url)!,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        enableCaption: false,
        showLiveFullscreenButton: false,
      ),
    );

    controller!.addListener(checkSuggestionShow);
  }

  checkSuggestionShow() {
    final videoDuration = controller!.metadata.duration.inSeconds;
    final currentTime = controller!.value.position.inSeconds;
    if (videoDuration > 0 && videoDuration - currentTime <= 30) {
      isShowSuggestion = true;
    } else {
      isShowSuggestion = false;
    }
  }

  playSuggestionVideo({url}) {
    final videoId = YoutubePlayer.convertUrlToId(url);
    if (videoId != null) {
      controller!.load(videoId);
      controller!.play();
      isShowSuggestion = false;
    }
  }

  getYoutubeVideoOnly() {
    filteredVideos = AppConfig.videos.where((video) {
      return video['url'].toString().contains("youtube.com") ||
          video['url'].toString().contains("youtu.be");
    }).toList();
  }
}
