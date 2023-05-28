import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gpt_flutter/constants/app_styles.dart';
import 'package:gpt_flutter/providers/active_theme_provider.dart';

class ChatItem extends ConsumerWidget {

  final String text;
  final bool isMe;
  const ChatItem({
    super.key,
    required this.text,
    required this.isMe,
  });


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.read(activeThemeProvider.notifier).state;
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 12,
      ),

      child: Row(

        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isMe) ProfileContainer(isMe: isMe, theme: theme),
          
          if (!isMe) const SizedBox(width: 15),
          
          Container(
            padding: const EdgeInsets.all(15),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.60,
            ),
            decoration: BoxDecoration(
              color: isMe
                  ?
                   Theme.of(context).colorScheme.secondary
                  :
                   theme
                    == Themes.dark
                      ?
                       AppStyles.darkColor
                      :
                       AppStyles.assistantCircleColor,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(
                  15,
                ),
                topRight: const Radius.circular(
                  15,
                ),
                bottomLeft: Radius.circular(
                  isMe ? 15 : 0,
                ),
                bottomRight: Radius.circular(
                  isMe ? 0 : 15,
                ),
              ),
            ),

            child: Text(
              text,
              style: TextStyle(
                color:
                 isMe
                    ?
                     Theme.of(context).colorScheme.primary
                    :
                     Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ),
          
          if (isMe) const SizedBox(width: 15),
          
          if (isMe) ProfileContainer(isMe: isMe, theme: theme),
        ],
      ),
    );
  }
}

class ProfileContainer extends StatelessWidget {
  final Themes theme;
  const ProfileContainer({
    super.key,
    required this.isMe,
    required this.theme,
  });

  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: isMe
            ? 
            Theme.of(context).colorScheme.secondary
            :
             theme 
             == Themes.dark
                ?
                 const Color(0xff023047)
                :
                /// change AppThemeColor if has a problem
                 AppStyles.assistantCircleColor,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(
            10,
          ),
          topRight: const Radius.circular(
            10,
          ),
          bottomLeft: Radius.circular(
            isMe ? 0 : 15,
          ),
          bottomRight: Radius.circular(
            isMe ? 15 : 0,
          ),
        ),
      ),
      child: Icon(
        isMe
         ?
          Icons.person 
         :
          Icons.computer,
        color:
         isMe
            ?
             Theme.of(context).colorScheme.primary
            :
             Theme.of(context).colorScheme.onPrimary,
      ),
    );
  }
}
