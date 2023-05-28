import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final apiKeyValue = StateProvider(
  (ref) => '',
);
final mainProvider = StateNotifierProvider((ref) => MainProvider(ref));

class MainProvider extends StateNotifier {
  late final Ref ref;
  MainProvider(this.ref) : super(ref) {
    // getApiValue();
  }
  Future getApiValue() async {
    FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
    final defaults = <String, dynamic>{'welcome_message': 'Welcome to my app!'};
    /// Error happend because this how to fix it without delete this line 
    // remoteConfig.onConfigUpdated.first.then((value) => print(value.updatedKeys));
    await remoteConfig.setDefaults(defaults);
    await remoteConfig.fetch();
    await remoteConfig.fetchAndActivate().then((value) {
      print(value);
      print('api_key ${remoteConfig.getString('api_key')}');
      ref.read(apiKeyValue.notifier).state = remoteConfig.getString('api_key');
      print('Welcome message: ${remoteConfig.getString('api_key')}');
      print('Welcome message: ${ref.read(apiKeyValue.notifier).state}');
    });
  }
}
