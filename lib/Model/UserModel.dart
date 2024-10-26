import 'package:full_stack_practice/Database/tblUser.dart';

class UserModel{
  int? id;
  String? username;
  String? password;
  String? email;
  String? phonenumber;
  String? dateRegistered;
  String? token;

  UserModel({
    this.id,
    this.username,
    this.password,
    this.email,
    this.phonenumber,
    this.dateRegistered,
    this.token
  });



  static Map<String,dynamic> insertDataToLocal(UserModel userModel){
    Map<String,dynamic> result = {
      TblUser.uniqueID: userModel.id,
      TblUser.username: userModel.username,
      TblUser.email: userModel.email,
      TblUser.phonenumber: userModel.phonenumber,
      TblUser.dateRegistered: userModel.dateRegistered,
      TblUser.token: userModel.token
    };
    return result;
  }

  static UserModel getDataFromLocal(var json){
    UserModel userModel = UserModel();
    userModel.id = json[TblUser.uniqueID];
    userModel.username = json[TblUser.username];
    userModel.email = json[TblUser.email];
    userModel.phonenumber = json[TblUser.phonenumber];
    userModel.dateRegistered = json[TblUser.dateRegistered];
    userModel.token = json[TblUser.token];
    return userModel;
  }
}