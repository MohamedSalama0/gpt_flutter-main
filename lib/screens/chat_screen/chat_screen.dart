import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gpt_flutter/constants/app_styles.dart';
import 'package:gpt_flutter/providers/active_theme_provider.dart';
import 'package:gpt_flutter/providers/chats_provider.dart';
import 'package:gpt_flutter/widgets/chat_item.dart';
import 'package:lottie/lottie.dart';
import '../../models/chat_model.dart';
import '../../services/ai_handler.dart';
import '../../services/voice_handler.dart';
import '../../widgets/my_app_bar.dart';
import '../../widgets/text_and_voice_field.dart';
import '../../widgets/toggle_button.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: const MyAppBar(
        title: 'Assistant voice',
      ),
      body: Column(
        children: [
          ZoomIn(
            child: Stack(
              children: [
                Consumer(
                  builder:
                      (BuildContext context, WidgetRef ref, Widget? child) {
                    final theme = ref.watch(activeThemeProvider);
                    return Center(
                      child: Container(
                        height: 100,
                        width: 100,
                        margin: const EdgeInsets.only(top: 4),
                        decoration: BoxDecoration(
                          color: theme == Themes.light
                              ? AppStyles.assistantCircleColor.withOpacity(0.1)
                              : const Color.fromARGB(255, 52, 52, 52)
                                  .withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Lottie.asset(
                          'assets/images/chatbot.json',
                          height: 90,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: Consumer(
              builder: (context, ref, child) {
                final chats = ref.watch(chatsProvider).reversed.toList();
                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  reverse: true,
                  itemCount: chats.length,
                  itemBuilder: (context, index) => ChatItem(
                    text: chats[index].message,
                    isMe: chats[index].isMe,
                  ),
                );
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(12),
            child: TextAndVoiceField(),
          ),
        ],
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:gpt_flutter/models/chat_model.dart';
// import 'package:gpt_flutter/providers/chats_provider.dart';
// import 'package:gpt_flutter/services/ai_handler.dart';
// import 'package:gpt_flutter/services/voice_handler.dart';
// import 'package:gpt_flutter/widgets/toggle_button.dart';

enum InputMode {
  text,
  voice,
}

// class TextAndVoiceField extends ConsumerStatefulWidget {
//   const TextAndVoiceField({super.key});

//   @override
//   ConsumerState<TextAndVoiceField> createState() => _TextAndVoiceFieldState();
// }

// class _TextAndVoiceFieldState extends ConsumerState<TextAndVoiceField> {
//   InputMode _inputMode = InputMode.voice;
//   final _messageController = TextEditingController();
//   final VoiceHandler voiceHandler = VoiceHandler();
//   bool isReplying = false;
//   bool isListening = false;

//   @override
//   void initState() {
//     voiceHandler.initSpeech();
//     super.initState();
//   }

//   AIHandler _openAI() {
//     return AIHandler(ref);
//   }

//   @override
//   void dispose() {
//     _messageController.dispose();
//     // _openAI().dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // final isListening =
//     //     ref.watch(chatsProvider.notifier.select((value) => value.isListening));
//     // final isReplying =
//     //     ref.watch(chatsProvider.notifier.select((value) => value.isReplying));
//     return Row(
//       children: [
//         Expanded(
//           child: Container(
//             height: 50,
//             child: TextField(
//               controller: _messageController,
//               onChanged: (value) {
//                 value.isNotEmpty
//                     ? setInputMode(InputMode.text)
//                     : setInputMode(InputMode.voice);
//               },
//               cursorColor: Theme.of(context).colorScheme.onPrimary,
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderSide: BorderSide(
//                     color: Theme.of(context).colorScheme.onPrimary,
//                   ),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//             ),
//           ),
//         ),
//         const SizedBox(
//           width: 1,
//         ),
//         ToggleButton(
//           isListening: isListening,
//           isReplying: isReplying,
//           inputMode: _inputMode,
//           sendTextMessage: () {
//             final message = _messageController.text;
//             _messageController.clear();
//             sendTextMessage(message);
//           },
//           sendVoiceMessage: sendVoiceMessage,
//         )
//       ],
//     );
//   }

//   void setInputMode(InputMode inputMode)
//    {
//     setState(() {
//       _inputMode = inputMode;
//     });
//   }

//   void sendVoiceMessage() async
//    {
//     if (!voiceHandler.isEnabled)
//      {
//       print('Not supported');
//       return;
//     }
//     if (voiceHandler.speechToText.isListening) {
//       await voiceHandler.stopListening();
//       setListeningState();
    
//     } else 
//     {
//       setListeningState();
//       final result = await voiceHandler.startListening();
//       print('result: $result');
//       setListeningState();
//       sendTextMessage(result);
//     }
//   }

//   void sendTextMessage(String message) async {
    
//     setReplyingState();
//     addToChatList(message, true, DateTime.now().toString());
    
//     addToChatList('Typing...', false, 'typing');
//     setInputMode(InputMode.voice);
//     // reqeust
//     final aiResponse = await _openAI().getResponse(message);
//     removeTyping();
    
//     addToChatList(aiResponse, false, DateTime.now().toString());
    
//     setReplyingState();
//   }

//   void setReplyingState() {
//     setState(() {
//       isReplying = !isReplying;
//     });
//   }

//   void setListeningState() {
//     setState(() {
//       isListening = !isListening;
//     });
//   }

//   void removeTyping() {
//     final chats = ref.read(chatsProvider.notifier);
//     chats.removeTyping();
//   }

//   void addToChatList(String message, bool isMe, String id) {
//     final chats = ref.read(chatsProvider.notifier);
//     chats.add(ChatModel(
//       id: id,
//       message: message,
//       isMe: isMe,
//     ));
//     if (!isMe) VoiceHandler().speak(message);
//   }
// }

