import 'package:dio/dio.dart';

import 'package:flutter/material.dart';

import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';
import 'package:ghmc_officer/Model/reset_mpin_response.dart';
import 'package:ghmc_officer/Res/components/sharedpreference.dart';
import 'package:ghmc_officer/Res/constants/routes/app_routes.dart';

import '../Res/components/textwidget.dart';
import '../Res/constants/ApiConstants/api_constants.dart';

class NewResetMpinScreen extends StatefulWidget {
  const NewResetMpinScreen({super.key});

  @override
  State<NewResetMpinScreen> createState() => _NewResetMpinScreenState();
}

class _NewResetMpinScreenState extends State<NewResetMpinScreen> {
  ResetMpinResponse? _resetMpinResponse;
  String? newMpinValue;
  String? confirmMpinValue;
  // String? finalMpin;
  String? mobileNum;
  String? resetMpin;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Center(
          child: Text(
            "SET MPIN",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.exit_to_app,
              color: Colors.black,
            ),
          ),
        ],
        //
      ),
      body: Container(
        width: MediaQuery.of(context).size.width * 1,
        height: MediaQuery.of(context).size.height * 1,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/bg.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Card(
              elevation: 15.0,
              margin:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 150.0),
              color: Colors.transparent,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.black87, width: 1),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: TextWidget(
                        text: "New Mpin",
                        left: 0,
                        right: 0,
                        top: 0,
                        bottom: 0,
                        fontsize: 20,
                        textcolor: Colors.white,
                      ),
                    ),
                    PinCodeFields(
                      length: 4,
                      fieldBorderStyle: FieldBorderStyle.square,
                      responsive: false,
                      fieldHeight: 50.0,
                      fieldWidth: 50.0,
                      borderWidth: 1.0,
                      activeBorderColor: Colors.black,
                      activeBackgroundColor: Colors.transparent,
                      borderRadius: BorderRadius.circular(10.0),
                      keyboardType: TextInputType.number,
                      autoHideKeyboard: false,
                      fieldBackgroundColor: Colors.black12,
                      borderColor: Colors.black38,
                      textStyle: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                      onComplete: (output) {
                        newMpinValue = output;
                        // Your logic with pin code
                        // print(output);
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: TextWidget(
                        text: "Confirm Mpin",
                        left: 0,
                        right: 0,
                        top: 0,
                        bottom: 0,
                        fontsize: 20,
                        textcolor: Colors.white,
                      ),
                    ),
                    PinCodeFields(
                      length: 4,
                      fieldBorderStyle: FieldBorderStyle.square,
                      responsive: false,
                      fieldHeight: 50.0,
                      fieldWidth: 50.0,
                      borderWidth: 1.0,
                      activeBorderColor: Colors.black,
                      activeBackgroundColor: Colors.transparent,
                      borderRadius: BorderRadius.circular(10.0),
                      keyboardType: TextInputType.number,
                      autoHideKeyboard: false,
                      fieldBackgroundColor: Colors.black12,
                      borderColor: Colors.black38,
                      textStyle: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                      onComplete: (output) {
                        confirmMpinValue = output;
                        // Your logic with pin code
                        // print(output);
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: SizedBox(
                        height: 40,
                        width: 100,
                        child: ElevatedButton(
                          onPressed: (() async {
                            if (newMpinValue?.length == 4 &&
                                confirmMpinValue?.length == 4) {
                              if (newMpinValue == confirmMpinValue) {
                                print("yes");

                                // finalMpin = confirmMpinValue;
                                // print("final mpin ${finalMpin}");
                                if (_resetMpinResponse?.status == true) {
                                  SharedPreferencesClass()
                                      .writeTheData("mpin", confirmMpinValue);
                                  // print("result is  ${finalMpin}");
                                  Navigator.pushNamed(context, AppRoutes.mpin);
                                }
                              } else {
                                print("no");
                              }
                            } else {
                              showAlert("please enter valid Mpin");
                            }
                          }),
                          style: ElevatedButton.styleFrom(
                            elevation: 7.0,
                            backgroundColor: Color.fromARGB(255, 179, 44, 89),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          child: const Text(
                            'Submit',
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
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
                //style: ButtonStyle(backgroundColor,
              )
            ],
          );
        }); //showDialog
  } //

  fetchDetails() async {
    final requestUrl =
        ApiConstants.reset_mpin_baseurl + ApiConstants.reset_mpin_endpoint;
    final _dioObject = Dio();
    final _response = await _dioObject.get(requestUrl,
        queryParameters: {"mpin": 1234, "MOBILE_NO": mobileNum});
    final data = ResetMpinResponse.fromJson(_response.data);
    print("reset mpin response ${_response.data}");
    setState(() {
      _resetMpinResponse = data;
    });
    print("reset mpin status ${_resetMpinResponse?.status}");
  }

  Future<dynamic> readSharedData() async {
    var mobileNumber =
        await SharedPreferencesClass().readTheData("mobileNumber");
   // var resetmpin = await SharedPreferencesClass().readTheData("mpin");
    setState(() {
      mobileNum = mobileNumber;
    });
    /* setState(() {
      resetMpin = resetmpin;
    });
    print("readig mpin after reset ${resetMpin}"); */
  }

  @override
  void initState() {
    super.initState();
    fetchDetails();
    readSharedData();
  }
}
