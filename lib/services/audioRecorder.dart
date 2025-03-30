import 'package:flutter_sound/public/flutter_sound_recorder.dart';

class audioRecorder {
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  bool isRecording = false;

  Future<void> initRecorder() async {
    await _recorder.openRecorder();
  }

  Future<void> startRecording() async {
    await _recorder.startRecorder(toFile: "audio.wav");
    isRecording = true;

    await Future.delayed(Duration(seconds: 5));
    await stopRecording();
  }

  Future<String?> stopRecording() async {
    isRecording = false;
    return await _recorder.stopRecorder();
  }
}