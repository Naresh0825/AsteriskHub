import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_geocoder/geocoder.dart';
import 'package:flutter_geocoder/model.dart';
import 'package:geocoding/geocoding.dart';
import 'package:provider/provider.dart';
import 'package:startertemplate/commons/exporter.dart';
import 'package:startertemplate/pages/next_page.dart';
import 'package:startertemplate/providers/next_page_provider.dart';
import 'package:startertemplate/widgets/custom_clipper.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  NextPageProvider? readNextPageProvider;
  String homeAddress = '';
  @override
  void initState() {
    readNextPageProvider = context.read<NextPageProvider>();
    readNextPageProvider!.homeLocationController.text =
        '5055 Latigo Canyon Rd, Malibu, CA 90265';
    readNextPageProvider!.collegeLocationController.text =
        '417 Charles E Young Drive West, Los Angeles, CA 90095';
    super.initState();
  }

  // convertHomeAddress() async {
  //   readNextPageProvider = context.read<NextPageProvider>();
  //   final coordinates = Coordinates(34.069750615556835, -118.44910077405169);
  //   var homeaddress =
  //       await placemarkFromCoordinates(34.069750615556835, -118.44910077405169);
  //   // await Geocoder.google('AIzaSyDPoRmY8CE29lVvus9vMo-uozjWfDHpf5o')
  //   //     .findAddressesFromCoordinates(coordinates);
  //   homeAddress = homeaddress.first.name.toString();
  //   print(homeAddress);
  // }

  final formKey = GlobalKey<FormState>();
  void selectFromDate() async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: context.read<NextPageProvider>().selectedFromDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2090),
    );
    if (selected != null &&
        selected != readNextPageProvider!.selectedFromDate) {
      setState(() {
        readNextPageProvider!.setSelectedFromDate(selected);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    readNextPageProvider = context.read<NextPageProvider>();
    readNextPageProvider!.birthDate = readNextPageProvider!.selectedFromDate
        .toString()
        .split(" ")[0]
        .toString();
    Widget labelStartDate = InkWell(
      onTap: () {
        selectFromDate();
      },
      child: Container(
        height: size.height * 0.07,
        width: size.width * 0.35,
        padding: EdgeInsets.all(AppHeight.h8),
        decoration: BoxDecoration(
          border: Border.all(
            color: ColorManager.black,
          ),
          borderRadius: BorderRadius.circular(AppRadius.r10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.calendar_month),
            Center(
              child: Text(
                readNextPageProvider!.birthDate.toString(),
                style: getBoldStyle(
                  fontSize: FontSize.s14,
                  color: ColorManager.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );

    return WillPopScope(
      onWillPop: showExitPopup,
      child: Scaffold(
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: SizedBox(
            height: size.height,
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: -size.height * 0.15,
                  right: -size.width * 0.4,
                  child: SizedBox(
                    child: Transform.rotate(
                      angle: -pi / 3.5,
                      child: ClipPath(
                        clipper: ClipPainter(),
                        child: Container(
                          height: size.height * 0.5,
                          width: size.width,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                ColorManager.darkWhite,
                                ColorManager.blue,
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Consumer<NextPageProvider>(builder: (context, provider, child) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: AppWidth.w30),
                    child: SingleChildScrollView(
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(height: size.height * 0.1),
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                  text: 'Demo Form',
                                  style: getSemiBoldStyle(
                                    fontSize: FontSize.s30,
                                    color: ColorManager.blue,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '- Page 1',
                                      style: getSemiBoldStyle(
                                        color: ColorManager.black,
                                        fontSize: FontSize.s30,
                                      ),
                                    ),
                                  ]),
                            ),
                            SizedBox(height: AppHeight.h50),
                            Column(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: AppHeight.h10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "Name",
                                        style: getBoldStyle(
                                          fontSize: FontSize.s15,
                                          color: ColorManager.black,
                                        ),
                                      ),
                                      SizedBox(
                                        height: AppHeight.h4,
                                      ),
                                      TextFormField(
                                        style: getRegularStyle(
                                            fontSize: FontSize.s12,
                                            color: ColorManager.black),
                                        controller: readNextPageProvider!
                                            .nameController,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return '*Required';
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          fillColor: ColorManager.redWhite,
                                          filled: true,
                                          hintText: 'Name',
                                          suffixIcon: Icon(
                                            Icons.person,
                                            color: ColorManager.blue,
                                            size: FontSize.s20,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: ColorManager.blueGrey),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: ColorManager.primary),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: ColorManager.red),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'BirthDate               :  ',
                                  style: getSemiBoldStyle(
                                    fontSize: FontSize.s14,
                                    color: ColorManager.black,
                                  ),
                                ),
                                labelStartDate,
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'Gender                   :  ',
                                  style: getSemiBoldStyle(
                                    fontSize: FontSize.s14,
                                    color: ColorManager.black,
                                  ),
                                ),
                                SingleChildScrollView(
                                  child: Container(
                                    width: size.width * .5,
                                    margin: EdgeInsets.symmetric(
                                        vertical: AppHeight.h10),
                                    child: DropdownButtonFormField<String>(
                                      validator: (value) {
                                        if (value == null) {
                                          return '*Required';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        contentPadding:
                                            EdgeInsets.only(left: AppWidth.w4),
                                        fillColor: ColorManager.white,
                                        filled: true,
                                        hintText: 'Gender',
                                        hintStyle: getSemiBoldStyle(
                                          fontSize: FontSize.s14,
                                          color: ColorManager.blackOpacity54,
                                        ),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: ColorManager.blackOpacity38,
                                            width: AppWidth.w1,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                              AppRadius.r4),
                                        ),
                                      ),
                                      itemHeight: size.height * 0.07,
                                      isExpanded: true,
                                      icon: const Icon(Icons.arrow_drop_down),
                                      iconEnabledColor: ColorManager.skyBlue,
                                      iconSize: FontSize.s16,
                                      items: gender.map((project) {
                                        return DropdownMenuItem<String>(
                                          value: project['gender'],
                                          child: SizedBox(
                                            height: size.height * 0.07,
                                            width: double.infinity,
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                project['gender'].toString(),
                                                style: getMediumStyle(
                                                  fontSize: FontSize.s12,
                                                  color: ColorManager.black,
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (gender) {
                                        readNextPageProvider!.gender = gender!;
                                      },
                                      value: readNextPageProvider!.gender,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'Home Address  :  ',
                                  style: getSemiBoldStyle(
                                    fontSize: FontSize.s14,
                                    color: ColorManager.black,
                                  ),
                                ),
                                Container(
                                  width: size.width * .5,
                                  child: TextFormField(
                                    readOnly: true,
                                    style: getMediumStyle(
                                        fontSize: FontSize.s12,
                                        color: ColorManager.black),
                                    controller: readNextPageProvider!
                                        .homeLocationController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return '*Required';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      fillColor: ColorManager.redWhite,
                                      filled: true,
                                      hintText: 'Home ',
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: ColorManager.blueGrey),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: ColorManager.primary),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: ColorManager.red),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'Education            :  ',
                                  style: getSemiBoldStyle(
                                    fontSize: FontSize.s14,
                                    color: ColorManager.black,
                                  ),
                                ),
                                SingleChildScrollView(
                                  child: Container(
                                    width: size.width * .5,
                                    margin: EdgeInsets.symmetric(
                                        vertical: AppHeight.h10),
                                    child: DropdownButtonFormField<String>(
                                      validator: (value) {
                                        if (value == null) {
                                          return '*Required';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        contentPadding:
                                            EdgeInsets.only(left: AppWidth.w4),
                                        fillColor: ColorManager.white,
                                        filled: true,
                                        hintText: 'Education Degree',
                                        hintStyle: getSemiBoldStyle(
                                          fontSize: FontSize.s14,
                                          color: ColorManager.blackOpacity54,
                                        ),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: ColorManager.blackOpacity38,
                                            width: AppWidth.w1,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                              AppRadius.r4),
                                        ),
                                      ),
                                      itemHeight: size.height * 0.07,
                                      isExpanded: true,
                                      icon: const Icon(Icons.arrow_drop_down),
                                      iconEnabledColor: ColorManager.skyBlue,
                                      iconSize: FontSize.s16,
                                      items: education.map((project) {
                                        return DropdownMenuItem<String>(
                                          value: project['education'],
                                          child: SizedBox(
                                            height: size.height * 0.07,
                                            width: double.infinity,
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                project['education'].toString(),
                                                style: getMediumStyle(
                                                  fontSize: FontSize.s12,
                                                  color: ColorManager.black,
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (education) {
                                        readNextPageProvider!.education =
                                            education!;
                                      },
                                      value: readNextPageProvider!.education,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              margin:
                                  EdgeInsets.symmetric(vertical: AppHeight.h10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "College Name :",
                                    style: getBoldStyle(
                                      fontSize: FontSize.s15,
                                      color: ColorManager.black,
                                    ),
                                  ),
                                  SizedBox(
                                    width: AppWidth.w4,
                                  ),
                                  Container(
                                    width: size.width * .5,
                                    child: TextFormField(
                                      style: getRegularStyle(
                                          fontSize: FontSize.s12,
                                          color: ColorManager.black),
                                      controller: readNextPageProvider!
                                          .collegeController,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return '*Required';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        fillColor: ColorManager.redWhite,
                                        filled: true,
                                        hintText: 'College Name',
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: ColorManager.blueGrey),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: ColorManager.primary),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: ColorManager.red),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  'College Address:  ',
                                  style: getSemiBoldStyle(
                                    fontSize: FontSize.s14,
                                    color: ColorManager.black,
                                  ),
                                ),
                                Container(
                                  width: size.width * .5,
                                  child: TextFormField(
                                    readOnly: true,
                                    style: getMediumStyle(
                                        fontSize: FontSize.s12,
                                        color: ColorManager.black),
                                    controller: readNextPageProvider!
                                        .collegeLocationController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return '*Required';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      fillColor: ColorManager.redWhite,
                                      filled: true,
                                      hintText: 'College location',
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: ColorManager.blueGrey),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: ColorManager.primary),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: ColorManager.red),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: AppHeight.h20),
                            GestureDetector(
                              onTap: () {
                                if (formKey.currentState!.validate()) {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => DetailsPage(
                                        name: readNextPageProvider!
                                            .nameController.text,
                                        birthDate:
                                            readNextPageProvider!.birthDate!,
                                        gender: readNextPageProvider!.gender!,
                                        homeAddress: readNextPageProvider!
                                            .homeLocationController.text,
                                        collegeDegree:
                                            readNextPageProvider!.education!,
                                        collegeName: readNextPageProvider!
                                            .collegeController.text,
                                        collegeAddress: readNextPageProvider!
                                            .collegeLocationController.text),
                                  ));
                                }
                              },
                              child: Container(
                                width: size.width,
                                padding: EdgeInsets.symmetric(
                                    vertical: AppHeight.h14),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(AppRadius.r6)),
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                      color: Colors.grey.shade200,
                                      offset: const Offset(2, 4),
                                      blurRadius: 5,
                                      spreadRadius: 2,
                                    ),
                                  ],
                                  gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      ColorManager.blue,
                                      ColorManager.blue,
                                    ],
                                  ),
                                ),
                                child: Text(
                                  'Submit',
                                  style: getRegularStyle(
                                    color: ColorManager.white,
                                    fontSize: FontSize.s20,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: AppHeight.h12,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> showExitPopup() async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              'Exit App',
              style: getBoldStyle(
                fontSize: FontSize.s18,
                color: ColorManager.error,
              ),
            ),
            content: Text(
              'Do you want to exit an App?',
              style: getRegularStyle(
                fontSize: FontSize.s16,
                color: ColorManager.black,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                //return false when click on "NO"
                child: Text(
                  'No',
                  style: getRegularStyle(
                    fontSize: FontSize.s14,
                    color: ColorManager.green,
                  ),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                //return true when click on "Yes"
                child: Text(
                  'Yes',
                  style: getRegularStyle(
                    fontSize: FontSize.s14,
                    color: ColorManager.error,
                  ),
                ),
              ),
            ],
          ),
        ) ??
        false; //if showDialouge had returned null, then return false
  }
}
