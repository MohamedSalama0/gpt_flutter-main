import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gpt_flutter/models/chat_model.dart';
import 'package:gpt_flutter/providers/chats_provider.dart';
import 'package:gpt_flutter/services/ai_handler.dart';
import 'package:gpt_flutter/services/voice_handler.dart';
import 'package:gpt_flutter/widgets/toggle_button.dart';

enum InputMode {
  text,
  voice,
}

class TextAndVoiceField extends ConsumerStatefulWidget {
  const TextAndVoiceField({super.key});

  @override
  ConsumerState<TextAndVoiceField> createState() => _TextAndVoiceFieldState();
}

class _TextAndVoiceFieldState extends ConsumerState<TextAndVoiceField> {
  InputMode _inputMode = InputMode.voice;
  final _messageController = TextEditingController();
  final VoiceHandler voiceHandler = VoiceHandler();
  bool isReplying = false;
  bool isListening = false;

  @override
  void initState() {
    voiceHandler.initSpeech();
    super.initState();
  }

  AIHandler _openAI() {
    return AIHandler(ref);
  }

  @override
  void dispose() {
    _messageController.dispose();
    // _openAI().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final isListening =
    //     ref.watch(chatsProvider.notifier.select((value) => value.isListening));
    // final isReplying =
    //     ref.watch(chatsProvider.notifier.select((value) => value.isReplying));
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 50,
            child: TextField(
              controller: _messageController,
              onChanged: (value)
               {
                value.isNotEmpty
                    ?
                     setInputMode(InputMode.text)
                    :
                     setInputMode(InputMode.voice);
              },
              cursorColor: Theme.of(context).colorScheme.onPrimary,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).
                    colorScheme.onPrimary,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 1,
        ),
        ToggleButton(
          isListening: isListening,
          isReplying: isReplying,
          inputMode: _inputMode,
          sendTextMessage: ()
           {
            final message = _messageController.text;
            _messageController.clear();
            sendTextMessage(message);
          },
          sendVoiceMessage: sendVoiceMessage,
        )
      ],
    );
  }

  void setInputMode(InputMode inputMode)
   {
    setState(()
     {
      _inputMode = inputMode;
    });
  }

  void sendVoiceMessage() async
   {
    if (!voiceHandler.isEnabled)
     {
      print('Not supported');
      return;
    }
    if (voiceHandler.speechToText.isListening) {
      await voiceHandler.stopListening();
      setListeningState();
    
    } else 
    {
      setListeningState();
      final result = await voiceHandler.startListening();
      print('result: $result');
      setListeningState();
      sendTextMessage(result);
    }
  }

  void sendTextMessage(String message) async {
    
    setReplyingState();
    addToChatList(message, true, DateTime.now().toString());
    
    addToChatList('Typing...', false, 'typing');
    setInputMode(InputMode.voice);
    // reqeust
    final aiResponse = await _openAI().getResponse(message);
    removeTyping();
    
    addToChatList(aiResponse, false, DateTime.now().toString());
    
    setReplyingState();
  }

  void setReplyingState() {
    setState(() {
      isReplying = !isReplying;
    });
  }

  void setListeningState() {
    setState(() {
      isListening = !isListening;
    });
  }

  void removeTyping() {
    final chats = ref.read(chatsProvider.notifier);
    chats.removeTyping();
  }

  // add message to chat
  void addToChatList(String message, bool isMe, String id) {
    final chats = ref.read(chatsProvider.notifier);
  
    chats.add(ChatModel(
      id: id,
      message: message,
      isMe: isMe,
    ));
  
    if (!isMe) VoiceHandler().speak(message);
  
  }

}
