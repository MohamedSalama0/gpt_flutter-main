import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gpt_flutter/constants/app_styles.dart';
import 'package:gpt_flutter/providers/active_theme_provider.dart';
import 'package:gpt_flutter/services/voice_handler.dart';
import 'package:gpt_flutter/widgets/my_app_bar.dart';
import 'package:intl/intl.dart' as intl;

class TextToSpeechScreen extends StatefulWidget {
  const TextToSpeechScreen({super.key});

  @override
  State<TextToSpeechScreen> createState() => _TextToSpeechScreenState();
}

class _TextToSpeechScreenState extends State<TextToSpeechScreen> {
  final formKey = GlobalKey<FormState>();
  final textController = TextEditingController();
  bool isArabic = true;
  int boo = 0;
  @override
  void initState() {
    // if (textController.text.isEmpty) return;
    // isArabic = RegExp(r'[\u0600-\u06FF]').hasMatch(textController.text);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // SystemChannels.textInput.setMethodCallHandler((call) async {
    //   print(call);
    //   print(call.arguments);
    //   boo = call.arguments[1]['composingBase'];
    // });
    // var formKey = GlobalKey<ScaffoldState>;
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: const MyAppBar(title: 'Text to speech'),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                SizedBox(height: h * 0.10),
                
                Consumer(
                  builder:
                      (BuildContext context, WidgetRef ref, Widget? child) {
                    return Container(
                      width: w * 0.9,
                      height: h * 0.50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: ref.watch(activeThemeProvider) == Themes.dark
                            ? Colors.grey[700]
                            : Colors.grey[200],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: textController,
                          cursorColor: AppStyles.yellowColor,
                          cursorHeight: 30,
                          onChanged: (v) {},
                          maxLines: null,
                          textAlign: TextAlign.end,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                          decoration:
                              const InputDecoration(border: InputBorder.none),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: h * 0.04),
                
                MaterialButton(
                  onPressed: () {
                    // print(textController.text);
                    // var n = intl.Bidi.detectRtlDirectionality(textController.text);
                    // print(n);
                    // Listen to the text input channel for input configuration changes

                    VoiceHandler().speak(textController.text);
                  },
                  color: Theme.of(context).colorScheme.secondary,
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      'Speech',
                      selectionColor: AppStyles.yellowColor,
                      style: TextStyle(
                        color: AppStyles.darkColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
