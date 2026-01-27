import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

final List<String> items = [
  "Paris",
  "Marseille",
  "Lyon",
  "Toulouse",
  "Nice",
  "Nantes",
  "Strasbourg",
  "Montpellier",
  "Bordeaux",
  "Lille",
  "Rennes",
  "Reims",
  "Le Havre",
  "Saint-Étienne",
  "Toulon",
  "Grenoble",
  "Dijon",
  "Angers",
  "Nîmes",
  "Villeurbanne",
  "Saint-Denis",
  "Le Mans",
  "Aix-en-Provence",
  "Clermont-Ferrand",
  "Brest",
  "Tours",
  "Amiens",
  "Limoges",
  "Annecy",
  "Perpignan",
  "Boulogne-Billancourt",
  "Metz",
  "Besançon",
  "Orléans",
  "Argenteuil",
  "Rouen",
  "Mulhouse",
  "Caen",
  "Nancy",
];

class LocationButton extends StatefulWidget {
  LocationButton(
      {super.key, required this.hint, required this.onLocationSelected});
  final void Function(String) onLocationSelected;
  final String hint;
  String? selectedValue;
  final TextEditingController textEditingController = TextEditingController();
  @override
  State<LocationButton> createState() => _LocationButtonState();
}

class _LocationButtonState extends State<LocationButton> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: false,

        hint: Text(
          widget.hint,
          style: TextStyle(
            fontSize: 14,
            color: Theme.of(context).hintColor,
          ),
        ),
        items: items
            .map((item) => DropdownMenuItem(
                  value: item,
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ))
            .toList(),
        value: widget.selectedValue,
        onChanged: (value) {
          setState(() {
            widget.onLocationSelected(value!);
            widget.selectedValue = value;
          });
        },
        buttonStyleData: ButtonStyleData(
          elevation: 4,
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [
              Color.fromARGB(255, 145, 239, 229),
              Color.fromARGB(255, 55, 178, 166)
            ]),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          height: 50,
          width: double.infinity,
        ),
        dropdownStyleData: DropdownStyleData(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          maxHeight: 300,
        ),

        menuItemStyleData: const MenuItemStyleData(
          height: 40,
        ),
        dropdownSearchData: DropdownSearchData(
          searchController: widget.textEditingController,
          searchInnerWidgetHeight: 40,
          searchInnerWidget: Container(
            height: 50,
            padding: const EdgeInsets.only(
              top: 10,
              bottom: 4,
              right: 8,
              left: 8,
            ),
            child: Material(
              borderRadius: BorderRadius.circular(10),
              elevation: 8,
              child: TextField(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                expands: false,
                maxLines: null,
                controller: widget.textEditingController,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                    hintText: 'Search ',
                    hintStyle: const TextStyle(fontSize: 12),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
            ),
          ),
          searchMatchFn: (item, searchValue) {
            return item.value.toString().toLowerCase().contains(searchValue);
          },
        ),
        //This to clear the search value when you close the menu
        onMenuStateChange: (isOpen) {
          if (!isOpen) {
            widget.textEditingController.clear();
          }
        },
      ),
    );
  }
}


// @override
// void dispose() {
//   textEditingController.dispose();
//   super.dispose();
// }




// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/material.dart';

// class ChooseLocationButton extends StatefulWidget {
//   const ChooseLocationButton({
//     super.key,
//     required this.onlocationschanged,
//   });

//   final void Function(String location) onlocationschanged;

//   @override
//   State<ChooseLocationButton> createState() => _ChooseLocationButtonState();
// }

// class _ChooseLocationButtonState extends State<ChooseLocationButton> {
//   List<String> towns = [
//     'Tunis',
//     'Sfax',
//     'Sousse',
//     'Kairouan',
//     'Bizerte',
//     'Gabes',
//     'Ariana',
//     'Gafsa',
//     'Kasserine',
//     'Monastir',
//     'Tataouine',
//     'Medenine',
//     'Nabeul',
//     'Beja',
//     'Ben Arous',
//     'Siliana',
//     'Jendouba',
//     'Mahdia',
//     'Kebili',
//     'La Manouba',
//     'Tozeur',
//     'Kef',
//     'Zaghouan',
//     'Sidi Bouzid',
//   ];
//   String selectedLocation = 'choose a place';
//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: GlobalKey(),
//       child: Column(children: [
//         DropdownButton2(items: [
//           const DropdownMenuItem(
//               value: 'choose a place', child: Text('choose a place')),
//           ...(towns
//               .map((e) => DropdownMenuItem(value: e, child: Text(e)))
//               .toList())
//         ])
//       ]),
//     );
//   }
// }

// // Form(
// //       key: GlobalKey(),
// //       child: DropdownButtonFormField(
// //         value: selectedLocation,
// //         items: [
// //           const DropdownMenuItem(
// //               value: 'choose a place', child: Text('choose a place')),
// //           ...(towns
// //               .map((e) => DropdownMenuItem(value: e, child: Text(e)))
// //               .toList())
// //         ],
// //         onChanged: (value) {
// //           if (value != null) {
// //             widget.onlocationschanged(value);
// //             setState(() {
// //               selectedLocation = value;
// //             });
// //           }
// //         },
// //       ),
// //     );
