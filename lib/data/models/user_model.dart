class UserModel {
  final String username;
  final String password;
  final String lastname;
  final String email;
  final String imageUrl;
  final String phoneNumber;
  final String userId;
  final String fcmToken;
  final String authUUId;

  UserModel({
    required this.username,
    required this.lastname,
    required this.password,
    required this.userId,
    required this.imageUrl,
    required this.phoneNumber,
    required this.email,
    required this.fcmToken,
    required this.authUUId,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      username: json['username'] as String? ?? '',
      lastname: json['lastname'] as String? ?? '',
      password: json['password'] as String? ?? '',
      userId: json['userId'] as String? ?? '',
      imageUrl: json['imageUrl'] as String? ?? '',
      phoneNumber: json['phoneNumber'] as String? ?? '',
      email: json['email'] as String? ?? '',
      fcmToken: json['fcm_token'] as String? ?? '',
      authUUId: json['authUUId'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'lastname': lastname,
      'password': password,
      'userId': userId,
      'imageUrl': imageUrl,
      'phoneNumber': phoneNumber,
      'email': email,
      "fcm_token": fcmToken,
      "authUUId": authUUId,
    };
  }

  Map<String, dynamic> toJsonForUpdate() {
    return {
      'username': username,
      'lastname': lastname,
      'password': password,
      'imageUrl': imageUrl,
      'phoneNumber': phoneNumber,
      'email': email,
      "fcm_token": fcmToken,
      "authUUId": authUUId,
    };
  }

  UserModel copyWith({
    String? username,
    String? lastname,
    String? password,
    String? userId,
    String? imageUrl,
    String? phoneNumber,
    String? email,
    String? fcmToken,
    String? authUUId,
  }) {
    return UserModel(
      username: username ?? this.username,
      lastname: lastname ?? this.lastname,
      password: password ?? this.password,
      userId: userId ?? this.userId,
      imageUrl: imageUrl ?? this.imageUrl,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      fcmToken: fcmToken ?? this.fcmToken,
      authUUId: authUUId ?? this.authUUId,
    );
  }

  static UserModel initial() => UserModel(
    username: '',
    lastname: '',
    password: '',
    userId: '',
    imageUrl: '',
    phoneNumber: '',
    email: '',
    fcmToken: '',
    authUUId: '',
  );
}
