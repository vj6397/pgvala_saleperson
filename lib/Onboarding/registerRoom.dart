import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pgvala_saleperson/Api/request_util.dart';
import 'package:pgvala_saleperson/Onboarding/registerAccomodation.dart';
import 'package:pgvala_saleperson/Onboarding/registerAnotherRoom.dart';
import 'package:pgvala_saleperson/utils/location_list.dart';
import 'package:http/http.dart' as http;

class registerRoom extends StatefulWidget {
  registerRoom({required this.accid,required this.roomid});
  String accid;
  String roomid;
  @override
  State<registerRoom> createState() => _registerRoomState();
}

class _registerRoomState extends State<registerRoom> {
  String accid = "";
  String roomid = "";
  String perks="";
  String rent_price = "";
  String security_price="";
  String tenant="";
  bool isChecked = false;
  List radioOptionwashroomStatus=['Attached','Common'];
  String? selectedOptionwashroomStatus;
  List radioOptionAvailabitystatus=['Booked','Available'];
  String? selectedAvailabitystatus;
  List radioOptionfurnish=['Un Furnished','Semi Furnished','Fully Furnished'];
  String? selectedOptionfurnish;
  List radioOptiontenent=['Girls','Boys','Family'];
  String? selectedOptiontenant;
  var roomsharing_list = rooomsharing;
  String dropdownvalueRoomSharing = rooomsharing.first;
  var rate_list=rate;
  String dropdownvalueRate=rate.first;
  RequestUtil util=new RequestUtil();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(onPressed: (){Navigator.push(context,MaterialPageRoute(builder: (context)=>landlordform()));}, icon: Icon(Icons.arrow_back_rounded)),
                    SizedBox(height: 15,),
                    Container(
                      margin: EdgeInsets.only(left: 15,bottom: 10),
                      child: Text(
                        'Accid',
                        style: GoogleFonts.notoSans(
                            fontWeight: FontWeight.w600, fontSize: 12),
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      margin: EdgeInsets.only(left: 15, right: 15),
                      child: TextField(
                        enabled: false,
                        keyboardType: TextInputType.text,
                        onChanged: (val) {
                          accid = val;
                        },
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 15.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide(
                                color: Colors
                                    .black, // Set the desired border width here
                              ),
                            ),
                            hintText: widget.accid),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      margin: EdgeInsets.only(left: 15),
                      child: Text(
                        'RoomId',
                        style: GoogleFonts.notoSans(
                            fontWeight: FontWeight.w600, fontSize: 12),
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      margin: EdgeInsets.only(left: 15, right: 15),
                      child: TextField(
                        enabled: false,
                        keyboardType: TextInputType.text,
                        onChanged: (val) {
                          roomid = val;
                        },
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 15.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide(
                                color: Colors
                                    .black, // Set the desired border width here
                              ),
                            ),
                            hintText: widget.roomid),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 13.0),
                              child: Text('Washroom Status ',
                                style: GoogleFonts.notoSans(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            for(String option in radioOptionwashroomStatus)
                              RadioListTile(
                                title: Text(option),
                                value: option,
                                groupValue: selectedOptionwashroomStatus,
                                onChanged: (val){
                                  setState(() {
                                    selectedOptionwashroomStatus=val;
                                  });
                                },
                              ),
                          ],
                        )
                    ),
                    SizedBox(height: 20),
                    //radiobutton for availability status
                    Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 13.0),
                              child: Text('Status',
                                style: GoogleFonts.notoSans(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            for(String option in radioOptionAvailabitystatus)
                              RadioListTile(
                                title: Text(option),
                                value: option,
                                groupValue: selectedAvailabitystatus,
                                onChanged: (val){
                                  setState(() {
                                    selectedAvailabitystatus=val;
                                  });
                                },
                              ),
                          ],
                        )
                    ),
                    //perks
                    SizedBox(height: 20),
                    //radiobutton accomodation_type
                    Container(
                      margin: EdgeInsets.only(left: 15),
                      child: Text(
                        'Accomodation Type',
                        style: GoogleFonts.notoSans(
                            fontWeight: FontWeight.w600, fontSize: 12),
                      ),
                    ),
                    SizedBox(height: 5,),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.only(left: 5, right: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: dropdownvalueRoomSharing,
                            icon: Icon(Icons.keyboard_arrow_down),
                            isExpanded: true,
                            menuMaxHeight: 200,
                            items: roomsharing_list.map<DropdownMenuItem<String>>((e) {
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
                                dropdownvalueRoomSharing = newValue!;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      margin: EdgeInsets.only(left: 15),
                      child: Text(
                        'Rent Price details',
                        style: GoogleFonts.notoSans(
                            fontWeight: FontWeight.w600, fontSize: 12),
                      ),
                    ),
                    SizedBox(height: 5,),
                    Container(
                      margin: EdgeInsets.only(left: 15, right: 15),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        onChanged: (val) {
                          rent_price = val;
                        },
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 15.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide(
                                color: Colors
                                    .black, // Set the desired border width here
                              ),
                            ),
                            hintText: 'Enter Rent Price'),
                      ),
                    ),
                    SizedBox(height: 20),
                    //Radiobutton for category Furnished
                    Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 13.0),
                              child: Text('Furnish Status',
                                style: GoogleFonts.notoSans(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            for(String option in radioOptionfurnish)
                              RadioListTile(
                                title: Text(option),
                                value: option,
                                groupValue: selectedOptionfurnish,
                                onChanged: (val){
                                  setState(() {
                                    selectedOptionfurnish=val;
                                  });
                                },
                              ),
                          ],
                        )
                    ),
                    SizedBox(height: 20,),
                    Container(
                      margin: EdgeInsets.only(left: 15),
                      child: Text(
                        'Rate Type',
                        style: GoogleFonts.notoSans(
                            fontWeight: FontWeight.w600, fontSize: 12),
                      ),
                    ),
                    SizedBox(height: 5,),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.only(left: 5, right: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: dropdownvalueRate,
                            icon: Icon(Icons.keyboard_arrow_down),
                            isExpanded: true,
                            menuMaxHeight: 200,
                            items: rate_list.map<DropdownMenuItem<String>>((e) {
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
                                dropdownvalueRate = newValue!;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    //Radiobutton for tenant type
                    SizedBox(height: 20,),
                    Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 13.0),
                              child: Text('Tenant Type',
                                style: GoogleFonts.notoSans(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            for(String option in radioOptiontenent)
                              RadioListTile(
                                title: Text(option),
                                value: option,
                                groupValue: selectedOptiontenant,
                                onChanged: (val){
                                  setState(() {
                                    selectedOptiontenant=val;
                                  });
                                },
                              ),
                          ],
                        )
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 15),
                      child: Text(
                        'Security deposit',
                        style: GoogleFonts.notoSans(
                            fontWeight: FontWeight.w600, fontSize: 12),
                      ),
                    ),
                    SizedBox(height: 5,),
                    Container(
                      margin: EdgeInsets.only(left: 15, right: 15),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        onChanged: (val) {
                          security_price = val;
                          print(security_price);
                        },
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 15.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide(
                                color: Colors
                                    .black, // Set the desired border width here
                              ),
                            ),
                            hintText: 'Enter Security Deposit'),
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      margin: EdgeInsets.only(left: 15),
                      child: Text(
                        'Perks',
                        style: GoogleFonts.notoSans(
                            fontWeight: FontWeight.w600, fontSize: 12),
                      ),
                    ),
                    SizedBox(height: 5,),
                    Container(
                      margin: EdgeInsets.only(left: 15, right: 15),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        onChanged: (val) {
                          perks = val;
                          print(perks);
                        },
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 15.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide: BorderSide(
                                color: Colors
                                    .black, // Set the desired border width here
                              ),
                            ),
                            hintText: 'Specify Perks by using ,'),
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      margin: EdgeInsets.only(top: 20,left: 15,right: 15,bottom: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: ()async{
                              http.Response res= await util.register_room(widget.accid,widget.roomid,
                                  selectedOptionwashroomStatus,selectedAvailabitystatus,dropdownvalueRoomSharing,
                                  rent_price,selectedOptionfurnish,dropdownvalueRate,tenant,security_price,perks);
                              print(perks);
                              if(res.statusCode==200){
                                print(res.body);
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> RegisterAnotherRoom(accid: widget.accid)));
                              }
                              else {
                                print(res.body);
                                Fluttertoast.showToast(
                                    msg: "Enter all details",
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
                              height: 38,width: 114,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                //border:Border.all(width: 1,color: Colors.green),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Center(
                                child: Text('Register',
                                  style: TextStyle(
                                      color: Colors.white
                                  ),),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}