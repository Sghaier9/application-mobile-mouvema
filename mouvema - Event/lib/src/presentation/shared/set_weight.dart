import 'package:flutter/material.dart';

class SetPrice extends StatefulWidget {
  const SetPrice({super.key, required this.onPriceChanged});
  final void Function(RangeValues) onPriceChanged;
  @override
  State<SetPrice> createState() => _SetPriceState();
}

class _SetPriceState extends State<SetPrice> {
  RangeValues _currentRangeValues = const RangeValues(0, 60);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(children: [
            const Spacer(),
            Text(
                '${_currentRangeValues.start.round()}-${_currentRangeValues.end.round()} \$'
            )
          ]),
        ),
        RangeSlider(
          values: _currentRangeValues,
          min: 0,
          max: 100,
          divisions: 10,
          labels: RangeLabels(
            _currentRangeValues.start.round().toString(),
            _currentRangeValues.end.round().toString(),
          ),
          onChanged: (RangeValues values) {
            setState(() {
              _currentRangeValues = values;
              widget.onPriceChanged(_currentRangeValues);
            });
          },
        ),
      ],
    );
  }
}

