import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gpt_flutter/providers/main_provider.dart';

class AIHandler {
  WidgetRef ref;
  late final String value;
  AIHandler(this.ref) {
    value = ref.read(apiKeyValue.notifier).state;
  }
  OpenAI initOpenAi() {
    return OpenAI.instance.build(
      token: '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',
      baseOption: HttpSetup(
        receiveTimeout: const Duration(seconds: 60),
        connectTimeout: const Duration(seconds: 60),
      ),
    );
  }

  Future<String> getResponse(String message) async {
    try {
      final request = ChatCompleteText(
        messages: [
          Map.of({"role": "user", "content": message})
        ],
        maxToken: 500,
        model: kChatGptTurbo,
      );

      final response = await initOpenAi().onChatCompletion(request: request);
      if (response != null) {
        return response.choices[0].message.content.trim();
      }

      return 'Some thing went wrong';
    } catch (e) {
      print(e.toString());
      return 'Bad response';
    }
  }

  /// [dispose api state]
  // void dispose() {
  // initOpenAi().onCompletion(request: CompleteText.);
  // }
}
