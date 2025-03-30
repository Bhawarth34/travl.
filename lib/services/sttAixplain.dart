import 'dart:convert';
import 'dart:io';
import 'sentiment-Analysis.dart';
import 'package:http/http.dart' as http;


class sttAiXplain{
  Future<void> sendAudioToApi(String audioURL) async {
    try {

      String url = 'https://models.aixplain.com/api/v1/execute/6610617ff1278441b6482530';

      Map<String, String> headers = {
        'x-api-key': '9e5e8410db996ad2c19df8f51201ea34ef05d1d8570b98e8e925ef13e0bc33d1',
        'Content-Type': 'application/json',
      };

      Map<String, dynamic> body = {
        "source_audio": audioURL
      };

      http.Response response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        sleep(Duration(seconds: 2));
        Map<String, dynamic> responseData = jsonDecode(response.body);

        if (responseData.containsKey('data')) {
          String? url2 = responseData['data'];
          http.Response response2 = await http.get(
            Uri.parse(url2!)
          );
          Map<String, dynamic> sentimentData = jsonDecode(response2.body);
          if (responseData.containsKey('data')) {
            sentiment_Analysis analyser = new sentiment_Analysis();
            analyser.analyzer(responseData['data']);
          }
        }
      } else {
        print('Error: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('Exception: $e');
    }
  }
}