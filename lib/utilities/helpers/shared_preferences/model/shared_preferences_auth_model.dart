class AuthUserModel {
  final String userToken;
  final String userId;
  final String userName;
  final String userEmail;
  final String userProfileImg;
  final String userPhone;
  // final String userFirstName;
  // final String userLastName;

  AuthUserModel({
    required this.userToken,
    required this.userId,
    required this.userName,
    required this.userEmail,
    required this.userProfileImg,
    required this.userPhone,
    // required this.userFirstName,
    // required this.userLastName,
  });

  Map<String, dynamic> toJson() => {
    'userToken': userToken,
    'userId': userId,
    'userName': userName,
    'userEmail': userEmail,
    'userProfileImg': userProfileImg,
    'userPhone': userPhone,
    // 'userFirstName': userFirstName,
    // 'userLastName': userLastName,
  };

  getAllProps() {
    print('userToken ${userToken.isNotEmpty ? userToken : 'no data'}');
    print('userId ${userId.isNotEmpty ? userId : 'no data'}');
    print('userName ${userName.isNotEmpty ? userName : 'no data'}');
    print('userEmail ${userEmail.isNotEmpty ? userEmail : 'no data'}');
    print('userProfileImg ${userProfileImg.isNotEmpty ? userProfileImg : 'no data'}');
    print('userPhone ${userPhone.isNotEmpty ? userPhone : 'no data'}');
  }
}
