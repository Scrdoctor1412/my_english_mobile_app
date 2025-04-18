import 'package:just_audio/just_audio.dart';

String snakeCaseToNormal(String input) {
  return input
      .split('_') // Tách chuỗi bằng dấu gạch dưới
      .map(
        (word) => word[0].toUpperCase() + word.substring(1),
      ) // Viết hoa chữ cái đầu mỗi từ
      .join(' '); // Ghép lại các từ bằng dấu cách
}

void onTapPlayAudio({String audioUrl = ''}) async {
  final player = AudioPlayer();
  await player.setUrl(audioUrl);
  player.play();
}
