import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../components/default_app_bar.dart';
import '../../../components/default_text_button.dart';
import '../../../social_app/social_app_cubit/layout/cubit.dart';
import '../../../social_app/social_app_cubit/layout/states.dart';
import '../../../styles/icon_broken.dart';
import '../../../styles/themes.dart';

class NewPostScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: 'Create Post',
            actions: [
              defaultTextButton(
                function: () {},
                text: 'Post',
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25.0,
                      backgroundImage: Image.network(
                        'https://image.freepik.com/free-vector/man-shows-gesture-great-idea_10045-637.jpg',
                        fit: BoxFit.cover,
                        height: 200.0,
                        width: double.infinity,
                      ).image,
                    ),
                    const SizedBox(width: 15.0),
                    Expanded(
                      child: Row(
                        children: [
                          Text('Loqman Ali'),
                          const SizedBox(width: 5.0),
                          Icon(
                            Icons.check_circle,
                            color: defaultColor,
                            size: 16.0,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    decoration:
                        InputDecoration(hintText: 'What is on your mind ...'),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(IconBroken.Image),
                            const SizedBox(width: 15.0),
                            Text('Add Photo'),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {},
                        child: Text('# tags'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
