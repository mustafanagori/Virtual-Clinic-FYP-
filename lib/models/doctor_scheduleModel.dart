class DoctorScheduleModel {
  final String userID;
  final String day;
  final String endTime;
  final String fees;
  final String startTime;
  final String doctorID;
  DoctorScheduleModel({
    required this.userID,
    required this.endTime,
    required this.day,
    required this.fees,
    required this.startTime,
    required this.doctorID,
  });

  factory DoctorScheduleModel.fromMap(
      {required Map<String, dynamic> map, required String userID}) {
    return DoctorScheduleModel(
      userID: userID,
      doctorID: map['doctorID'],
      day: map['day'],
      endTime: map["endTime"],
      startTime: map["startTime"],
      fees: map["fees"],
    );
  }

  get patientID => null;
  Map<String, dynamic> toMap() {
    return {
      "endTime": endTime,
      "startTime": startTime,
      "fees": fees,
      "day": day,
      "doctorID": doctorID,
    };
  }
}
