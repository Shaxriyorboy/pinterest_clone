import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:pinterest_app/models/user_model.dart';
import 'package:pinterest_app/models/profil_model.dart';

class DBService{
  static const String dbName = "db_profile";
  static var box = Hive.box(dbName);

  static storeList(List<String> list)async{
    box.put("imageList", list);
  }

  static List<String> loadImageList(){
    List<String> profile = box.get("imageList");
    return profile;
  }

  static removeNotes()async{
    await box.delete("imageList");
  }

  static storePostList(List<User> list)async{
    List<String> stringList =  list.map((json) => jsonEncode(json.toJson())).toList();
    await box.put("stringList", stringList);
  }
  
  static List<User> loadPostList(){
    List<String> list = box.get("stringList");
    List<User> listUserList = list.map((e) => User.fromJson(jsonDecode(e))).toList();
    return listUserList;
  }

  static removeUser()async{
    await box.delete("stringList");
  }

}