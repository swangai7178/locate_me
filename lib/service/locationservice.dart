  import 'dart:convert';
  import 'dart:io';

  import 'package:http/http.dart' as http;
  import 'package:locate_me/models/currentlocationsmodel.dart';
class CustomerService{
  static Future<List<CurrentLocation>> fetchLocation() async {
  var client = http.Client();

  List<CurrentLocation> locations = [];

  try {
    var apiUrl = "https://jsonkeeper.com/b/M8DQ";

    http.Response response = await client.get(Uri.parse(apiUrl), headers: {
      "Content-Type":"application/json"
       
    });

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      var dataCurrent = LocationEntry.fromJson(data);
      locations = dataCurrent.currentLocation;
    } else {
      print("Failed to load data: ${response.statusCode}");
    }
  } catch (e) {
    print("Error during API call: $e");
  } finally {
    client.close();
  }

  return locations;
}
}