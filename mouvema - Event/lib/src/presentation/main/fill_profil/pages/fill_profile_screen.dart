import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/src/injector.dart';
import '/src/presentation/main/fill_profil/cubit/fill_profile_cubit.dart';
import '../../../../config/routes/routes.dart';
import '../../../register/widgets/profile_photo.dart';
import '../../../shared/date.dart';
import '../../../shared/show_date_picker.dart';
import '../../../shared/text_field.dart';
import 'package:mouvema/src/data/repository/repository_impl.dart';

class FillProfileScreen extends StatelessWidget {
  const FillProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Fill Profile'),
          elevation: 4,
        ),
        body: BlocProvider(
            create: (context) => FillProfilCubit(instance<RepositoryImpl>()),
            child: BlocConsumer<FillProfilCubit, FillProfilState>(
                listener: (context, state) {
              if (state.status == Status.failed) {
                showDialog(
                  context: context,
                  builder: (ctx) {
                    return AlertDialog(
                        title: Text(state.errorMessage!),
                        actions: [
                          Center(
                            child: ElevatedButton(
                                onPressed: () {
                                  Navigator.of(ctx).pop();
                                },
                                child: const Text('OK')),
                          )
                        ]);
                  },
                );
              } else if (state.status == Status.success) {
                showDialog(
                  context: context,
                  builder: (ctx) {
                    return AlertDialog(
                      title: const Text('Your Profil Updated Succefully'),
                      actions: [
                        Center(
                            child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                      context, Routes.main);
                                },
                                child: const Text('Cancel')))
                      ],
                    );
                  },
                );
              }
            }, builder: (context, state) {
              if (state.status == Status.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return _getForm(
                    BlocProvider.of<FillProfilCubit>(context), state, context);
              }
            })));
  }

  Widget _getForm(
      FillProfilCubit mycubit, FillProfilState state, BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ProfilePhotoSelector(
                pictureFile: mycubit.photo,
                onPressed: () {
                  mycubit.addPhoto();
                }),
            MyTextField(
              errorMessage: 'username is required',
              keyboardType: TextInputType.name,
              icon: Icons.person,
              controller: mycubit.usernameController,
              hintText: 'Enter your username',
              isError: state.status == Status.failed &&
                      state.errorMessage == 'username empty'
                  ? true
                  : false,
            ),
            const SizedBox(height: 20),
            DateWidget(
              isError: false,
              label: state.status == Status.dateAdded
                  ? state.data.substring(0, 9)
                  : mycubit.birth,
              onPressed: () {
                pickDate(context).then((date) {
                  mycubit.dateAdded(date.toString());
                });
              },
            ),
            const SizedBox(height: 20),
            MyTextField(
              errorMessage: 'Enter your Tel',
              keyboardType: TextInputType.phone,
              icon: Icons.phone,
              controller: mycubit.telController,
              hintText: 'phone number',
              isError: state.status == Status.failed &&
                      state.errorMessage == 'email empty'
                  ? true
                  : false,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  mycubit.fillProfile();
                },
                child: const Text('Register')),
          ],
        ),
      ),
    );
  }
}
