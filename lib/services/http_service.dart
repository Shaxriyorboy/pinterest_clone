import 'dart:convert';
import 'package:http/http.dart';
import 'package:pinterest_app/models/user_model.dart';
import 'log_service.dart';

class Network {
  static bool isTester = true;

  static String SERVER_DEVELOPMENT = "api.unsplash.com";
  static String SERVER_PRODUCTION = "jsonplaceholder.typicode.com";

  /* Header */
  static Map<String, String> headers={
  "Authorization": "Client-ID 565RutOixmOocXRTpGVazfrMt5TXje7_YbeYS8rRlUc"
};

  /* Test Server */
  static String getServer() {
    if (isTester) return SERVER_DEVELOPMENT;
    return SERVER_PRODUCTION;
  }

  /*Http request*/
  static Future<String?> GET(String api, Map<String, dynamic> params) async {
    var uri = Uri.https(getServer(), api, params); // http or https
    var response = await get(uri,headers: headers);
    Log.d(response.body);
    if (response.statusCode == 200) return response.body;

    return null;
  }

  static Future<String?> GET_ONE(String api, Map<String, String> params) async {
    var uri = Uri.https(getServer(), api, params,); // http or https
    var response = await get(uri,headers: headers);
    Log.d(response.body);
    if (response.statusCode == 200) return response.body;

    return null;
  }

  static Future<String?> POST(String api, Map<String, String> params) async {
    var uri = Uri.https(getServer(), api); // http or https
    var response = await post(
      uri,
      body: jsonEncode(params),
      headers: headers,
    );
    Log.d(response.body);
    if (response.statusCode == 200) return response.body;

    return null;
  }

  static Future<String?> PUT(String api, Map<String, String> params) async {
    var uri = Uri.https(getServer(), api);
    var response =
        await put(uri, body: jsonEncode(params),headers: headers);
    Log.d(response.body);

    if (response.statusCode == 200) return response.body;
    return null;
  }

  static Future<String?> DEL(String api, Map<String, String> params) async {
    var uri = Uri.https(getServer(), api, params);
    var response = await get(uri,headers: headers);
    Log.d(response.body);

    if (response.statusCode == 200) return response.body;
    return null;
  }

  /* Http apis for all */
  static String API_LIST = "/photos";
  static String API_CREATE = "/photos";
  static String API_UPDATE = "/photos/"; //{id}
  static String API_DELETE = "/photos/"; //{id}



  /* Http apis for search */
  static String API_LIST_SEARCH = "/search/photos";
  static String API_CREATE_SEARCH = "/search/photos";
  static String API_UPDATE_SEARCH = "/search/photos/"; //{id}
  static String API_DELETE_SEARCH = "/search/photos/"; //{id}


  /* Http params */

  static Map<String, String> paramsEmpty() {
    Map<String, String> params = Map();
    return params;
  }


  static Map<String, dynamic> paramsPage(int pageNumber) {
    Map<String, String> params = {};
    params.addAll({
      "page":pageNumber.toString()
    });
    return params;
  }

  static Map<String, dynamic> paramsSearch(int pageNumber,String query) {
    Map<String, String> params = {};
    params.addAll({
      "page":pageNumber.toString(),
      "query":query.toString()
    });
    return params;
  }

  // static Map<String, String> paramsCreate(Employee employee) {
  //   Map<String, String> params = Map();
  //   params.addAll({
  //     "name" : employee.employee_name!,
  //     "salary" : employee.employee_salary!.toString(),
  //     "age" : employee.employee_age.toString(),
  //   });
  //   return params;
  // }

  // static Map<String, String> paramsUpdate(User user) {
  //   Map<String, String> params = Map();
  //   params.addAll({
  //     "id" : user.id.toString(),
  //     "name" : user.name!,
  //     "email" : user.email!,
  //     // "address": user.address!.toJson(),
  //   });
  //   return params;
  // }

  /* Http parsing */
  static User parseEmpOne(String body){
    dynamic json = jsonDecode(body);
    var data = User.fromJson(json);
    return data;
  }

  static List<User> parsePostList(String body){
    List<User> users = userFromJson(body);
    return users;
  }

  static List<User> parseSearchParse(String response) {
    Map<String, dynamic> json = jsonDecode(response);
    List<User> photos = List<User>.from(json["results"].map((x) => User.fromJson(x)));
    return photos;
  }
}
