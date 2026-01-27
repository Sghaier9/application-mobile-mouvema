import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/routes/routes.dart';
import '../../../../data/repository/repository_impl.dart';
import '../../../../injector.dart';
import '../../../shared/event_item.dart';
import '../cubit/my_events_cubit.dart';
import '../cubit/my_events_state.dart';

class MyLoadsScreen extends StatefulWidget {
  const MyLoadsScreen({super.key});

  @override
  State<MyLoadsScreen> createState() => _MyLoadsScreenState();
}

class _MyLoadsScreenState extends State<MyLoadsScreen> {
  List<String> loadsToDelete = [];
  final MyLoadsCubit loadsCubit = MyLoadsCubit(instance<RepositoryImpl>());

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MyLoadsCubit>(
      create: (context) => loadsCubit,
      child: Scaffold(
        appBar: _appBar(context, () {
          loadsCubit.deleteLoads(loadsToDelete);
        }),
        body: BlocBuilder<MyLoadsCubit, MyloadsState>(
          builder: (context, state) {
            if (state.status == Status.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.status == Status.success &&
                (state.data!.length == 0)) {
              return Center(child: Text("No Events posted"));
            } else if (state.status == Status.success) {
              return ListView.builder(
                  itemCount: state.data!.length,
                  itemBuilder: (context, index) {
                    return LoadItem(
                      onPressed: () {
                        Navigator.pushNamed(context, Routes.loadDetails,
                            arguments: state.data![index]);
                      },
                      longPressed: () {
                        setState(() {
                          if (loadsToDelete
                              .contains(state.data![index].eventRef)) {
                            loadsToDelete.remove(state.data![index].eventRef);
                          } else {
                            loadsToDelete.add(state.data![index].eventRef);
                          }
                        });
                      },
                      detailsButton: () {
                        Navigator.pushNamed(context, Routes.loadDetails,
                            arguments: state.data![index]);
                      },
                      event: state.data![index],
                    );
                  });
            } else {
              return Center(
                  child: Text(state.message ?? 'Something went Wrong'));
            }
          },
        ),
      ),
    );
  }

  AppBar _appBar(BuildContext context, VoidCallback onDelete) {
    return AppBar(
      leading: null,
      title: const Text(
        'My Events',
      ),
      centerTitle: true,
      actions: [
        IconButton(
            onPressed: () {
              (loadsToDelete.isNotEmpty)
                  ? AwesomeDialog(
                      btnOkColor: Colors.teal,
                      context: context,
                      dialogType: DialogType.warning,
                      animType: AnimType.topSlide,
                      title: 'Are you sure',
                      btnOkOnPress: () {
                        onDelete();
                      }).show()
                  : showDialog(
                      context: context,
                      builder: (ctx) {
                        return AlertDialog(
                          title: const Text('Select the events'),
                          actions: [
                            Center(
                              child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(ctx).pop();
                                  },
                                  child: const Text('ok')),
                            )
                          ],
                        );
                      },
                    );
            },
            icon: const Icon(Icons.delete_outlined))
      ],
    );
  }
}
