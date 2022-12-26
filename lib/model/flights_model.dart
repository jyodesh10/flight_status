class FlightModel {
  String? hex;
  String? regNumber;
  String? flag;
  num? lat;
  num? lng;
  int? alt;
  int? dir;
  int? speed;
  num? vSpeed;
  String? squawk;
  String? flightNumber;
  String? flightIcao;
  String? flightIata;
  String? depIcao;
  String? depIata;
  String? arrIcao;
  String? arrIata;
  String? airlineIcao;
  String? airlineIata;
  String? aircraftIcao;
  int? updated;
  String? status;

  FlightModel(
      {this.hex,
      this.regNumber,
      this.flag,
      this.lat,
      this.lng,
      this.alt,
      this.dir,
      this.speed,
      this.vSpeed,
      this.squawk,
      this.flightNumber,
      this.flightIcao,
      this.flightIata,
      this.depIcao,
      this.depIata,
      this.arrIcao,
      this.arrIata,
      this.airlineIcao,
      this.airlineIata,
      this.aircraftIcao,
      this.updated,
      this.status});

  FlightModel.fromJson(Map<String, dynamic> json) {
    hex = json['hex'];
    regNumber = json['reg_number'];
    flag = json['flag'];
    lat = json['lat'];
    lng = json['lng'];
    alt = json['alt'];
    dir = json['dir'];
    speed = json['speed'];
    vSpeed = json['v_speed'];
    squawk = json['squawk'];
    flightNumber = json['flight_number'];
    flightIcao = json['flight_icao'];
    flightIata = json['flight_iata'];
    depIcao = json['dep_icao'];
    depIata = json['dep_iata'];
    arrIcao = json['arr_icao'];
    arrIata = json['arr_iata'];
    airlineIcao = json['airline_icao'];
    airlineIata = json['airline_iata'];
    aircraftIcao = json['aircraft_icao'];
    updated = json['updated'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['hex'] = hex;
    data['reg_number'] = regNumber;
    data['flag'] = flag;
    data['lat'] = lat;
    data['lng'] = lng;
    data['alt'] = alt;
    data['dir'] = dir;
    data['speed'] = speed;
    data['v_speed'] = vSpeed;
    data['squawk'] = squawk;
    data['flight_number'] = flightNumber;
    data['flight_icao'] = flightIcao;
    data['flight_iata'] = flightIata;
    data['dep_icao'] = depIcao;
    data['dep_iata'] = depIata;
    data['arr_icao'] = arrIcao;
    data['arr_iata'] = arrIata;
    data['airline_icao'] = airlineIcao;
    data['airline_iata'] = airlineIata;
    data['aircraft_icao'] = aircraftIcao;
    data['updated'] = updated;
    data['status'] = status;
    return data;
  }
}
