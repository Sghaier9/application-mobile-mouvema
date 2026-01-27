import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import '../../../../data/data_source/remote_data_source/geocoding.dart';
import '../../../../data/models/event.dart';
import 'icon_text_field.dart';
import 'pick_date_button.dart';
import 'package:latlong2/latlong.dart';

class LoadDetailsForm extends StatefulWidget {
  const LoadDetailsForm({
    super.key,
    required this.onFormSubmited,
    required this.origin,
    required this.img,
  });
  final void Function(Event load, Uint8List img) onFormSubmited;
  final LatLng? origin;
  final Uint8List? img;
  @override
  State<LoadDetailsForm> createState() => _LoadDetailsFormState();
}

class _LoadDetailsFormState extends State<LoadDetailsForm> {
  String _pickUpDate = 'YYYY-MM-DD';

  //Global key for the form
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Textfiled controlers
  late String _name;
  late String _tel;
  late String _price;

  final TextEditingController _descriptionController = TextEditingController();

  Future<String> toHumanReadableAddress(
      double latitude, double longitude) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);

      if (placemarks.isEmpty) return 'Adresse inconnue';

      Placemark place = placemarks.first;
      return [
        place.street,
        place.subLocality,
        place.locality,
        place.postalCode,
        place.country
      ].where((part) => part != null && part.isNotEmpty).join(', ');
    } catch (e) {
      debugPrint('Erreur de géocodage: $e');
      return 'Impossible de récupérer l\'adresse';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: PickDateButton(
                    title: 'Event date',
                    onDateChanged: (date) {
                      setState(() {
                        _pickUpDate = date;
                      });
                    }),
              ),
            ],
          ),
          (_pickUpDate == 'YYYY-MM-DD')
              ? const Text('Event date is required',
                  style: TextStyle(
                      color: Color.fromARGB(255, 204, 17, 4), fontSize: 12))
              : const Text(''),
          const Divider(),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: IconTextField(
                    isValid: (value) {
                      return (value != '');
                    },
                    getValue: (inputValue) {
                      _name = inputValue;
                    },
                    errorText: 'The name is required',
                    hint: 'responsible name',
                    icon: const Icon(Icons.person),
                    keyboard: TextInputType.name),
              ),
              const Spacer(
                flex: 1,
              ),
            ],
          ),

          // name and tel
          Row(
            children: [
              Expanded(
                  flex: 3,
                  child: IconTextField(
                      isValid: (value) {
                        if (value != null &&
                            value.replaceAll(" ", "").length == 10 &&
                            double.tryParse(value) != null) {
                          return true;
                        }
                        return false;
                      },
                      getValue: (inputValue) {
                        _tel = inputValue;
                      },
                      errorText: 'Phone number is required',
                      hint: '0x xx xx xx xx',
                      icon: const Icon(Icons.phone),
                      keyboard: TextInputType.number)),
              const Spacer(
                flex: 1,
              ),
            ],
          ),

          const Divider(height: 30),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: IconTextField(
                  isValid: (value) {
                    if (value != null && double.tryParse(value) != null) {
                      return true;
                    }
                    return false;
                  },
                  getValue: (inputValue) {
                    _price = inputValue;
                  },
                  errorText: 'Price is required',
                  hint: 'price',
                  icon: const Icon(Icons.attach_money),
                  keyboard: TextInputType.number,
                ),
              ),
              const Spacer(
                flex: 1,
              ),
            ],
          ),

          const Divider(height: 30),
          // Description
          TextField(
            controller: _descriptionController,
            maxLines: 4, // Allow multiple lines
            decoration: InputDecoration(
              hintText: 'Enter your event description ...',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
            ),
          ),
          // **** Buttons
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel')),
              const SizedBox(width: 20),
              FilledButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate() &&
                        widget.origin != null &&
                        widget.img != null) {
                      formKey.currentState!.save();

                      String humanOrigin = await toHumanReadableAddress(
                          widget.origin!.latitude, widget.origin!.longitude);

                      widget.onFormSubmited(
                          Event(
                              adress: "${humanOrigin.split(',')[0]}",
                              eventRef: '',
                              respName: _name,
                              respPhone: _tel,
                              adressLat: widget.origin!.latitude,
                              adressLng: widget.origin!.longitude,
                              postDate:
                                  DateTime.now().toString().substring(0, 10),
                              eventDate: _pickUpDate,
                              price: int.parse(_price),
                              description: _descriptionController.text,
                              image: ''),
                          widget.img!);
                    }
                  },
                  child: const Text('Post Event')),
            ],
          )
        ],
      ),
    );
  }
}
