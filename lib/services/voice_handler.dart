import 'dart:async';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart';

class VoiceHandler {
  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  final FlutterTts _tts = FlutterTts();

  void initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
  }

  Future<String> startListening() async {
    final completer = Completer<String>();
    print('before');
    _speechToText.listen(
      onResult: (result) {
        print('onResult');
        if (result.finalResult) {
          print(result.toString());
          completer.complete(result.recognizedWords);
        }
      },
    );
    return completer.future;
  }

  Future<void> stopListening() async {
    await _speechToText.stop();
    
  }

  void initTts() {
    _tts.setLanguage('en-US');
  }

  void speak(String res) {
    _tts.speak(res);
  }

  FlutterTts get tts => _tts;
  SpeechToText get speechToText => _speechToText;
  bool get isEnabled => _speechEnabled;
}
