import 'package:hive/hive.dart';

part '../hive/user_model.g.dart';

@HiveType(typeId: 0)
class UserModel {
  @HiveField(0)
  String id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String? age;
  @HiveField(3)
  String? gender;
  @HiveField(4)
  String? type;
  @HiveField(5)
  bool isLoggedIn;

  UserModel({
    required this.id,
    required this.name,
    this.age,
    this.gender,
    this.type,
    this.isLoggedIn = false,
  });

  factory UserModel.fromJson(data) {
    return UserModel(id: data["id"], name: data["name"]);
  }
}
