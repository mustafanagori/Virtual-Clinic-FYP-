class CreateAppointmentModel {
  final String userID;
  final String patientID;
  String status;
  final String sheduleID;
  final String doctorID;

  CreateAppointmentModel({
    required this.userID,
    required this.patientID,
    required this.status,
    required this.sheduleID,
    required this.doctorID,
  });

  factory CreateAppointmentModel.fromMap(
      {required Map<String, dynamic> map, required String userID}) {
    return CreateAppointmentModel(
      userID: userID,
      doctorID: map['doctorID'],
      patientID: map['patientID'],
      sheduleID: map["sheduleID"],
      status: map["status"],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      "patientID": patientID,
      "status": status,
      "doctorID": doctorID,
      "sheduleID": sheduleID,
    };
  }
}
