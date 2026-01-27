// ignore_for_file: deprecated_member_use
import 'package:image_picker/image_picker.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mouvema/src/core/utils/string_manager.dart';
import 'package:mouvema/src/presentation/main/post_event/pages/search_map.dart';
import 'package:mouvema/src/presentation/main/post_event/widgets/hint_text.dart';
import '../../../../config/routes/routes.dart';
import '../../../../data/repository/repository_impl.dart';
import '../../../../injector.dart';
import 'package:latlong2/latlong.dart';

import '../cubits/post_event_cubit.dart';
import '../cubits/post_event_state.dart';
import '../widgets/details_input.dart';

// ignore: must_be_immutable
class PostLoadScreen extends StatelessWidget {
  PostLoadScreen({super.key});
  //LatLng? origin;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PostCubit>(
        create: (context) {
          return PostCubit(instance<RepositoryImpl>());
        },
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, Routes.main);
                },
                icon: const Icon(Icons.arrow_back_ios)),
            elevation: 4,
            title: const Text('Post Event'),
            centerTitle: true,
          ),
          body: BlocConsumer<PostCubit, PostState>(
            listener: ((context, state) {
              if (state.status == Status.success) {
                AwesomeDialog(
                    btnOkColor: Colors.teal,
                    context: context,
                    dialogType: DialogType.success,
                    animType: AnimType.topSlide,
                    title: StringManager.postLoaded,
                    btnOkOnPress: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, Routes.main, (route) => route.isFirst);
                    }).show();
              } else if (state.status == Status.loading) {
                showDialog(
                    context: context,
                    builder: ((context) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }));
              }
            }),
            builder: (context, state) {
              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                height: double.infinity,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        child: (state.img != null)
                            ? Image.memory(state.img!)
                            : Column(
                                children: [
                                  Center(
                                    child: IconButton(
                                      onPressed: () {
                                        BlocProvider.of<PostCubit>(context)
                                            .pickImage();
                                      },
                                      icon: const Icon(Icons.add_a_photo),
                                    ),
                                  ),
                                  const Text("Select an image")
                                ],
                              ),
                      ),
                      const Divider(height: 30),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          HintText(hint: 'Event adress'),
                        ],
                      ),
                      Container(
                          padding: const EdgeInsets.all(10),
                          height: 100,
                          width: double.infinity,
                          child: IconButton(
                              focusColor: Colors.teal,
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (ctx) => MapScreen(
                                          onchange: (p0) {
                                            BlocProvider.of<PostCubit>(context)
                                                .onPositionChanged(p0);
                                          },
                                        )));
                              },
                              icon: Image.asset(
                                'assets/images/MapMarker.png',
                              ))),
                      (state.status != Status.onPositionChanged)
                          ? const Text(
                              'Event adress is required ',
                              style: TextStyle(color: Colors.red, fontSize: 12),
                            )
                          : const Text(
                              'Event adress is selected',
                              style: TextStyle(color: Colors.green),
                            ),
                      const Divider(height: 30),
                      LoadDetailsForm(
                        origin: (state.status == Status.onPositionChanged)
                            ? state.data![0]
                            : null,
                        img: state.img,
                        onFormSubmited: (event, img) {
                          BlocProvider.of<PostCubit>(context)
                              .postLoad(event, img);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ));
  }
}
