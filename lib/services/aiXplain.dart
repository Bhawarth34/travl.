import 'dart:io';
import 'package:aws_s3_upload_lite/aws_s3_upload_lite.dart';
import 'package:travl/services/sttAixplain.dart';
import 'audioRecorder.dart';

class aiXplain{
  audioRecorder audio_recorder = new audioRecorder();

  String userID = "123";

  void start(){
    audio_recorder.initRecorder();
    audio_recorder.startRecording();

    uploadToAudio(File('audio.wav'));
    
    sttAiXplain().sendAudioToApi("https://travl-data.s3.ap-south-1.amazonaws.com/audio-$userID");
  }

  void callForAction(String sentiment){

  }

  void uploadToAudio(File audio){
    AwsS3.uploadFile(
        accessKey: "KEY FROM AWS",
        secretKey: "KEY FROM AWS",
        file: File(audio.path),
        bucket: "travl-data",
        region: "ap-south-1",
        destDir: '',
        filename: 'audio-$userID',
    );
  }

}
