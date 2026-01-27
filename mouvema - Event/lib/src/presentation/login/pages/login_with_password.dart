import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mouvema/src/core/utils/string_manager.dart';
import 'package:mouvema/src/data/repository/repository_impl.dart';

import '../../../config/routes/routes.dart';
import '../../../injector.dart';
import '../../shared/text_field.dart';
import '../cubit/login_cubit.dart';

// ?Login = sign in
// ?register = sign up

class LoginWithPassword extends StatelessWidget {
  const LoginWithPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginScreenCubit(instance<RepositoryImpl>()),
      child: Scaffold(
        appBar: AppBar(
          elevation: 4,
          leading: IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, Routes.login);
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: BlocConsumer<LoginScreenCubit, LoginScreenState>(
              builder: (context, state) {
            return state.status == Status.loading
                ? const Center(child: CircularProgressIndicator())
                : _screenContent(context, state);
          }, listener: (context, state) {
            if (state.status == Status.failed) {
              AwesomeDialog(
                btnOkColor: Colors.teal,
                context: context,
                dialogType: DialogType.error,
                animType: AnimType.topSlide,
                title: state.errorMessage,
              ).show();
            } else if (state.status == Status.success) {
              Navigator.pushReplacementNamed(context, Routes.main);
            }
          }),
        ),
      ),
    );
  }

  Column _screenContent(BuildContext context, LoginScreenState state) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            flex: 1,
            child: Text(
              StringManager.loginToYourAccount,
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.displayMedium,
            )),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.red),
              borderRadius: BorderRadius.circular(10)),
          child: const Column(
            children: [
              Text(
                'email : user@test.com',
                textAlign: TextAlign.start,
                style: TextStyle(color: Colors.red),
              ),
              Text(
                'password : 123456',
                textAlign: TextAlign.start,
                style: TextStyle(color: Colors.red),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Expanded(
          flex: 3,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // email field
                MyTextField(
                    errorMessage: StringManager.emailIsRequired,
                    keyboardType: TextInputType.emailAddress,
                    icon: Icons.email_outlined,
                    controller: BlocProvider.of<LoginScreenCubit>(context)
                        .emailController,
                    hintText: 'user@test.com',
                    isError: state.status == Status.emailEmpty ? true : false),
                const SizedBox(
                  height: 30,
                ),
                // password field
                MyTextField(
                    isPassword: true,
                    errorMessage: StringManager.passwordIsRequired,
                    keyboardType: TextInputType.emailAddress,
                    icon: Icons.lock_open_sharp,
                    controller: BlocProvider.of<LoginScreenCubit>(context)
                        .passwordController,
                    hintText: StringManager.enterYourPassword,
                    isError:
                        state.status == Status.passwordEmpty ? true : false),
                const SizedBox(height: 30),
                // remember me button
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    fff(),
                    const SizedBox(width: 10),
                    Text(
                      'Remember me',
                      style: Theme.of(context).textTheme.labelMedium,
                    )
                  ],
                ),
                const SizedBox(height: 30),
                SizedBox(
                  height: 70,
                  child: ElevatedButton(
                      onPressed: () {
                        BlocProvider.of<LoginScreenCubit>(context).logIn();
                      },
                      child: Text(StringManager.singIn)),
                ),
                const SizedBox(height: 10),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.forgotPassword);
                    },
                    child: Text(StringManager.forgotPassword)),
                const SizedBox(height: 30),
                Center(
                    child: Text(
                  StringManager.orContinueWith,
                  style: Theme.of(context).textTheme.bodyLarge,
                )),
                const SizedBox(height: 30),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      Icons.facebook,
                      size: 60,
                    ),
                    Icon(
                      Icons.g_mobiledata,
                      size: 60,
                    ),
                    Icon(
                      Icons.apple,
                      size: 60,
                    )
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      StringManager.dontHaveAccount,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(StringManager.signUp)),
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

class fff extends StatefulWidget {
  const fff({
    super.key,
  });

  @override
  State<fff> createState() => _fffState();
}

class _fffState extends State<fff> {
  bool isClicked = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isClicked = !isClicked;
        });
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey[350], borderRadius: BorderRadius.circular(10)),
        height: 30,
        width: 30,
        child: (isClicked)
            ? Center(
                child: Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 8, 129, 12),
                        shape: BoxShape.circle)),
              )
            : null,
      ),
    );
  }
}
