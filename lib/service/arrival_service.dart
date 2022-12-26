import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class ArrivalService {
  Future loadArrival() async {
    var response = await rootBundle.loadString('assets/arrivals.json');
    var data = jsonDecode(response);
    return data;
  }

  Future getFlights() async {
    var response = await http.get(Uri.parse(
        'https://airlabs.co/api/v9/flights?api_key=cadf756d-67c1-4414-94ea-0280f2d9652c'));

    var data = jsonDecode(response.body);

    return data;
  }

  Future getFlightStatus() async {
    var response = await http.get(Uri.parse(
        'https://airlabs.co/api/v9/flights?_view=array&_fields=flight_number,status&api_key=cadf756d-67c1-4414-94ea-0280f2d9652c'));

    var data = jsonDecode(response.body);

    return data;
  }

  Future getFlightDelays(String flight_no) async {
    var response = await http.get(Uri.parse(
        'http://api.aviationstack.com/v1/flights?access_key=dd35db8c99a243b2fab21acf9224f0aa&flight_number=$flight_no&limit=1'));

    var data = jsonDecode(response.body);

    return data;
  }

  Future getFlightDetails(String flight_icao) async {
    var response = await http.get(Uri.parse(
        'https://airlabs.co/api/v9/flight?flight_icao=$flight_icao&api_key=cadf756d-67c1-4414-94ea-0280f2d9652c'));

    var data = jsonDecode(response.body);

    return data;
  }
}
