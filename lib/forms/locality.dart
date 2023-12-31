import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pgvala_saleperson/Api/request_util.dart';
import 'package:pgvala_saleperson/Onboarding/registerRoom.dart';
import 'package:pgvala_saleperson/forms/city.dart';
import 'package:pgvala_saleperson/utils/location_list.dart';
import 'package:http/http.dart'as http;


class Locality extends StatefulWidget {

  Locality({required this.Apartmentname,required this.Ownername,required this.contact1,required this.contact2,required this.address,required this.email,required this.total_accomodation,required this.state,required this.city,required this.tenant,required this.qrid});

  String Apartmentname ;
  String Ownername ;
  String contact1;
  String contact2;
  String address;
  String email;
  String total_accomodation;
  String tenant;
  String state;
  String city;
  String qrid;

  @override
  State<Locality> createState() => _LocalityState();
}

class _LocalityState extends State<Locality> {
  String accid='';
  String roomid='';
  List<String> locality_list=[];
  String? dropdownvalue;
  RequestUtil util  = new RequestUtil();
  List<dynamic> jsonData=[];
  //late  Map<String, dynamic> data;
  Future<void> _getData() async{
    http.Response response = await util.localityList(widget.city);
    if(response.statusCode==200) {
      print(response.body);
      // addList();
      jsonData= jsonDecode(response.body);
      var i=0;
      while(i<jsonData.length){
        setState(() {
          locality_list.add(jsonData[i]["locality"]);
        });
        i++;
      }
      print(jsonData);
      print(jsonData[0]["locality"]);
      // print(jsonData["apartment_name"]);
    }
    else print("error");
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body:Stack(
            children: [
              Positioned(
                top: 10,
                left: 15,
                child: IconButton(
                  icon: Icon(Icons.arrow_back_rounded),
                  onPressed: (){
                    Navigator.pop(context);
                  },
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      margin: EdgeInsets.only(left: 1),
                      child: Text(
                        'Select Locality',
                        style: GoogleFonts.notoSans(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width-70,
                    margin: EdgeInsets.only(left: 5, right: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: dropdownvalue,
                        icon: Icon(Icons.keyboard_arrow_down),
                        isExpanded: true,
                        menuMaxHeight: 200,
                        items: locality_list.map<DropdownMenuItem<String>>((e) {
                          return DropdownMenuItem<String>(
                            value: e,
                            child: Padding( // Add padding to the DropdownMenuItem to match the style
                              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                              child: Text(
                                e.toString(),
                                style: GoogleFonts.notoSans(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownvalue = newValue!;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () async{
                      if(dropdownvalue!=null){
                        http.Response res_accid= await util.register_Accomodation(widget.Apartmentname, widget.Ownername, widget.contact1, widget.contact2, widget.address, widget.email, widget.total_accomodation, widget.state, widget.city, dropdownvalue, widget.tenant,widget.qrid);
                        if(res_accid.statusCode==200){
                          print(res_accid.body);
                          final Map<String, dynamic> data = jsonDecode(res_accid.body);
                          var listAccId = data["accommodation_id"];
                          var l = data["accommodation_id"].length;
                          print(listAccId[l-1]['entery_id']);
                          print(listAccId[l-1]['accid']);
                          accid=listAccId[l-1]['accid'];
                          // print(data["accid"]);
                        }
                        else print(res_accid.body);
                        http.Response res_roomid= await util.get_roomId(accid);
                        if(res_roomid.statusCode==200){
                          print(res_roomid.body);
                          final Map<String, dynamic> room = jsonDecode(res_roomid.body);
                          var listroom = room['status'];
                          print(listroom);
                          roomid=listroom;
                        }
                        else print(res_roomid.body);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => registerRoom(accid: accid, roomid: roomid)),
                        );
                      }
                      else{
                        Fluttertoast.showToast(
                            msg: "Select locality",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.grey,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                      }

                    },
                    child: Container(
                      height: 38,
                      width: 114,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Text(
                          'Register',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )
      ),
    );
  }
}