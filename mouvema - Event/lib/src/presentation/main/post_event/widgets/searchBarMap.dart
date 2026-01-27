import 'package:flutter/material.dart';

class SearchBarMap extends StatelessWidget {
  const SearchBarMap({
    super.key,
    required this.location,
    required this.onSearch,
  });
  final String location;
  final void Function(String) onSearch;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onSubmitted: (value) {
        onSearch(value);
      },
      decoration: InputDecoration(
        hintText: 'choose the $location',
        hintStyle: const TextStyle(color: Colors.black54),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            width: 0.5,
            color: Colors.teal,
          ),
        ),
      ),
      style: Theme.of(context).textTheme.titleMedium,
    );
  }
}
