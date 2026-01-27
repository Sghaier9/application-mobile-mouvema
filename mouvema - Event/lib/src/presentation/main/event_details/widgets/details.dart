import 'package:flutter/material.dart';

import 'package:mouvema/src/core/utils/loadtypes.dart';

import 'package:timeline_tile/timeline_tile.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/helpers/date_handler.dart';
import '../../../../data/models/event.dart';

class Details extends StatefulWidget {
  const Details({super.key, required this.event});

  final Event event;

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              DateHandler.formatDate(widget.event.postDate.toString()),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text('Ref#${widget.event.eventRef.substring(0, 6)}',
                style: Theme.of(context).textTheme.bodyLarge),
          ],
        ),
        Text('Details', style: Theme.of(context).textTheme.headlineSmall),
        const Divider(),
        Row(
          children: [
            Expanded(
              child: ListTile(
                leading: const Icon(
                  Icons.location_on,
                  color: Colors.teal,
                  size: 30,
                ),
                title: Text(
                  widget.event.adress,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ),
            Expanded(
              child: ListTile(
                leading: const Icon(
                  Icons.person,
                  color: Colors.teal,
                  size: 30,
                ),
                title: Text(
                  'Responsible',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                subtitle: Text('${widget.event.respName} ',
                    style: Theme.of(context).textTheme.bodyMedium),
              ),
            ),
          ],
        ),
        SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(),
              Row(
                children: [
                  Expanded(
                    child: ListTile(
                        title: const Text('Price  '),
                        subtitle: Text('${widget.event.price} \$'),
                        leading: const Icon(
                          Icons.attach_money,
                          size: 40,
                        )),
                  ),
                  Expanded(
                    child: ListTile(
                        title: const Text('Event date'),
                        subtitle: Text("${widget.event.eventDate}"),
                        leading: const Icon(
                          Icons.date_range,
                          size: 40,
                        )),
                  ),
                ],
              ),
              const Divider(),
              if (widget.event.image.isNotEmpty)
                Image.network(
                  widget.event.image,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const Center(child: CircularProgressIndicator());
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.error, color: Colors.red);
                  },
                ),
              const Divider(),
              Text('description',
                  style: Theme.of(context).textTheme.headlineSmall),
              (widget.event.description != '')
                  ? Text(widget.event.description)
                  : SizedBox(height: 30),
              SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: FilledButton(
                      onPressed: () {
                        callNumber(widget.event.respPhone);
                      },
                      child: const Text('Call Responsible')))
            ],
          ),
        ),
      ],
    );
  }
}

Future<void> callNumber(String phoneNumber) async {
  phoneNumber = phoneNumber.replaceAll(' ', '');

  if (phoneNumber.startsWith('0')) {
    phoneNumber = '+33${phoneNumber.substring(1)}';
  }

  final Uri telUri = Uri(scheme: 'tel', path: phoneNumber);

  if (await canLaunchUrl(telUri)) {
    await launchUrl(
      telUri,
      mode: LaunchMode.externalApplication,
    );
  } else {
    throw 'Could not launch $phoneNumber';
  }
}

class PickAndDrop extends StatelessWidget {
  const PickAndDrop({
    super.key,
    required this.pickUpDate,
    required this.origin,
  });

  final String pickUpDate;
  final String origin;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TimelineTile(
          indicatorStyle: const IndicatorStyle(color: Colors.teal),
          afterLineStyle: const LineStyle(color: Colors.teal),
          isFirst: true,
          endChild: ListTile(
            title: Text(
              origin,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            subtitle: Text(DateHandler.formatDate(pickUpDate),
                style: Theme.of(context).textTheme.bodyMedium),
          ),
        ),
      ],
    );
  }
}
