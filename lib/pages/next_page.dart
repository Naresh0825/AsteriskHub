import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:startertemplate/commons/exporter.dart';
import 'package:startertemplate/providers/next_page_provider.dart';

class DetailsPage extends StatefulWidget {
  final String name;
  final String birthDate;
  final String gender;
  final String homeAddress;
  final String collegeDegree;
  final String collegeName;
  final String collegeAddress;
  const DetailsPage(
      {super.key,
      required this.name,
      required this.birthDate,
      required this.gender,
      required this.homeAddress,
      required this.collegeDegree,
      required this.collegeName,
      required this.collegeAddress});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(34.037509, -118.768064),
    zoom: 14.4746,
  );
  List<Marker> marker = [];
  List<Marker> _list = [
    const Marker(
        markerId: MarkerId('Home'),
        position: LatLng(34.037481647627025, -118.76806217344323),
        infoWindow:
            InfoWindow(title: '5055 Latigo Canyon Rd, Malibu, CA 90265')),
    const Marker(
        markerId: MarkerId('College'),
        position: LatLng(34.069750615556835, -118.44910077405169),
        infoWindow: InfoWindow(
            title: '417 Charles E Young Drive West, Los Angeles, CA 90095')),
  ];

  @override
  void initState() {
    marker.addAll(_list);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    NextPageProvider readNextPageProvider = context.read<NextPageProvider>();
    return Scaffold(body: SafeArea(
      child: Consumer<NextPageProvider>(builder: (context, provider, child) {
        return Stack(
          children: [
            Positioned(
                top: 13.0,
                left: 2.0,
                child: IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(AppHeight.h20),
                  child: Text(
                    'Demo Form - Page 2',
                    style: getBoldStyle(
                        fontSize: FontSize.s25, color: ColorManager.black),
                  ),
                ),
                Container(
                  height: 200,
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.only(left: AppWidth.w15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'Name:  ',
                                  style: getMediumStyle(
                                      fontSize: FontSize.s16,
                                      color: ColorManager.black),
                                ),
                                Text(
                                  'Date of Birth:  ',
                                  style: getMediumStyle(
                                      fontSize: FontSize.s16,
                                      color: ColorManager.black),
                                ),
                                Text(
                                  'Gender:  ',
                                  style: getMediumStyle(
                                      fontSize: FontSize.s16,
                                      color: ColorManager.black),
                                ),
                                Container(
                                  height: size.height * .05,
                                  width: size.width * .33,
                                  child: Text(
                                    'Home Address  :',
                                    style: getMediumStyle(
                                        fontSize: FontSize.s16,
                                        color: ColorManager.black),
                                  ),
                                ),
                                Text(
                                  'Education  :',
                                  style: getMediumStyle(
                                      fontSize: FontSize.s16,
                                      color: ColorManager.black),
                                ),
                                Text(
                                  'College Name  :',
                                  style: getMediumStyle(
                                      fontSize: FontSize.s16,
                                      color: ColorManager.black),
                                ),
                                Text(
                                  'College Address  :',
                                  style: getMediumStyle(
                                      fontSize: FontSize.s16,
                                      color: ColorManager.black),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.name!,
                                  style: getMediumStyle(
                                      fontSize: FontSize.s16,
                                      color: ColorManager.black),
                                ),
                                Text(
                                  widget.birthDate!,
                                  style: getMediumStyle(
                                      fontSize: FontSize.s16,
                                      color: ColorManager.black),
                                ),
                                Text(
                                  widget.gender!,
                                  style: getMediumStyle(
                                      fontSize: FontSize.s16,
                                      color: ColorManager.black),
                                ),
                                Container(
                                  height: size.height * .05,
                                  width: size.width * .6,
                                  child: Text(
                                    widget.homeAddress!,
                                    maxLines: 2,
                                    style: getMediumStyle(
                                        fontSize: FontSize.s16,
                                        color: ColorManager.black),
                                  ),
                                ),
                                Text(
                                  widget.collegeDegree!,
                                  style: getMediumStyle(
                                      fontSize: FontSize.s16,
                                      color: ColorManager.black),
                                ),
                                Text(
                                  widget.collegeName!,
                                  style: getMediumStyle(
                                      fontSize: FontSize.s16,
                                      color: ColorManager.black),
                                ),
                                Container(
                                  height: size.height * .05,
                                  width: size.width * .6,
                                  child: Text(
                                    widget.collegeAddress,
                                    maxLines: 2,
                                    style: getMediumStyle(
                                        fontSize: FontSize.s16,
                                        color: ColorManager.black),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(
                  height: 2,
                  color: ColorManager.black,
                ),
                Row(
                  children: [
                    Text(
                      'College ',
                      style: getMediumStyle(
                          fontSize: FontSize.s16, color: ColorManager.black),
                    ),
                    Switch(
                      activeColor: ColorManager.darkGreen,
                      value: provider.switchSelected,
                      onChanged: (value) async {
                        provider.setSwitchSelected(value);
                        GoogleMapController controller =
                            await readNextPageProvider
                                .googleMapController.future;
                        provider.switchSelected
                            ? controller.animateCamera(
                                CameraUpdate.newCameraPosition(
                                    const CameraPosition(
                                        target: LatLng(34.037481647627025,
                                            -118.76806217344323),
                                        zoom: 30)))
                            : controller.animateCamera(
                                CameraUpdate.newCameraPosition(
                                    const CameraPosition(
                                        target: LatLng(34.069636210913885,
                                            -118.44911150000075),
                                        zoom: 30)));
                        setState(() {});
                      },
                    ),
                    Text(
                      'Home ',
                      style: getMediumStyle(
                          fontSize: FontSize.s16, color: ColorManager.black),
                    ),
                  ],
                ),
                Expanded(
                  child: GoogleMap(
                    markers: Set<Marker>.of(marker),
                    initialCameraPosition: _kGooglePlex,
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                    onMapCreated: (GoogleMapController controller) {
                      readNextPageProvider.googleMapController
                          .complete(controller);
                    },
                  ),
                ),
              ],
            ),
          ],
        );
      }),
    ));
  }
}
