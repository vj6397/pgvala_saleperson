import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pgvala_saleperson/Api/request_util.dart';
import 'package:pgvala_saleperson/Onboarding/registerAccomodation.dart';
import 'package:pgvala_saleperson/Onboarding/registerRoom.dart';
import 'package:http/http.dart' as http;

class RegisterAnotherRoom extends StatefulWidget {
  RegisterAnotherRoom({required this.accid});
  String accid;

  @override
  State<RegisterAnotherRoom> createState() => _RegisterAnotherRoomState();
}

class _RegisterAnotherRoomState extends State<RegisterAnotherRoom> {
  RequestUtil util=new RequestUtil();
  String roomid='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: 300),
          child: Center(
            child: Column(
              children: [
                InkWell(
                  onTap: ()async{
                    http.Response res_roomid= await util.get_roomId(widget.accid);
                    if(res_roomid.statusCode==200){
                      print(res_roomid.body);
                      final Map<String, dynamic> room = jsonDecode(res_roomid.body);
                      var listroom = room['status'];
                      print(listroom);
                      roomid=listroom;
                    }
                    else print(res_roomid.body);
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> registerRoom(accid: widget.accid,roomid: roomid)));
                  },
                  child: Container(
                    height: 45,width: 194,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      //border:Border.all(width: 1,color: Colors.green),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Text('Register Another Room',
                        style: TextStyle(
                            color: Colors.white
                        ),),
                    ),
                  ),
                ),
                SizedBox(height: 25,),
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> landlordform()));
                  },
                  child: Container(
                    height: 45,width: 194,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      //border:Border.all(width: 1,color: Colors.green),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Text('Register Another Apartment',
                        style: TextStyle(
                            color: Colors.white
                        ),),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
