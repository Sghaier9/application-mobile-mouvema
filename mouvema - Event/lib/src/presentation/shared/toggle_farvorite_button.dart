import 'package:flutter/material.dart';

import 'package:dartz/dartz.dart' as dartz;

import '../../core/failure.dart';
import '../../data/models/user.dart';
import '../../data/repository/repository_impl.dart';
import '../../injector.dart';

class ToggleFavorites extends StatefulWidget {
  const ToggleFavorites({super.key, required this.loadRef});

  final String loadRef;

  @override
  State<ToggleFavorites> createState() => _ToggoleFavoritesState();
}

class _ToggoleFavoritesState extends State<ToggleFavorites> {
  bool isAdded = false;
  late List<dynamic> favoriteLoads;

  void test() async {
    dartz.Either<Failure, MyUser> result =
        await repositoryImpl.getCurrentUserInformation();

    result.fold(
      (l) {
        setState(() {
          isAdded = false;
        });
      },
      (user) {
        favoriteLoads = user.favoriteLoads;
        if (favoriteLoads.contains(widget.loadRef)) {
          setState(() {
            isAdded = true;
          });
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    test();
  }

  final repositoryImpl = instance<RepositoryImpl>();
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () async {
          if (isAdded == true) {
            repositoryImpl.removeLoadFromFavorites(widget.loadRef);
            setState(() {
              isAdded = false;
            });
          } else {
            repositoryImpl.addLoadToFavorites(widget.loadRef);
            setState(() {
              isAdded = true;
            });
          }
        },
        icon: isAdded
            ? const Icon(Icons.bookmark)
            : const Icon(Icons.bookmark_add_outlined));
  }
}
