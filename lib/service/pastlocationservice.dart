import 'dart:convert';


import 'package:http/http.dart' as http;

import 'package:locate_me/models/pastlocation.dart';
class PastLocationService{
  static Future<List<Pastlocations>> fetchLocation() async {
  var client = http.Client();

  List<Pastlocations> locations = [];

  try {
    var apiUrl = "https://jsonkeeper.com/b/YVWY";

    http.Response response = await client.get(Uri.parse(apiUrl), headers: {
      "Content-Type":"application/json"
       
    });

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      var dataCurrent = PastLocation.fromJson(data);
      locations = dataCurrent.pastlocations;
    } else {
     
    }
  } catch (e) {
    
  } finally {
    client.close();
  }

  return locations;
}
}