import 'package:flight_status/common/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

buildDialog({status, estimated, delayed, airport, iata, icao}) {
  Get.defaultDialog(
      title: 'Arrival Details',
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            _buildRow('Status :', status),
            const SizedBox(
              height: 5,
            ),
            _buildRow('Estimated :', estimated),
            const SizedBox(
              height: 5,
            ),
            _buildRow('Delayed :', delayed),
            const SizedBox(
              height: 5,
            ),
            _buildRow('Airport :', airport),
            const SizedBox(
              height: 5,
            ),
            _buildRow('iata :', iata),
            const SizedBox(
              height: 5,
            ),
            _buildRow('icao :', icao),
          ],
        ),
      ));
}

_buildRow(ltxt, rtxt) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        ltxt,
        style: subtitleStyle.copyWith(fontWeight: FontWeight.bold),
      ),
      FittedBox(
        child: SizedBox(
          width: 100,
          child: Text(
            rtxt,
            style: subtitleStyle,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    ],
  );
}

buildLoadingDialog() {
  Get.defaultDialog(
      title: 'Loading...',
      content: const Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: CircularProgressIndicator()));
}
