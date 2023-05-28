import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gpt_flutter/models/chat_model.dart';

final chatsProvider = StateNotifierProvider<ChatNotifier, List<ChatModel>>(
  (ref) => ChatNotifier(),
);


class ChatNotifier extends StateNotifier<List<ChatModel>> {
  bool isReplying = false;
  bool isListening = false;
  ChatNotifier() : super([]);

  
 void add(ChatModel chatModel) {
    state = [...state, chatModel];
  }

  void removeTyping() {
    state = state..removeWhere((chat) => chat.id == 'typing');
  }

}
