import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class Network{
  final String _url = 'https://clickcloudschool.com/api/';
  // final String _url = 'http://10.0.2.2:8000/api/';
  // final String _url = 'http://localhost:8000/api/';
  // var token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6ImI2Njk2Y2MwYjM1MzUzZTVmMjIwODY0NWU2YTUzMDViODBlMjJmOWUwOGQ1N2ZhMTQ2OTkwMTExODJkYzk4OTlkZWM1MjI2ZTQ0MDIwZGQ0In0.eyJhdWQiOiIzIiwianRpIjoiYjY2OTZjYzBiMzUzNTNlNWYyMjA4NjQ1ZTZhNTMwNWI4MGUyMmY5ZTA4ZDU3ZmExNDY5OTAxMTE4MmRjOTg5OWRlYzUyMjZlNDQwMjBkZDQiLCJpYXQiOjE2Mzk4ODI0ODMsIm5iZiI6MTYzOTg4MjQ4MywiZXhwIjoxNjcxNDE4NDgzLCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.jTbwQ4LC-OzmNktDHLnQvg8TXzRe7SPpV1xkzzCACA0ismCXKBeappC0f4Xm1O5HL8kJMVZAQtykrgEwfzLt8VBg6jlCimGAPiubyDIEVav6MtxfOG7WqBP25ogQxb_7i1OLrq33aYbwpfocmlBgQ7rdTZ1xfpsGWLPjcqW52yvs268Y_jxiY4bCIsPL46MsGBRDFzKcx4rYudj5vj6tNxOiHttf-5mDB5_poRkEgYhcFRQrRuCiXU71NHXTMHvIix8rSLezo78_yzIrbtyKGsBaWfDTRnaLY2a2PrQMiA1bK1PbqeBgG2fPiqoe4jyOu8sBP856ExYp-YddURSWIMSxqgYxG5N6cBODfB_49BgY70ga-DZeKLa2HLAb9xhAatsAtIv81ZwMKUM-F3OephAxreY-MAVchT5CG35jGzOVINb0fFioDi6sfkbZWBpzs7n7dAUr_TWG1GvrAHqUq6knBhrR9AcyK-ECdwuTFj6tCK0zdrl4BhDCG6-zdKvnsQL3k6-xTLadeDllywPB-jZd0-k7RpTkC4EB42UQwGZQZV8cY1hq3h7AQ0R28ItSXGJWdI0SVPL7vtJjMlhLRhmm4kW6xOmY7gm7YasoL15FtZzB2Fc-m4CtLCNoJrZqcrKEtFsYxenlhehPsnh4jfUiajIh09YDsBjPHkcBpIg';
  var token;


  _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    token = convert.jsonDecode(localStorage.getString('token'));
  }

  setToken(token) async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.setString('token', convert.json.encode(token));
    // print(convert.json.encode(token));
  }

  clearToken() async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.clear();
  }

  authData(data, apiUrl) async {
    HttpOverrides.global = new MyHttpOverrides();
    var fullUrl = _url + apiUrl;
    var res = await http.post(fullUrl, body: convert.jsonEncode(data), headers: _setHeaders());
    return res;
  }

  createUser(data,apiUrl) async {
    HttpOverrides.global = new MyHttpOverrides();
    var fullUrl = _url + apiUrl;
    var res = await http.post(fullUrl, body: convert.jsonEncode(data), headers: _setHeaders());
    return res;
  }

  getData(apiUrl) async {
    HttpOverrides.global = new MyHttpOverrides();
    // var apiUrl = "user";
    var fullUrl = _url + apiUrl;
    await _getToken();
    var res = await http.get(fullUrl, headers: _setHeaders());
    var body =  convert.json.decode(res.body);
    return body;
  }

  getDataCheck(apiUrl) async {
    HttpOverrides.global = new MyHttpOverrides();
    // var apiUrl = "user";
    var fullUrl = _url + apiUrl;
    await _getToken();
    var res = await http.get(fullUrl, headers: _setHeaders());
    var body =  res.body;
    return body;
  }
  getList(apiUrl) async {
    HttpOverrides.global = new MyHttpOverrides();
    // var apiUrl = "user";
    var fullUrl = _url + apiUrl;
    await _getToken();
    var res = await http.get(fullUrl, headers: _setHeaders());
    var body =  res.body;
    return body;
  }

  checkToken(token,apiUrl) async {
    HttpOverrides.global = new MyHttpOverrides();
    var fullUrl = _url + apiUrl;
    // // await _getToken();
    var res = await http.get(fullUrl, headers: _testHeaders(convert.jsonEncode(token)));
    var body =  convert.json.decode(res.body);
    // return  convert.json.encode(body);
    return body;
  }

  _setHeaders() => {
    'Content-type' : 'application/json',
    'Accept' : 'application/json',
    'Authorization' : 'Bearer $token'
  };
  _testHeaders(token) => {
    'Content-type' : 'application/json',
    'Accept' : 'application/json',
    'Authorization' : 'Bearer $token'
  };

}