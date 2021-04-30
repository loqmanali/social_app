import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/default_button.dart';
import '../../components/default_form_field.dart';
import '../../components/navigate_to.dart';
import '../../components/show_toast.dart';
import '../../network/local/cache_helper.dart';
import '../../social_app/screen/social_layout.dart';
import '../../social_app/social_app_cubit/login_social/login_cubit.dart';
import '../../social_app/social_app_cubit/login_social/login_state.dart';
import 'social_register_screen.dart';

class SocialLoginScreen extends StatelessWidget {
  final email = TextEditingController();
  final password = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextStyle textTheme = Theme.of(context).textTheme.headline1;
    return BlocProvider(
      create: (context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginStates>(
        listener: (context, state) {
          if (state is SocialLoginErrorState) {
            showToast(
              text: state.error,
              state: ToastStates.ERROR,
            );
          }
          if (state is SocialLoginSuccessState) {
            CacheHelper.saveData(
              key: 'uId',
              value: state.uId,
            ).then((value) {
              AppNavigator.navigatorTo(context, false, SocialLayout());
            });
          }
        },
        builder: (context, state) {
          final cubit = SocialLoginCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Login', style: textTheme),
                        const SizedBox(height: 15.0),
                        defaultFormField(
                          controller: email,
                          type: TextInputType.emailAddress,
                          label: 'Email Address',
                          icon: Icons.email_outlined,
                          validator: (value) {
                            if (value.isEmpty) return 'Please enter your email';
                          },
                          onSubmit: (value) {
                            if (formKey.currentState.validate()) {
                              cubit.userLogin(
                                email: email.text,
                                password: password.text,
                              );
                            }
                          },
                        ),
                        const SizedBox(height: 20.0),
                        defaultFormField(
                          controller: password,
                          type: TextInputType.visiblePassword,
                          label: 'Password',
                          obscureText: cubit.isPassword,
                          suffixIcon: IconButton(
                            onPressed: () {
                              cubit.changePasswordVisibility();
                            },
                            icon: Icon(cubit.suffix),
                          ),
                          icon: Icons.lock_outline,
                          validator: (value) {
                            if (value.isEmpty) return 'Password is too short';
                          },
                          onSubmit: (value) {
                            if (formKey.currentState.validate()) {
                              cubit.userLogin(
                                email: email.text,
                                password: password.text,
                              );
                            }
                          },
                        ),
                        const SizedBox(height: 20.0),
                        ConditionalBuilder(
                          condition: state is! SocialLoginLoadingState,
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                          builder: (context) => defaultButton(
                            function: () {
                              if (formKey.currentState.validate()) {
                                cubit.userLogin(
                                  email: email.text,
                                  password: password.text,
                                );
                              }
                              print(email.text);
                              print(password.text);
                            },
                            text: 'Login',
                            isUpperCase: true,
                          ),
                        ),
                        const SizedBox(height: 25.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Don\'t have account?'),
                            TextButton(
                              onPressed: () {
                                AppNavigator.navigatorTo(
                                    context, true, SocialRegisterScreen());
                              },
                              child: Text('Register'),
                            ),
                          ],
                        ),
                      ],
                    ),
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
