import 'package:social_app/network/local/cache_helper.dart';
import 'package:social_app/social_app/screen/social_login_screen.dart';

import 'navigate_to.dart';
import 'show_toast.dart';

void signOut(context) {
  CacheHelper.removeData(key: 'uId').then((value) {
    if (value) AppNavigator.navigatorTo(context, false, SocialLoginScreen());
    showToast(text: 'LogOut Success', state: ToastStates.SUCCESS);
  });
}

void printFullText(String text) {
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

String token = '';
String uId = '';
