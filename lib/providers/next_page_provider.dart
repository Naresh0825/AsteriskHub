import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class NextPageProvider extends ChangeNotifier {
  Completer<GoogleMapController> googleMapController = Completer();
  bool switchSelected = false;
  String? gender, birthDate, education;
  List<Address>? homeaddress;
  DateTime _selectedFromDate = DateTime.now();
  DateTime get selectedFromDate => _selectedFromDate;

  TextEditingController nameController = TextEditingController();
  TextEditingController collegeController = TextEditingController();
  TextEditingController homeLocationController = TextEditingController();
  TextEditingController collegeLocationController = TextEditingController();
  setSelectedFromDate(DateTime dateTime) {
    _selectedFromDate = dateTime;
    notifyListeners();
  }

  setSwitchSelected(bool value) {
    switchSelected = value;
    notifyListeners();
  }

  changeLocation() async {
    notifyListeners();
  }

  bool home = true;

  changeHome() {
    home = !home;
  }
}
