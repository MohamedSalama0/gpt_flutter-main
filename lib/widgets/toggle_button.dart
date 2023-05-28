import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:gpt_flutter/constants/app_styles.dart';
import 'package:gpt_flutter/widgets/text_and_voice_field.dart';

class ToggleButton extends StatefulWidget {



  final VoidCallback _sendTextMessage;
  final VoidCallback _sendVoiceMessage;
  final InputMode _inputMode;
  final bool _isReplying;
  final bool _isListening;
  const ToggleButton({
    super.key,
    required InputMode inputMode,
    required VoidCallback sendTextMessage,
    required VoidCallback sendVoiceMessage,
    required bool isReplying,
    required bool isListening,
  })  : _inputMode = inputMode,
        _sendTextMessage = sendTextMessage,
        _sendVoiceMessage = sendVoiceMessage,
        _isReplying = isReplying,
        _isListening = isListening;

  @override
  State<ToggleButton> createState() => _ToggleButtonState();

}

class _ToggleButtonState extends State<ToggleButton> {


  @override
  Widget build(BuildContext context) {
    return AvatarGlow(
      animate: true,
      glowColor: AppStyles.thirdSuggestionBoxColor,
      repeat: true,
      showTwoGlows: true,
      duration: const Duration(
        milliseconds: 2000,
      ),
      endRadius: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          foregroundColor: Theme.of(context).colorScheme.primary,
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(15),
        ),
        onPressed: widget
        ._isReplying
            ? null
            : widget
            ._inputMode 
            == InputMode.text
                ?
                 widget._sendTextMessage
                :
                 widget._sendVoiceMessage,
        child: Icon(
          widget
          ._inputMode 
          == InputMode.text
              ?
               Icons.send
              :
               widget
               ._isListening
                  ?
                   Icons.stop_rounded
                  :
                   Icons.mic,
        ),
      ),
    );
  }
}
