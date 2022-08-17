import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String accessToken;
  final String tokenType;
  final Map user;
  // final int id;
  // final String name;
  // final String email;
  // final String address;
  // final String houseNumber;
  // final String phoneNumber;
  // final String city;
  // final String picturePath;
  // static String? token;

  User({
    required this.accessToken,
    required this.tokenType,
    required this.user,
    // required this.address,
    // required this.houseNumber,
    // required this.phoneNumber,
    // required this.city,
    // required this.picturePath
  });

  factory User.fromJson(Map<String, dynamic> data) => User(
        accessToken: data['accessToken'],
        tokenType: data['tokenType'],
        user: data['user'],
        // id: data['id'],
        // name: data['name'],
        // email: data['email'],
        // address: data['address'],
        // houseNumber: data['houseNumber'],
        // phoneNumber: data['phoneNumber'],
        // city: data['city'],
        // picturePath: data['profile_photo_url'],
      );

  User copyWith({
    required int accessToken,
    required String tokenType,
    required String user,
    // required int id,
    // required String name,
    // required String email,
    // required String address,
    // required String houseNumber,
    // required String phoneNumber,
    // required String city,
    // required String picturePath,
  }) =>
      User(
        accessToken: this.accessToken,
        tokenType: this.tokenType,
        user: this.user,
        // id: this.id,
        // name: this.name,
        // email: this.email,
        // address: this.address,
        // houseNumber: this.houseNumber,
        // phoneNumber: this.phoneNumber,
        // city: this.city,
        // picturePath: this.picturePath
      );

  @override
  List<Object> get props => [accessToken, tokenType, user];
  //id, name, email, address, houseNumber, phoneNumber, city, picturePath
}

// User mockUser = User(
//     id: 1,
//     name: 'Jennie Kim',
//     address: 'Jalan Jenderal Sudirman',
//     city: 'Bandung',
//     houseNumber: '1234',
//     phoneNumber: '08123456789',
//     email: 'jennie.kim@blackpink.com',
//     picturePath:
//         'https://i.pinimg.com/474x/8a/f4/7e/8af47e18b14b741f6be2ae499d23fcbe.jpg');
