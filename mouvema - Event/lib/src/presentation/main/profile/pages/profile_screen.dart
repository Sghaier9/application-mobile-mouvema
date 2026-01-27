import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mouvema/src/core/utils/string_manager.dart';
import 'package:mouvema/src/data/models/user.dart';
import 'package:mouvema/src/data/repository/repository_impl.dart';
import 'package:mouvema/src/presentation/main/profile/cubit/profile_cubit.dart';
import 'package:mouvema/src/presentation/main/profile/cubit/profile_state.dart';

import '../../../../config/routes/routes.dart';
import '../../../../injector.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  // final cubit = ProfileCubit(instance<RepositoryImpl>());
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileCubit>(
      create: (context) => ProfileCubit(instance<RepositoryImpl>()),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Your Profile"),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            child: BlocConsumer<ProfileCubit, ProfileState>(
              listener: (context, state) {
                if (state.status == Status.failed) {
                  AwesomeDialog(
                    btnOkColor: Colors.teal,
                    context: context,
                    dialogType: DialogType.error,
                    animType: AnimType.topSlide,
                    title: StringManager.error,
                  ).show();
                } else if (state.status == Status.logOut) {
                  Navigator.of(context).pushReplacementNamed(Routes.login);
                }
              },
              builder: (context, state) {
                if (state.status == Status.loading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state.status == Status.success) {
                  return _getProfile(
                      user: state.data!,
                      context: context,
                      onLogoutPressed: () {
                        BlocProvider.of<ProfileCubit>(context).logOut();
                      });
                } else {
                  return Center(
                      child:
                          Text(state.errorMessage ?? 'Something went wrong'));
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

Widget _getProfile(
    {required MyUser user,
    required BuildContext context,
    required VoidCallback onLogoutPressed}) {
  return SingleChildScrollView(
    child: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.4,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color.fromARGB(255, 167, 233, 226),
                  Color.fromARGB(255, 255, 255, 255)
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(
                  12), // Adjust the radius for rounded corners
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 180,
                  height: 180,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('assets/images/MOUVEMA.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Text(
                  user.username,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                Text(
                  user.email,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ],
            ),
          ),

          const Divider(height: 50),

          /// Features
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, Routes.fillProfil);
            },
            leading: const Icon(Icons.person),
            title: Text(StringManager.editProfile),
            trailing: const Icon(
              Icons.arrow_forward_ios_outlined,
              size: 20,
            ),
          ),

          ListTile(
            leading: const Icon(Icons.language),
            title: Text(StringManager.editLanguage),
            trailing: const Icon(
              Icons.arrow_forward_ios_outlined,
              size: 20,
            ),
          ),
          ListTile(
              leading: const Icon(Icons.light_mode),
              title: Text(StringManager.darkTheme)),
          // trailing:

          TextButton.icon(
              onPressed: onLogoutPressed,
              icon: const Icon(Icons.logout_outlined),
              label: Text(StringManager.singOut))
        ],
      ),
    ),
  );
}
