import 'dart:convert';
import 'package:http/http.dart';
import 'package:pinterest_app/models/collection_model.dart';
import 'log_service.dart';

class Network1 {
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

  /* Http apis for collections */

  static String API_COLLECTION = "/collections";

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

  /* Http parsing */

  static List<Collection> parseCollection(String response){
    List<Collection> collections = collectionFromJson(response);
    return collections;
  }
}
