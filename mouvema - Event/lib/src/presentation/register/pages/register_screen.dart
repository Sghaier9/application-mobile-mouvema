import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mouvema/src/config/routes/routes.dart';
import 'package:mouvema/src/core/utils/string_manager.dart';
import '../../../data/repository/repository_impl.dart';
import '../../../injector.dart';
import '../../shared/text_field.dart';
import '../cubit/register_cubit.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegisterCubit>(
      create: (context) => RegisterCubit(instance<RepositoryImpl>()),
      child: Scaffold(
        appBar: AppBar(
          elevation: 4,
          title: const Text('Register'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: BlocConsumer<RegisterCubit, RegisterState>(
            listener: (context, state) {
              if (state.status == Status.registerSuccess) {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Registration Complete'),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, Routes.loginWithPassword);
                              },
                              child: const Text('Sign In'))
                        ],
                      );
                    });
              } else if (state.status == Status.registerFailed) {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Error'),
                        content: Text(state.errorMessage!),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Try again'))
                        ],
                      );
                    });
              }
            },
            builder: (context, state) {
              return state.status == Status.loading
                  ? const Center(child: CircularProgressIndicator())
                  : registerContent(context);
            },
          ),
        ),
      ),
    );
  }

  Column registerContent(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            child: Text(
          'Create your \nAccount',
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.displayMedium,
        )),
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
                    controller:
                        BlocProvider.of<RegisterCubit>(context).emailController,
                    hintText: 'user@example.com',
                    isError: false),
                const SizedBox(
                  height: 30,
                ),
                // password field
                MyTextField(
                    isPassword: true,
                    errorMessage: StringManager.passwordIsRequired,
                    keyboardType: TextInputType.emailAddress,
                    icon: Icons.lock_open_sharp,
                    controller: BlocProvider.of<RegisterCubit>(context)
                        .passwordController,
                    hintText: StringManager.enterYourPassword,
                    isError: false),
                const SizedBox(height: 30),
                // remember me button
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(10)),
                        height: 30,
                        width: 30,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      StringManager.rememberMe,
                      style: Theme.of(context).textTheme.labelMedium,
                    )
                  ],
                ),
                const SizedBox(height: 30),
                SizedBox(
                  height: 70,
                  child: FilledButton(
                      onPressed: () {
                        BlocProvider.of<RegisterCubit>(context).register();
                      },
                      child: Text(StringManager.signUp)),
                ),
                const SizedBox(
                  height: 30,
                ),
                Center(
                    child: Text(
                  StringManager.orContinueWith,
                  style: Theme.of(context).textTheme.bodyLarge,
                )),
                const SizedBox(height: 30),
               const  Icon(
                  Icons.facebook,
                  size: 60,
                 color: Colors.teal,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      StringManager.alreadyHaveAccount,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(StringManager.singIn)),
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }

//   Column _getForm(
//       RegisterCubit mycubit, RegisterState state, BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         MyTextField(
//           labelText: 'username',
//           errorMessage: 'username is required',
//           keyboardType: TextInputType.name,
//           icon: null,
//           controller: mycubit.usernameController,
//           hintText: 'Enter your username',
//           isError:
//               state is RegisterError && state.errorMessage == 'username empty'
//                   ? true
//                   : false,
//         ),
//         const SizedBox(height: 20),
//         DateWidget(
//           isError: state is RegisterError && state.errorMessage == 'date empty'
//               ? true
//               : false,
//           label: state is RegisterDateAdded
//               ? state.date.substring(0, 9)
//               : mycubit.birth,
//           onPressed: () {
//             pickDate(context).then((date) {
//               mycubit.dateAdded(date.toString());
//             });
//           },
//         ),
//         const SizedBox(height: 20),
//         MyTextField(
//           labelText: 'email',
//           errorMessage: 'email is required',
//           keyboardType: TextInputType.name,
//           icon: null,
//           controller: mycubit.emailController,
//           hintText: 'user@example.com',
//           isError: state is RegisterError && state.errorMessage == 'email empty'
//               ? true
//               : false,
//         ),
//         const SizedBox(height: 20),
//         MyTextField(
//           isPassword: true,
//           labelText: 'password',
//           errorMessage: 'password is required',
//           keyboardType: TextInputType.name,
//           icon: null,
//           controller: mycubit.passwordController,
//           hintText: 'Enter your password',
//           isError: ((state is RegisterError) &&
//                   state.errorMessage == 'password empty')
//               ? true
//               : false,
//         ),
//         const SizedBox(height: 20),
//         ElevatedButton(
//             onPressed: () {
//               mycubit.register();
//             },
//             child: const Text('Register')),
//       ],
//     );
//   }
}
