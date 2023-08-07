import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pgvala_saleperson/forms/locality.dart';
import 'package:pgvala_saleperson/forms/state.dart';
import 'package:pgvala_saleperson/Api/request_util.dart';
import 'package:pgvala_saleperson/utils/location_list.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class CityLocation extends StatefulWidget {

  CityLocation({required this.Apartmentname,required this.Ownername,required this.contact1,required this.contact2,required this.address,required this.email,required this.total_accomodation,required this.state,required this.tenant});

  String Apartmentname ;
  String Ownername ;
  String contact1;
  String contact2;
  String address;
  String email;
  String total_accomodation;
  String tenant;
  String state;

  @override
  State<CityLocation> createState() => _CityLocationState();
}

class _CityLocationState extends State<CityLocation> {
  var city_list = cities;
  String dropdownvalue = cities.first;
  RequestUtil util  = new RequestUtil();
  List<dynamic> jsonData=[];

  Future<void> _getData() async{
    http.Response response = await util.cityList();
      if(response.statusCode==200) {
        print(response.body);
        // addList();
        jsonData= jsonDecode(response.body);
        var i=0;
        while(i<jsonData.length){
          setState(() {
            cities.add(jsonData[i]["city_name"]);
          });
        }
        print(jsonData);
        print(jsonData[0]["city_name"]);
        // print(jsonData["apartment_name"]);
      }
      else print("error");
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _getData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
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
                      'City',
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
                      menuMaxHeight: 150,
                      items: city_list.map<DropdownMenuItem<String>>((e) {
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
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Locality(Apartmentname: widget.Apartmentname, Ownername: widget.Ownername, contact1: widget.contact1, contact2: widget.contact2, address: widget.address, email: widget.email, total_accomodation: widget.total_accomodation, state: widget.state, city: dropdownvalue, tenant: widget.tenant)));
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
                        'Continue',
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
