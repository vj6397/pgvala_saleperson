
import 'dart:convert';
import 'package:http/http.dart' as http;

class RequestUtil{
  final endpoint='https://davaivala.shop/';
  final token='Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJleHAiOjE3MjIxNjM4NDAsImlhdCI6MTY5MDYyNzg0MCwic2NvcGUiOiJhY2Nlc3NfdG9rZW4iLCJzdWIiOiJhY2MwNiJ9.D9wDOUSPuy0RX_QOH0Zhx8QiSZ1GLo3jfoaHvRj39tE';



  Future<http.Response> cityList() async{
    return  http.get(Uri.parse(endpoint+'get_city_list/'),
      headers: {'Authorization': token},
    );
  }

  Future<http.Response> sales_logIn(sales_id,password)async{
    return http.post(Uri.parse(endpoint+'sales_login/?sales_id=$sales_id&password=$password'),
        headers: {'Authorization': token},
    );
  }

  Future<http.Response> register_Accomodation(Apartmentname,Ownername,contact1,contact2,address,email,total_accomodation,state,city,locality,tenant)async{
    return http.post(Uri.parse(endpoint+'register_accommodation/'),
      headers: {
        "accept": "application/json",
        "Authorization": token,
        "Content-Type": "application/json"},
      body:jsonEncode (
          {
            "apartment_name": Apartmentname,
            "owner_name": Ownername,
            "state": state,
            "city": city,
            "locality": locality,
            "address": address,
            "contact1": contact1,
            "contact2": contact2,
            "email": email,
            "latitude": 0,
            "longitude": 0,
            "total_accomation": total_accomodation,
            "tc": "string",
            "tenant": tenant,
            "qrid": "string"
          }
      )
    );
  }

  Future<http.Response> get_roomId(accid) async{
    return  http.get(Uri.parse(endpoint+'get_roomid/?accid=$accid'),
      headers: {'Authorization': token},
    );
  }
  Future<http.Response> register_room(accid,roomid,wash_status,status,accomotation_type,rent_price,category,rate,tenant,security_deposit)async{
    return http.post(Uri.parse(endpoint+'register_accommodation/'),
        headers: {"accept": "application/json",
          "Authorization": token,
          "Content-Type": "application/json"},
        body:jsonEncode ({
            "accid": accid,
            "roomid": roomid,
            "washroom_status": wash_status,
            "status": status,
            "perks": 'perks',
            "accomotation_type": accomotation_type,
            "rent_price": rent_price,
            "category": category,
            "rate": rate,
            "tenant": tenant,
            "security_deposit": security_deposit
        })
    );
  }
}