class DoctorModel {
  final String userID;
  final String firstName;
  final String lastName;
  final String contact;
  final String prno;
  final String cnic;
  final String gender;
  final String uniname;
  final String degprogram;
  final String passyear;
  final String skills;
  final String cgpa;
  final String spealization;
  final List rating;

  DoctorModel(
      {required this.userID,
      required this.rating,
      required this.firstName,
      required this.lastName,
      required this.contact,
      required this.prno,
      required this.cnic,
      required this.gender,
      required this.uniname,
      required this.degprogram,
      required this.passyear,
      required this.skills,
      required this.cgpa,
      required this.spealization});

  factory DoctorModel.fromMap(
      {required Map<String, dynamic> map, required String userID}) {
    return DoctorModel(
      userID: userID,
      firstName: map["firstName"],
      lastName: map["lastName"],
      prno: map["prno"],
      gender: map["gender"],
      contact: map["contact"],
      uniname: map["uniname"],
      degprogram: map["degprogram"],
      passyear: map["passyear"],
      cgpa: map["cgpa"],
      skills: map["skills"],
      spealization: map["spealization"],
      cnic: map["cnic"],
      rating: map["rating"],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      "firstName": firstName,
      "lastName": lastName,
      "contact": contact,
      "prno": prno,
      "cnic": cnic,
      "gender": gender,
      "uniname": uniname,
      "degprogram": degprogram,
      "passyear": passyear,
      "cgpa": cgpa,
      "skills": skills,
      "spealization": spealization,
      "rating": rating
    };
  }
}
