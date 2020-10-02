import 'dart:async';
import 'package:http/http.dart' as http;

class NetworkUtil {
  static final NetworkUtil _instance = NetworkUtil.internal();
  NetworkUtil.internal();

  factory NetworkUtil() => _instance;

  Future<http.Response> get(String url,
      {Map<String, dynamic> parameters}) async {
    url = _getURL(url, parameters);
    return await http.get(
      url,
      headers: {
        'Accept': 'application/json',
        'content-type': 'application/json',
      },
    );
  }

  String _getURL(String url, Map<String, dynamic> map) {
    if (map != null && map.isNotEmpty) {
      var first = true;
      map.forEach((k, v) {
        if (first) {
          url = '$url?$k=$v';
          first = false;
        } else {
          url = '$url&$k=$v';
        }
      });
    }
    return url;
  }
}
