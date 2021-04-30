import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../components/default_app_bar.dart';
import '../../../components/default_button.dart';
import '../../../components/default_form_field.dart';
import '../../../components/default_text_button.dart';
import '../../../social_app/social_app_cubit/layout/cubit.dart';
import '../../../social_app/social_app_cubit/layout/states.dart';
import '../../../styles/icon_broken.dart';

class EditProfileScreen extends StatelessWidget {
  final name = TextEditingController();
  final bio = TextEditingController();
  final phone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final userModel = SocialCubit.get(context).userModel;
        final cubit = SocialCubit.get(context);
        final profileImage = SocialCubit.get(context).profileImage;
        final coverImage = SocialCubit.get(context).coverImage;
        name.text = userModel.name;
        bio.text = userModel.bio;
        phone.text = userModel.phone;
        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: 'Edit Profile',
            actions: [
              defaultTextButton(
                  function: () {
                    cubit.updateUser(
                      name: name.text,
                      phone: phone.text,
                      bio: bio.text,
                    );
                  },
                  text: 'update'.toUpperCase()),
              const SizedBox(width: 15.0),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if (state is SocialUserUpdateLoadingState)
                    LinearProgressIndicator(),
                  if (state is SocialUserUpdateLoadingState)
                    const SizedBox(height: 10.0),
                  Container(
                    height: 265.0,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                height: 200.0,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    topRight: Radius.circular(4.0),
                                  ),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      '${coverImage == null ? NetworkImage('${userModel.cover}') : FileImage(coverImage)}',
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              CircleAvatar(
                                radius: 20.0,
                                child: IconButton(
                                  icon: Icon(IconBroken.Camera),
                                  onPressed: () {
                                    cubit.getCoverImage();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 65.0,
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 60.0,
                                backgroundImage: profileImage == null
                                    ? NetworkImage('${userModel.image}')
                                    : FileImage(profileImage),
                              ),
                            ),
                            CircleAvatar(
                              radius: 20.0,
                              child: IconButton(
                                icon: Icon(IconBroken.Camera),
                                onPressed: () {
                                  cubit.getProfileImage();
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  if (cubit.profileImage != null || cubit.coverImage != null)
                    Row(
                      children: [
                        if (cubit.profileImage != null)
                          Expanded(
                            child: defaultButton(
                              function: () {
                                cubit.uploadProfileImage(
                                  name: name.text,
                                  phone: phone.text,
                                  bio: bio.text,
                                );
                              },
                              text: 'update profile',
                            ),
                          ),
                        const SizedBox(width: 5.0),
                        if (cubit.coverImage != null)
                          Expanded(
                            child: defaultButton(
                              function: () {
                                cubit.uploadCoverImage(
                                  name: name.text,
                                  phone: phone.text,
                                  bio: bio.text,
                                );
                              },
                              text: 'update cover',
                            ),
                          ),
                      ],
                    ),
                  const SizedBox(height: 15.0),
                  defaultFormField(
                    controller: name,
                    type: TextInputType.name,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'name must not empty';
                      }
                    },
                    label: 'Name',
                    icon: IconBroken.User,
                  ),
                  const SizedBox(height: 20.0),
                  defaultFormField(
                    controller: bio,
                    type: TextInputType.text,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'bio must not empty';
                      }
                    },
                    label: 'Bio',
                    icon: IconBroken.Info_Circle,
                  ),
                  const SizedBox(height: 20.0),
                  defaultFormField(
                    controller: phone,
                    type: TextInputType.phone,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'phone number must not empty';
                      }
                    },
                    label: 'Phone',
                    icon: IconBroken.Call,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
