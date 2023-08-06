import 'package:flutter/material.dart';
import 'package:pgvala_saleperson/Onboarding/registerAccomodation.dart';
import 'package:pgvala_saleperson/Onboarding/registerRoom.dart';


class RegisterAnotherRoom extends StatefulWidget {
  const RegisterAnotherRoom({super.key});

  @override
  State<RegisterAnotherRoom> createState() => _RegisterAnotherRoomState();
}

class _RegisterAnotherRoomState extends State<RegisterAnotherRoom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: 300),
          child: Center(
            child: Column(
              children: [
                // ElevatedButton(
                //   onPressed: (){
                //     Navigator.push(context,MaterialPageRoute(builder: (context)=>registerRoom()));
                //   },
                //   child: Text('Register Another Room',
                //     style: TextStyle(
                //       fontSize: 14,
                //       fontWeight: FontWeight.bold,
                //     ),
                //   ),
                // ),
                // SizedBox(height: 25,),
                // ElevatedButton(
                //   onPressed: (){
                //     Navigator.push(context, MaterialPageRoute(builder: (context)=>landlordform()));
                //   },
                //   child: Text('Register Another Apartment',
                //     style: TextStyle(
                //       fontSize: 14,
                //       fontWeight: FontWeight.bold,
                //     ),
                //   ),
                // )
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> registerRoom()));
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
