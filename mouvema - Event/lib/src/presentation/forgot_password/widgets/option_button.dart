import 'package:flutter/material.dart';

class OptionButton extends StatelessWidget {
  const OptionButton(
      {super.key,
      required this.via,
      required this.value,
      required this.onPressed,
      required this.iconData,
      required this.isPressed});
  final String via;
  final String value;
  final IconData iconData;
  final VoidCallback onPressed;
  final bool isPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 198, 234, 230),
          borderRadius: BorderRadius.circular(20),
          border: isPressed ? Border.all(color: Colors.teal, width: 5) : null),
      child: Center(
        child: ListTile(
          onTap: onPressed,
          leading: CircleAvatar(
              maxRadius: 40,
              minRadius: 35,
              backgroundColor: const Color.fromARGB(255, 188, 243, 238),
              child: Icon(
                iconData,
                color: Colors.teal,
                size: 35,
              )),
          title: Text('via $via'),
          subtitle: Text(
            value,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      ),
    );
  }
}
