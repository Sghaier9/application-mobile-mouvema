import 'package:flutter/material.dart';
import '../../shared/choose_location_button.dart';
import '../../shared/set_weight.dart';

class FilterScreen extends StatelessWidget {
  FilterScreen({
    super.key,
    required this.onSearchClicked,
  });

  final void Function(String? adress, RangeValues? price) onSearchClicked;

  String? adress;
  RangeValues? price;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Filter'),
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back_ios))),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LocationButton(
                hint: 'Adress',
                onLocationSelected: (val) {
                  adress = val;
                },
              ),
              const SizedBox(height: 10),
              const Divider(
                color: Colors.grey,
              ),
              Text(
                'Price',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(
                height: 10,
              ),
              SetPrice(
                onPriceChanged: (val) {
                  price = val;
                },
              ),
              const SizedBox(height: 20),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel')),
                const SizedBox(width: 16),
                ElevatedButton(
                    onPressed: () {
                      onSearchClicked(adress, price);
                      Navigator.pop(context);
                    },
                    child: const Text('Search'))
              ])
            ],
          ),
        ),
      ),
    );
  }
}
