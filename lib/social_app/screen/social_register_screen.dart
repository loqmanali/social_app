import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/components/default_button.dart';
import 'package:social_app/components/default_form_field.dart';
import 'package:social_app/components/navigate_to.dart';
import 'package:social_app/components/show_toast.dart';
import 'package:social_app/social_app/screen/social_layout.dart';
import 'package:social_app/social_app/social_app_cubit/register_social/register_cubit_social.dart';
import 'package:social_app/social_app/social_app_cubit/register_social/register_states_social.dart';

import 'social_login_screen.dart';

class SocialRegisterScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    TextStyle textTheme = Theme.of(context).textTheme.headline2;
    return BlocProvider(
      create: (context) => SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit, SocialRegisterStates>(
        listener: (context, state) {
          if (state is SocialCreateUserErrorState) {
            showToast(text: state.error, state: ToastStates.ERROR);
          }
          if (state is SocialCreateUserSuccessState) {
            AppNavigator.navigatorTo(context, false, SocialLayout());
            showToast(text: '', state: ToastStates.SUCCESS);
          }
        },
        builder: (context, state) {
          final cubit = SocialRegisterCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Register', style: textTheme),
                      const SizedBox(height: 15.0),
                      defaultFormField(
                        controller: nameController,
                        type: TextInputType.name,
                        label: 'User Name',
                        icon: Icons.person_rounded,
                        validator: (value) {
                          if (value.isEmpty) return 'Please enter your Name';
                        },
                      ),
                      const SizedBox(height: 20.0),
                      defaultFormField(
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        label: 'Email Address',
                        icon: Icons.email_outlined,
                        validator: (value) {
                          if (value.isEmpty) return 'Please enter your email';
                        },
                      ),
                      const SizedBox(height: 20.0),
                      defaultFormField(
                        controller: phoneController,
                        type: TextInputType.phone,
                        label: 'Phone',
                        icon: Icons.phone,
                        validator: (value) {
                          if (value.isEmpty) return 'Please enter your phone';
                        },
                      ),
                      const SizedBox(height: 20.0),
                      defaultFormField(
                        controller: passwordController,
                        type: TextInputType.visiblePassword,
                        label: 'Password',
                        icon: Icons.lock_outline,
                        suffixIcon: IconButton(
                          onPressed: () {
                            cubit.changePasswordVisibility();
                          },
                          icon: Icon(cubit.suffix),
                        ),
                        obscureText: cubit.isPassword,
                        validator: (value) {
                          if (value.isEmpty) return 'Password is too short';
                        },
                      ),
                      const SizedBox(height: 20.0),
                      ConditionalBuilder(
                        condition: state is! SocialRegisterLoadingState,
                        builder: (context) => defaultButton(
                          function: () {
                            if (formKey.currentState.validate()) {
                              cubit.userRegister(
                                name: nameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                                phone: phoneController.text,
                              );
                            }
                          },
                          text: 'register',
                          isUpperCase: true,
                        ),
                        fallback: (context) => Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      const SizedBox(height: 25.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('You have account?'),
                          TextButton(
                            onPressed: () {
                              AppNavigator.navigatorTo(
                                  context, true, SocialLoginScreen());
                            },
                            child: Text('Login'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
