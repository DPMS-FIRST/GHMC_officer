import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:ghmc_officer/Model/takeaction_response.dart';
import 'package:ghmc_officer/Res/components/appbar.dart';
import 'package:ghmc_officer/Res/components/background_image.dart';
import 'package:ghmc_officer/Res/components/button.dart';
import 'package:ghmc_officer/Res/components/image_picker.dart';
import 'package:ghmc_officer/Res/constants/providers/provider_notifiers.dart';

import '../Res/components/textwidget.dart';

class ApiResponse extends StatefulWidget {
  const ApiResponse({super.key});

  @override
  State<ApiResponse> createState() => _ApiResponseState();
}

class _ApiResponseState extends State<ApiResponse> {
  TakeActionModel? takeActionModel;
  List<String> items = [];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        children: <Widget>[
          BgImage(imgPath: "bg.png"),
          Column(
            children: [
              ReusableAppbar(
                  topPadding: 0,
                  screenWidth: 1,
                  screenHeight: 0.08,
                  bgColor: Colors.white,
                  appIcon: Icon(Icons.arrow_back),
                  title: "Take Action",
                  onPressed: (() {
                    Navigator.pop(context);
                  })),
              ValueListenableBuilder(
                valueListenable: selectedCountry,
                builder: (context, value, child) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 20),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.05,
                        width: MediaQuery.of(context).size.width * 0.88,
                        decoration: BoxDecoration(color: Colors.white),
                        child: DropdownButton(
                          hint: value == null
                              ? Text('Please Select Country')
                              : Text(
                                  value,
                                  style: TextStyle(color: Colors.black),
                                ),
                          isExpanded: true,
                          iconSize: 30.0,
                          dropdownColor: Colors.white,
                          iconEnabledColor: Colors.black,
                          style: TextStyle(color: Colors.black),
                          items: items.map(
                            (val) {
                              return DropdownMenuItem<String>(
                                value: val,
                                child: Text("  $val"),
                              );
                            },
                          ).toList(),
                          onChanged: (val) {
                            print(" $val");
                            selectedCountry.value = val;
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
              Center(
                child: Container(
                  color: Colors.white,
                  height: MediaQuery.of(context).size.height * 0.15,
                  width: MediaQuery.of(context).size.width * 0.88,
                  constraints: BoxConstraints(maxHeight: 200),
                  child: SingleChildScrollView(
                    child: TextField(
                      maxLines: null,
                      decoration: new InputDecoration.collapsed(
                          hintText: "Enter your Remarks",
                          hintStyle: TextStyle(color: Colors.grey)),
                    ),
                  ),
                ),
              ),
              CustomButton(
                  ico: Icons.camera_alt_outlined,
                  onclick: (() {
                    showAlert('');
                  }),
                  iconColor: Colors.white),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  // height: MediaQuery.of(context).size.height * 0.5,
                  child: Card(
                    color: Colors.transparent,
                    child: textButton(
                      text: "SUBMIT",
                      fontsize: 30,
                      textcolor: Colors.white,
                      onPressed: () {
                        //Navigator.pushNamed(context, AppRoutes.takeaction);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Text("hiiiii")
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    fetchDetails();
  }

  fetchDetails() async {
    const url =
        "https://19cghmc.cgg.gov.in/myghmcwebapi/Grievance/getStatusType";
    final pload = {
      "userid": "cgg@ghmc",
      "password": "ghmc@cgg@2018",
      "type_id": "1",
      "designation": "AMOH"
    };
    final _dioObject = Dio();
    try {
      final _response = await _dioObject.post(url, data: pload);
      var len = _response.data.length;
      //print(_response.data.length);

      for (var i = 0; i < len; i++) {
        final data = TakeActionModel.fromJson(_response.data[i]);

        setState(() {
          if (data.status == "success") {
            takeActionModel = data;
            items.add(data.type.toString());
            // print(items);
          }
        });
      }
    } on DioError catch (e) {
      print(e);
    }
  }

  showAlert(String message, {String text = ""}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: TextWidget(
              text: message + text,
              left: 0,
              right: 0,
              top: 0,
              bottom: 0,
              fontsize: 15,
              fontWeight: FontWeight.bold,
            ),
            // title: Text(message + text),
            actions: [
              TextButton(
                onPressed: () {
                  print("clicked");
                  // print("button Action");
                  Navigator.pop(context);
                },
                child: Text("ok"),
                //style: ButtonStyle(backgroundColor:),
              )
            ],
          );
        }); //showDialog
  } //
}
