import 'dart:async';

import 'package:flight_status/model/arrival_model.dart';
import 'package:flight_status/model/flights_model.dart';
import 'package:flight_status/service/arrival_service.dart';
import 'package:flight_status/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class HomeController extends GetxController {
  var arrivalList = <ArrivalModel>[].obs;
  var flightList = <FlightModel>[].obs;

  var filtered = <ArrivalModel>[].obs;

  var flightData = [];

  ScrollController scrollcontroller = ScrollController();
  @override
  void onInit() {
    getArrival();
    getFlightstatus();
    getFlights();
    // Timer.periodic(
    //   const Duration(seconds: 20),
    //   (timer) {
    //     getFlights();
    //   },
    // );
    // scrollcontroller
    //   ..addListener(() {
    //     print(scrollcontroller.position.pixels.toString());
    //   });
    super.onInit();
  }

  fetchall() {
    getArrival();
    getFlights();
  }

  final channel = WebSocketChannel.connect(
    Uri.parse(
        'wss://airlabs.co/api/v9/flights?api_key=cadf756d-67c1-4414-94ea-0280f2d9652c'),
  );
  Stream<List<FlightModel>> flightStream() async* {
    while (true) {
      await Future.delayed(const Duration(milliseconds: 500));
      var res = await ArrivalService().getFlights();
      var data = res['response'];
      res['response'].forEach((v) => flightList.add(FlightModel.fromJson(v)));
      yield flightList;
    }
  }

  var arrivalloading = false.obs;

  getArrival() async {
    arrivalloading(true);
    var data = await ArrivalService().loadArrival();

    if (data != null) {
      arrivalloading(false);

      arrivalList.clear();
      data.forEach((v) => arrivalList.add(ArrivalModel.fromJson(v)));
    }
  }

  var loading = false.obs;

  getFlights() async {
    loading(true);
    var data = await ArrivalService().getFlights();
    print("flights" + data.toString());
    if (data != null) {
      loading(false);

      flightList.clear();
      data['response'].forEach((v) => flightList.add(FlightModel.fromJson(v)));
      flightData = data['response'];
      // getSnackbar(message: 'data received');
      // if( data['response'].keys. )
    }
  }

  var flightStatus = [].obs;
  getFlightstatus() async {
    var data = await ArrivalService().getFlightStatus();
    print("Flights status" + data.length.toString());
    if (data != null) {
      flightStatus.clear();
      flightStatus.value = data;
      // for (var i = 0; i <= data.length; i++) {}
    }
  }

  var flighDelay;
  var flightdelayLoading = false.obs;
  getFlightDelay(flightno) async {
    // flightdelayLoading(true);
    buildLoadingDialog();
    var data = await ArrivalService().getFlightDelays(flightno);
    print("Flights delay " + data['data'].toString());

    if (data != null) {
      Get.back();
      flightdelayLoading(false);

      flighDelay = data['data'];
    }
  }

  var flightDetails;
  getFlightDetails(flightIaco) async {
    // flightdelayLoading(true);
    buildLoadingDialog();
    var data = await ArrivalService().getFlightDetails(flightIaco);
    print("Flights details " + data['response'].toString());

    if (data != null) {
      Get.back();
      flightDetails = data['response'];
      // flightdelayLoading(false);

      // flighDelay = data['data'];
    }
  }

  Stream flightDelayStream(flightno) async* {
    while (true) {
      await Future.delayed(const Duration(seconds: 5));
      var res = await ArrivalService().getFlightDelays(flightno);
      var data = res['data'][0]['arrival'];
      yield data;
    }
  }

  buildtext(String fligthNo) {
    String status = 'no data';
    for (var i = 0; i < flightList.length; i++) {
      if (flightList[i].flightNumber.toString() == fligthNo) {
        status = flightList[i].status.toString();
      }
    }

    return status;
  }
}
