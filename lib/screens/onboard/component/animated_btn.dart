import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gpt_flutter/constants/app_styles.dart';
import 'package:rive/rive.dart';

class AnimatedBtn extends StatelessWidget {
  const AnimatedBtn({
    Key? key,
    required RiveAnimationController btnAnimationController,
    required this.press,
    required this.text,
  })  : _btnAnimationController = btnAnimationController,
        super(key: key);

  final RiveAnimationController _btnAnimationController;
  final VoidCallback press;
  final String text;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: SizedBox(
        height: 60,
        width: 225,
        child: Stack(
          children: [
            RiveAnimation.asset(
              "assets/images/button.riv",
              controllers: [_btnAnimationController],
            ),
            Positioned.fill(
              top: 6,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  
                  const SizedBox(width: 20),

                  const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: AppStyles.blackColor,
                  ),
                  
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        text,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(color: AppStyles.darkColor),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
