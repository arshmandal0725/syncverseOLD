class SensorData {
 
  var flame;
  var gas;
  var gastank;
  var Humidity;
  var mcbbool;
  var booll;
  var exhaust;
  var siren;
  var Temperature;

  SensorData({
    // required this.exos,
    required this.flame,
    required this.gas,
    required this.gastank,
    required this.Humidity,
    required this.mcbbool,
    required this.booll,
    required this.exhaust,
    required this.siren,
    required this.Temperature,
  });

  factory SensorData.fromSnapshot(Map<dynamic, dynamic> snapshot) {
    return SensorData(
      // exos: snapshot['exos'] ?? '',
      flame: snapshot['flame'] ?? '',
      gas: snapshot['gas'].toString() ?? '',
      gastank: snapshot['gastank'] ?? '',
      Humidity: snapshot['Humidity'].toString() ?? '',
      mcbbool: snapshot['mcbbool'] ?? '',
      booll: snapshot['bool'] ?? '',
      exhaust: snapshot['exhaust'] ?? '',
      siren: snapshot['siren'] ?? '',
      Temperature: snapshot['Temperature'].toString() ?? '',
    );
  }

  // Factory method to create an empty SensorData object
  factory SensorData.empty() {
    return SensorData(
      // exos: '',
      flame: false,
      gas: '',
      gastank: '',
      Humidity: '',
      mcbbool: true,
      siren: false,
      Temperature: '', 
      booll: false,
      exhaust: false
    );
  }
}