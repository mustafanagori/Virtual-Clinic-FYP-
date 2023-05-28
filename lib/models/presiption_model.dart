class PresiptionModel {
  final String text;
  final String patientID;
  final String doctorID;
  final String userID;

  PresiptionModel({
    required this.userID,
    required this.patientID,
    required this.text,
    required this.doctorID,
  });

  factory PresiptionModel.fromMap(
      {required Map<String, dynamic> map, required String userID}) {
    return PresiptionModel(
      userID: userID,
      doctorID: map['doctorID'],
      patientID: map['patientID'],
      text: map["text"],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      "patientID": patientID,
      "text": text,
      "doctorID": doctorID,
    };
  }
}
