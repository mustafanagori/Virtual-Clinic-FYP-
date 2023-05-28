class PatientModel {
  final String userID;
  final String name;
  final String contact;
  final String cnic;
  final String gender;

  PatientModel({
    required this.userID,
    required this.name,
    required this.contact,
    required this.cnic,
    required this.gender,
  });

  factory PatientModel.fromMap(
      {required Map<String, dynamic> map, required String userID}) {
    return PatientModel(
      userID: userID,
      name: map['name'],
      gender: map["gender"],
      contact: map["contact"],
      cnic: map["cnic"],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "contact": contact,
      "cnic": cnic,
      "gender": gender,
    };
  }
}
