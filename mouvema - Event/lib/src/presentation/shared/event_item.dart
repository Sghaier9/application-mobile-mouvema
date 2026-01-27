import 'dart:ffi';

import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:mouvema/src/core/utils/color_manager.dart';
import 'package:mouvema/src/core/utils/string_manager.dart';

import '../../core/helpers/date_handler.dart';

import '../../data/models/event.dart';

class LoadItem extends StatefulWidget {
  const LoadItem(
      {super.key,
      required this.event,
      required this.detailsButton,
      required this.longPressed,
      required this.onPressed});
  final Event event;
  final VoidCallback detailsButton;
  final VoidCallback longPressed;
  final VoidCallback onPressed;

  @override
  State<LoadItem> createState() => _LoadItemState();
}

class _LoadItemState extends State<LoadItem> {
  bool ispressed = false;

  @override
  Widget build(BuildContext context) {
    Duration age = DateHandler.diffBetween2Dates(
        start: DateHandler.convertStringToDate(date: widget.event.postDate),
        end: DateHandler.convertStringToDate(
            date: DateTime.now().toString().substring(0, 10)));

    return GestureDetector(
      onTap: widget.onPressed,
      onLongPress: () {
        ispressed = !ispressed;
        widget.longPressed();
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: const [BoxShadow(blurRadius: 5, color: Colors.grey)],
            border:
                ispressed ? Border.all(color: Colors.teal, width: 2) : null),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(children: [
          // ***** little banner ******
          Row(
            children: [
              Text(
                '${StringManager.age}: ${DateHandler.handleAge(age)}',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const Spacer(),
              Text(
                DateHandler.formatDate(widget.event.postDate.toString()),
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const Spacer(),
            ],
          ),
          const Divider(),
          Row(
            children: [
              const Icon(
                Icons.location_on,
                size: 20,
                color: Colors.green,
              ),
              const SizedBox(
                width: 15,
              ),
              Text(
                widget.event.adress.split(',').length >= 2
                    ? "${widget.event.adress.split(',')[0]}, ${widget.event.adress.split(',')[1]}"
                    : "${widget.event.adress}",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const Spacer(),
              Text(DateHandler.formatDate(widget.event.eventDate))
            ],
          ),
          const SizedBox(
            height: 8,
          ),

          if (widget.event.image.isNotEmpty)
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              width: double.infinity,
              child: Image.network(
                widget.event.image,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(child: CircularProgressIndicator());
                },
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.error, color: Colors.red);
                },
              ),
            ),

          const Divider(),
          Row(
            children: [
              Column(
                children: [
                  Text(
                    StringManager.broker,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    widget.event.respName,
                    style: Theme.of(context).textTheme.titleSmall,
                  )
                ],
              ),
              const Spacer(),
              FilledButton(
                onPressed: widget.detailsButton,
                child: Text(
                  StringManager.viewDetails,
                ),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
