import 'package:flight_status/common/constant.dart';
import 'package:flight_status/controller/home_controller.dart';
import 'package:flight_status/model/flights_model.dart';
import 'package:flight_status/widgets/custom_dialog.dart';
import 'package:flight_status/widgets/get_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);

  final controller = Get.put(HomeController());
  final DateFormat formatter = DateFormat('yyyy-MM-dd hh:mm');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.purple.shade800,
          title: Text(
            'Arrivals',
            style: headingStyle.copyWith(color: Colors.white),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await Future.delayed(const Duration(seconds: 3));
            controller.fetchall();
          },
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            controller: controller.scrollcontroller,
            child: Column(
              children: [
                // StreamBuilder(
                //   stream: controller.flightStream(),
                //   builder: (context, AsyncSnapshot data) {
                //     if (data.connectionState == ConnectionState.waiting) {
                //       return CircularProgressIndicator();
                //     }
                //     if (data.connectionState == ConnectionState.active) {
                //       return Text(data.data.length.toString());
                //       // _buildListView(data: data.data);
                //     }
                //     return Text(data.connectionState.toString());
                //   },
                // ),

                Obx(() => controller.loading.isTrue
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.arrivalList.length,
                        controller: controller.scrollcontroller,
                        scrollDirection: Axis.vertical,
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.all(10),
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 5,
                                      color: Colors.grey.shade400,
                                      offset: const Offset(2, 2)),
                                ]),
                            child: ListTile(
                              title: Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Text(
                                    '${controller.arrivalList[index].firstName} ${controller.arrivalList[index].lastName}'),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Flight no. ${controller.arrivalList[index].flight}",
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                      "${controller.arrivalList[index].arrivalTime} ${controller.arrivalList[index].date}"),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(controller.arrivalList[index].airline
                                      .toString())
                                ],
                              ),
                              trailing:

                                  // StreamBuilder(
                                  //   stream: controller.flightStream(),
                                  //   builder: (context, AsyncSnapshot data) {
                                  //     if (data.connectionState ==
                                  //         ConnectionState.waiting) {
                                  //       return const CircularProgressIndicator();
                                  //     }
                                  //     if (data.connectionState ==
                                  //         ConnectionState.active) {
                                  //       if (data.hasData) {
                                  //         return Text('data');
                                  //       } else {
                                  //         return Text('no data');
                                  //       }
                                  //       // _buildListView(data: data.data);
                                  //     }
                                  //     return Text(data.connectionState.toString());
                                  //   },
                                  // ),

                                  Obx(() =>
                                      // controller.loading.value?
                                      // CircularProgressIndicator():
                                      GestureDetector(
                                        onTap: () async {
                                          var list = [];
                                          for (var i = 0;
                                              i < controller.flightList.length;
                                              i++) {
                                            if (controller
                                                    .flightList[i].flightNumber
                                                    .toString() ==
                                                controller
                                                    .arrivalList[index].flight
                                                    .toString()) {
                                              list.clear();
                                              list.add(controller
                                                  .flightList[i].flightIcao
                                                  .toString());
                                            }
                                          }
                                          // print(list[0].toString());
                                          // controller
                                          //     .getFlightDetails(list[0].toString());

                                          if (list.isNotEmpty) {
                                            await controller.getFlightDetails(
                                                list[0] ?? '');
                                            buildDialog(
                                                airport: controller
                                                    .flightDetails['arr_name']
                                                    .toString(),
                                                delayed: controller
                                                    .flightDetails['delayed']
                                                    .toString(),
                                                estimated:
                                                    controller
                                                        .flightDetails[
                                                            'arr_estimated_utc']
                                                        .toString(),
                                                iata: controller.flightDetails[
                                                        'airline_iata']
                                                    .toString(),
                                                icao: controller.flightDetails[
                                                        'flight_icao']
                                                    .toString(),
                                                status: controller
                                                    .flightDetails['status']
                                                    .toString());
                                          } else {
                                            getSnackbar(
                                                bgColor: Colors.red,
                                                message: 'No data');
                                          }
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: controller.buildtext(
                                                        controller
                                                            .arrivalList[index]
                                                            .flight
                                                            .toString()) ==
                                                    'en-route'
                                                ? Colors.green
                                                : controller.buildtext(
                                                            controller
                                                                .arrivalList[
                                                                    index]
                                                                .flight
                                                                .toString()) ==
                                                        'landed'
                                                    ? Colors.blue
                                                    : Colors.red,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Text(
                                            controller.buildtext(controller
                                                .arrivalList[index].flight
                                                .toString()),
                                            style: subtitleStyle.copyWith(
                                                fontWeight: FontWeight.w400,
                                                color: Colors.white),
                                          ),
                                        ),
                                      )),
                              onTap: () async {
                                // String flight_data;
                                // for (var i = 0;
                                //     i < controller.flightList.length;
                                //     i++) {
                                //   if (controller.flightList[i].flightNumber
                                //           .toString() ==
                                //       controller.arrivalList[index].flight
                                //           .toString()) {
                                //     flight_data = controller.flightList[i].status
                                //         .toString();
                                //     print(flight_data);
                                //   } else {
                                //     print('no data');
                                //   }
                                // }
                                await controller.getFlightDelay(controller
                                    .arrivalList[index].flight
                                    .toString());
                                controller.flightdelayLoading.value
                                    ? buildLoadingDialog()
                                    : buildDialog(
                                        delayed:
                                            '${controller.flighDelay[0]['arrival']['delay'] ?? 0} minute',
                                        estimated: formatter.format(DateTime.parse(
                                            controller.flighDelay[0]['arrival']
                                                    ['estimated']
                                                .toString())),
                                        status: controller.buildtext(controller
                                            .arrivalList[index].flight
                                            .toString()),
                                        airport: controller.flighDelay[0]
                                                ['arrival']['airport']
                                            .toString(),
                                        iata: controller.flighDelay[0]
                                                ['arrival']['iata']
                                            .toString(),
                                        icao: controller.flighDelay[0]['arrival']['icao'].toString());
                              },
                            ),
                          );
                        },
                      ))
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            controller.scrollcontroller.animateTo(0,
                duration: const Duration(seconds: 1), curve: Curves.decelerate);
          },
          backgroundColor: Colors.purple,
          child: const Icon(Icons.arrow_upward_outlined),
        ));
  }

  buildtext(String fligthNo) {
    String status = 'no data';
    for (var i = 0; i < controller.flightList.length; i++) {
      if (controller.flightList[i].flightNumber.toString() == fligthNo) {
        status = controller.flightList[i].status.toString();
      }
    }

    return status;
  }

  _buildListView({required List<FlightModel> data}) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: data.length,
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.symmetric(vertical: 10),
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    blurRadius: 5,
                    color: Colors.grey.shade400,
                    offset: const Offset(0, 2))
              ]),
          child: ListTile(
            title: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                  '${controller.arrivalList[index].firstName} ${controller.arrivalList[index].lastName}'),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Flight no. ${controller.arrivalList[index].flight}",
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                    "${controller.arrivalList[index].arrivalTime} ${controller.arrivalList[index].date}"),
                const SizedBox(
                  height: 5,
                ),
                Text(controller.arrivalList[index].airline.toString())
              ],
            ),
            trailing: Obx(() => Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: controller.buildtext(controller
                                .arrivalList[index].flight
                                .toString()) ==
                            'en-route'
                        ? Colors.green
                        : controller.buildtext(controller
                                    .arrivalList[index].flight
                                    .toString()) ==
                                'landed'
                            ? Colors.blue
                            : Colors.red,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    controller.buildtext(
                        controller.arrivalList[index].flight.toString()),
                    style: subtitleStyle.copyWith(
                        fontWeight: FontWeight.w400, color: Colors.white),
                  ),
                )),
          ),
        );
      },
    );
  }
}
