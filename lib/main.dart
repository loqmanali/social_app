import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc_observer.dart';
import 'components/constant.dart';
import 'network/local/cache_helper.dart';
import 'network/remote/dio_helper.dart';
import 'social_app/screen/social_layout.dart';
import 'social_app/screen/social_login_screen.dart';
import 'social_app/social_app_cubit/layout/cubit.dart';
import 'styles/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();

  DioHelper.init();
  await CacheHelper.init();

  Widget widget;
  // bool onBoarding = CacheHelper.getData(key: 'onBoarding');
  // String token = CacheHelper.getData(key: 'token');

  uId = CacheHelper.getData(key: 'uId');

  // if (onBoarding != null) {
  //   if (token != null)
  //     widget = ShopLayout();
  //   else
  //     widget = LoginScreen();
  // } else {
  //   widget = OnBoardingScreen();
  // }

  if (uId != null) {
    widget = SocialLayout();
  } else {
    widget = SocialLoginScreen();
  }

  runApp(MyApp(
    // onBoarding: onBoarding,
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  // final bool onBoarding;
  final Widget startWidget;

  const MyApp({Key key, this.startWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SocialCubit()..getUserData()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Social',
        theme: lightTheme,
        darkTheme: darkTheme,
        home: startWidget,
      ),
    );
  }
}
