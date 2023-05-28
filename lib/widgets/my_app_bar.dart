import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:gpt_flutter/constants/app_styles.dart';
import 'package:gpt_flutter/providers/active_theme_provider.dart';
import 'package:gpt_flutter/widgets/theme_switch.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  const MyAppBar({super.key, required this.title});
  final String title;
  @override
  State<MyAppBar> createState() => _MyAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(60);
}

class _MyAppBarState extends State<MyAppBar> {
  // final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
  var remoteValue;
  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((t) {
    // fetch();
    // });
  }

  // Future<void> fetch() async {
  //   final defaults = <String, dynamic>{'welcome_message': 'Welcome to my app!'};
  //   // Fetch Remote Config data and activate it
  //   await remoteConfig.setDefaults(defaults);
  //   await remoteConfig.fetch();
  //   await remoteConfig.fetchAndActivate();
  //   // Use fetched values in your app
  //   remoteValue = remoteConfig.getBool('remote_value');
  //   final val = remoteConfig.getInt('remote_num');
  //   final val2 = remoteConfig.getString('api_key');
  //   print('Welcome message: $remoteValue');
  //   print('Welcome message: $val');
  //   print('Welcome message: $val2');
  // }

  @override
  Widget build(BuildContext context) {
    // remoteValue = remoteConfig.getBool('remote_value');
    // print(remoteValue);
    return AppBar(
      elevation: 0,
      centerTitle: true,
      title: Text(
        widget.title,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
      // action / leading
      actions: [
        Row(
          children: [
            
            Consumer(
              builder: (context, ref, child) => Icon(
                color: AppStyles.yellowColor,
                ref.watch(activeThemeProvider) 
                == Themes.dark
                    ?
                     Icons.dark_mode
                    :
                     Icons.light_mode,
              ),
            ),
            
            const SizedBox(width: 8),
            
            const ThemeSwitch(),
          ],
        )
      ],
    );
  }
}
