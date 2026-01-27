import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mouvema/src/core/utils/image_manager.dart';
import '../../filter/filter_screen.dart';

class AppBarz extends StatelessWidget {
  const AppBarz({
    super.key,
    required this.onSearch,
  });
  final Function(String? adress,
      RangeValues? price) onSearch;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          /*SvgPicture.asset(
            ImageManager.logo,
            height: 50,
            width: 50,
          ),*/
          SizedBox(width: 50),
          const Text('Mouvema'),
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (ctx) {
                      return FilterScreen(
                        onSearchClicked:
                            (adress,price) {
                          onSearch(adress, price);
                        },
                      );
                    });
              },
              icon: const Icon(Icons.filter_alt_outlined, size: 30)),
        ],
      ),
      floating: true,
      elevation: 4,
    );
  }
}
