import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/components/navigate_to.dart';
import 'package:social_app/social_app/social_app_cubit/layout/cubit.dart';
import 'package:social_app/social_app/social_app_cubit/layout/states.dart';
import 'package:social_app/styles/icon_broken.dart';

import 'new_post/new_post_screen.dart';

class SocialLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is SocialNewPostState) {
          AppNavigator.navigatorTo(context, true, NewPostScreen());
        }
      },
      builder: (context, state) {
        final cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.titles[cubit.currentIndex]),
            actions: [
              IconButton(
                icon: Icon(IconBroken.Notification),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(IconBroken.Search),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(IconBroken.Logout),
                onPressed: () {},
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) => cubit.changeBottomNav(index),
            items: [
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Chat),
                label: 'Chat',
              ),
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Paper_Upload),
                label: 'Post',
              ),
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Location),
                label: 'Users',
              ),
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Setting),
                label: 'Setting',
              ),
            ],
          ),
        );
      },
    );
  }
}

// Column(
// children: [
// Container(
// color: Colors.amberAccent.withOpacity(0.6),
// child: Padding(
// padding: const EdgeInsets.symmetric(horizontal: 20.0),
// child: Row(
// children: [
// Icon(Icons.info_outline),
// const SizedBox(width: 15.0),
// Text('Verify Your Email'),
// Spacer(),
// defaultTextButton(
// function: () {
// FirebaseAuth.instance.currentUser
//     .sendEmailVerification()
//     .then((value) {
// showToast(
// text: 'Check Your Email',
// state: ToastStates.SUCCESS,
// );
// }).catchError((error) {});
// },
// text: 'Verify',
// ),
// ],
// ),
// ),
// ),
// ],
// )
