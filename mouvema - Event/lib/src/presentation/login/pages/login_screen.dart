import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mouvema/src/core/utils/string_manager.dart';
import '../../../config/routes/routes.dart';
import '../../../core/utils/image_manager.dart';
import '../../../data/repository/repository_impl.dart';
import '../../../injector.dart';
import '../cubit/login_cubit.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginScreenCubit(instance<RepositoryImpl>()),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: BlocConsumer<LoginScreenCubit, LoginScreenState>(
            listener: (context, state) {
              if (state.status == Status.failed) {
                AwesomeDialog(
                        btnOkColor: Colors.teal,
                        context: context,
                        dialogType: DialogType.error,
                        animType: AnimType.topSlide,
                        title: 'Error',
                        desc: state.errorMessage)
                    .show();
              } else if (state.status == Status.success) {
                Navigator.pushReplacementNamed(context, Routes.main);
              }
            },
            builder: (context, state) {
              if (state.status == Status.loading) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return Column(
                  children: [
                    const Spacer(),
                    Expanded(
                        flex: 3, child: Image.asset(ImageManager.logoWithName)),
                    const Spacer(),
                    Expanded(
                        flex: 4,
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              SizedBox(
                                height: 60,
                                child: OutlinedButton.icon(
                                    icon: const Icon(Icons.facebook, size: 40),
                                    onPressed: () {
                                      BlocProvider.of<LoginScreenCubit>(context)
                                          .continueWithFacebook();
                                    },
                                    label: Text(
                                      StringManager.continueWithFacebook,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge,
                                    )),
                              ),
                              const SizedBox(height: 25),
                              SizedBox(
                                height: 60,
                                child: OutlinedButton.icon(
                                    icon: const Icon(Icons.key, size: 40),
                                    onPressed: () {
                                      Navigator.pushReplacementNamed(
                                          context, Routes.loginWithPassword);
                                    },
                                    label: Text(
                                      StringManager.signInWithPaswword,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge,
                                    )),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(width: 1, color: Colors.red),
                                    borderRadius: BorderRadius.circular(10)),
                                child: const Text(
                                  'Only login with password is available in test Version ! ',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),

                              //const SizedBox(height: 30),
                              // const Or(),

                              const SizedBox(height: 50),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    StringManager.dontHaveAccount,
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, Routes.register);
                                      },
                                      child: Text(StringManager.signUp)),
                                ],
                              ),
                            ],
                          ),
                        ))
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
