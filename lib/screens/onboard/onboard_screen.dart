import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:gpt_flutter/screens/chat_screen/chat_screen.dart';
import 'package:gpt_flutter/screens/onboard/component/animated_btn.dart';
import 'package:gpt_flutter/screens/text%20to%20speech/text_to_speech.dart';
import 'package:gpt_flutter/widgets/theme_switch.dart';
import 'package:rive/rive.dart';

class OnbodingScreen extends StatefulWidget {
  const OnbodingScreen({super.key});

  @override
  State<OnbodingScreen> createState() => _OnbodingScreenState();
}

class _OnbodingScreenState extends State<OnbodingScreen> {
  late RiveAnimationController _btnAnimationController;
  late RiveAnimationController _secondBtnAnimationController;

  bool isShowSignInDialog = false;

  @override
  void initState() {
    _btnAnimationController = OneShotAnimation(
      "active",
      autoplay: false,
    );
    _secondBtnAnimationController = OneShotAnimation(
      "active",
      autoplay: false,
    );
    super.initState();
  }

  @override
  void dispose() {
    print('dispose');
    _btnAnimationController.dispose();
    _secondBtnAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            width: MediaQuery.of(context).size.width * 1.7,
            left: 100,
            bottom: 100,
            child: Image.asset(
              "assets/images/Spline.png",
            ),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: const SizedBox(),
            ),
          ),
          const RiveAnimation.asset(
            "assets/images/shapes.riv",
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
              child: const SizedBox(),
            ),
          ),
          AnimatedPositioned(
            top: isShowSignInDialog ? -50 : 0,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            duration: const Duration(milliseconds: 260),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    const Spacer(),

                    SizedBox(
                      width: 260,
                      child: Column(
                        children: const [
                          Text(
                            "Chat Assistant voice with ChatGPT ",
                            style: TextStyle(
                              fontSize: 45,
                              fontWeight: FontWeight.w700,
                              fontFamily: "Poppins",
                              height: 1.2,
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            "You can talk to AI chatGPT to help you with anything you need\nwith voice recorder and response sound feature  ...",
                          ),
                        ],
                      ),
                    ),

                    const Spacer(flex: 1),

                    AnimatedBtn(
                      text: 'Text to speech',
                      btnAnimationController: _btnAnimationController,
                      press: () {
                        _btnAnimationController.isActive = true;
                        Future.delayed(
                          const Duration(milliseconds: 800),
                          () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (c) => const TextToSpeechScreen()),
                            );
                          },
                        );
                      },
                    ),

                    const SizedBox(height: 20),
                    
                    AnimatedBtn(
                      text: 'Go to chat',
                      btnAnimationController: _secondBtnAnimationController,
                      press: () {
                        _secondBtnAnimationController.isActive = true;
                        Future.delayed(
                          const Duration(milliseconds: 800),
                          () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (c) => const ChatScreen()),
                            );
                          },
                        );
                      },
                    ),
                    
                    const SizedBox(height: 40),
                    
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 24),
                      child: Text(
                          "Features in app chat with defult way and make a voice recorder and response with sound it to help blind's peoples "),
                    )
                  ],
                ),
              ),
            ),
          ),
          const Positioned(
            top: 50,
            right: 10,
            child: ThemeSwitch(),
          ),
        ],
      ),
    );
  }
}
