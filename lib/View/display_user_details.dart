import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ghmc_officer/Model/shared_model.dart';
import 'package:ghmc_officer/Model/user_details_response.dart';
import 'package:ghmc_officer/Model/user_list_response.dart';
import 'package:ghmc_officer/Res/components/background_image.dart';
import 'package:ghmc_officer/Res/components/service_text.dart';
import 'package:ghmc_officer/Res/components/sharedpreference.dart';
import 'package:ghmc_officer/Res/constants/ApiConstants/api_constants.dart';
import 'package:ghmc_officer/View/full_grievance_details.dart';

class UserDetails extends StatefulWidget {
  const UserDetails({super.key});

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  UserDetailsResponse? userDetailsResponse;
  GrievanceUserList? grievanceUserList;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            "Display User Details",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: Stack(
          children: <Widget>[
            BgImage(imgPath: 'bg.png'),
            Column(
              children: [
                Expanded(
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ServiceTextLabel(text: "Name"),
                                  ServiceTextLabel(text: "Designation"),
                                  ServiceTextLabel(text: "Employee Level"),
                                  ServiceTextLabel(text: "Wing"),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 2.0, vertical: 15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ServiceText(
                                    text: "${userDetailsResponse?.empName}",
                                  ),
                                  ServiceText(
                                    text: "${userDetailsResponse?.designation}",
                                  ),
                                  ServiceText(
                                    text: "${userDetailsResponse?.emplevel}",
                                  ),
                                  ServiceText(
                                    text: "${userDetailsResponse?.wing}",
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Card(
                          child: Container(
                            width: MediaQuery.of(context).size.width * 1,
                            height: MediaQuery.of(context).size.height * 0.07,
                            child: Center(
                              child: Text(
                                "Grievance Details as on Date",
                                style: TextStyle(fontSize: 20.0),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                              itemCount:
                                  userDetailsResponse?.dashboard?.length ?? 0,
                              itemBuilder: (context, index) {
                                final details =
                                    userDetailsResponse?.dashboard?[index];
                                return GestureDetector(
                                  onTap: () {
                                    SharedPreferencesClass().writeTheData(
                                        PreferenceConstants.fulldetails, details?.typeId);
                                        //print(details?.typeId);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              FullGrievanceDetails(),
                                        ));
                                  },
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: Colors.black87, width: 1),
                                    ),
                                    color: Colors.transparent,
                                    child: ListTile(
                                      title: Text(
                                        "${details?.typeName}",
                             
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      trailing: Text(
                                        "${details?.gcount}",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }

  @override
  void initState() {
  
    super.initState();

    GrievanceUserDetails();
  }

  void GrievanceUserDetails() async {
    var id = await SharedPreferencesClass()
        .readTheData(PreferenceConstants.userdetails);
        //print(id);
    //creating request url with base url and endpoint
    const requesturl =
        ApiConstants.userdetails_baseurl + ApiConstants.userdetails_endpoint;

    //creating payload because request type is POST
    var requestPayload = {
      "userid": "cgg@ghmc",
      "password": "ghmc@cgg@2018",
      "uid": "978",
      "mode": id,
      "type_id": "1",
      "slftype": "1"
    };

    //no headers and authorization

    //creating dio object in order to connect package to server
    final dioObject = Dio();

    try {
      final response = await dioObject.post(
        requesturl,
        data: requestPayload,
      );

      //converting response from String to json
      final data = UserDetailsResponse.fromJson(response.data);
      //print(response.data);
      setState(() {
        if (data.status == "true") {
          if (data.dashboard != null && data.dashboard!.length > 0) {
            userDetailsResponse = data;
          }
        }
      });
    } on DioError catch (e) {
      if (e.response?.statusCode == 400 || e.response?.statusCode == 500) {
        //final errorMessage = e.response?.data["message"];
        // showAlert(errorMessage);
      }
      print("error is $e");

      //print("status code is ${e.response?.statusCode}");
    }
// step 5: print the response
  }
}
