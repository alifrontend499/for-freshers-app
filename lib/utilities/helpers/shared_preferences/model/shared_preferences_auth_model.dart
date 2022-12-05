class AuthUserModel {
  final String userName;
  final String userProfileImg;
  final String userFirstName;
  final String userLastName;

  AuthUserModel({
    required this.userName,
    required this.userProfileImg,
    required this.userFirstName,
    required this.userLastName,
  });

  Map<String, dynamic> toJson() => {
    'userName': userName,
    'userProfileImg': userProfileImg,
    'userFirstName': userFirstName,
    'userLastName': userLastName,
  };
}
