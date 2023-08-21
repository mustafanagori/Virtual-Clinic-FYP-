class InviteModel {
  final String userID;
  final String drInvitedBy;
  final String drInvitedTo;

  InviteModel({
    required this.userID,
    required this.drInvitedBy,
    required this.drInvitedTo,
  });

  factory InviteModel.fromMap(
      {required Map<String, dynamic> map, required String userID}) {
    return InviteModel(
      userID: userID,
      drInvitedBy: map['invitedBy'],
      drInvitedTo: map["invitedTo"],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      "invitedBy": drInvitedBy,
      "invitedTo": drInvitedTo,
    };
  }
}
