class ArrivalModel {
  int? sN;
  String? date;
  String? firstName;
  String? lastName;
  String? status;
  String? arrivalTime;
  String? airline;
  int? flight;
  String? airport;
  String? origin;
  String? terminal;
  String? vehicleType;
  String? vIP;
  String? confS;
  String? driverInfo;
  String? driverNumber;
  String? dropLocation;
  int? careOf;

  ArrivalModel(
      {this.sN,
      this.date,
      this.firstName,
      this.lastName,
      this.status,
      this.arrivalTime,
      this.airline,
      this.flight,
      this.airport,
      this.origin,
      this.terminal,
      this.vehicleType,
      this.vIP,
      this.confS,
      this.driverInfo,
      this.driverNumber,
      this.dropLocation,
      this.careOf});

  ArrivalModel.fromJson(Map<String, dynamic> json) {
    sN = json['SN'];
    date = json['Date'];
    firstName = json['First Name'];
    lastName = json['Last Name'];
    status = json['Status'];
    arrivalTime = json['Arrival Time'];
    airline = json['Airline'];
    flight = json['Flight #'];
    airport = json['Airport'];
    origin = json['Origin'];
    terminal = json['Terminal'];
    vehicleType = json['Vehicle Type'];
    vIP = json['VIP'];
    confS = json['Conf #\'s'];
    driverInfo = json['Driver Info'];
    driverNumber = json['Driver number'];
    dropLocation = json['Drop Location'];
    careOf = json['Care of'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['SN'] = sN;
    data['Date'] = date;
    data['First Name'] = firstName;
    data['Last Name'] = lastName;
    data['Status'] = status;
    data['Arrival Time'] = arrivalTime;
    data['Airline'] = airline;
    data['Flight #'] = flight;
    data['Airport'] = airport;
    data['Origin'] = origin;
    data['Terminal'] = terminal;
    data['Vehicle Type'] = vehicleType;
    data['VIP'] = vIP;
    data['Conf #\'s'] = confS;
    data['Driver Info'] = driverInfo;
    data['Driver number'] = driverNumber;
    data['Drop Location'] = dropLocation;
    data['Care of'] = careOf;
    return data;
  }
}
