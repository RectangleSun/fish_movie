import 'dart:convert' show json;
import 'dart:ui' as ui;
import 'package:dio/dio.dart';
import 'package:fish_demo/globalbasestate/action.dart';
import 'package:fish_demo/globalbasestate/store.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../app_config.dart';
import 'request.dart';

class TMDBApi {
  TMDBApi._();
  static final TMDBApi _instance = TMDBApi._();
  static TMDBApi get instance => _instance;

  String _apikey;
  String _apikeyV4;
  String _requestToken;
  String accessTokenV4;
  String session;
  DateTime _sessionExpiresTime;
  SharedPreferences prefs;
  String _language = ui.window.locale.languageCode;
  String region = ui.window.locale.countryCode;
  bool _includeAdult;
  Request _http;
  Request _httpV4;

  Future<void> init() async {
    _http = Request(AppConfig.instance.theMovieDBHostV3);
    _httpV4 = Request(AppConfig.instance.theMovieDBHostV4);
    _apikey = AppConfig.instance.theMovieDBApiKeyV3;
    _apikeyV4 = AppConfig.instance.theMovieDBApiKeyV4;
    prefs = await SharedPreferences.getInstance();
    _includeAdult = prefs.getBool('adultItems') ?? false;

  }

  void setAdultValue(bool adult) {
    _includeAdult = adult ?? false;
  }

  void setLanguage(String languageCode) {
    if (languageCode == null)
      _language = ui.window.locale.languageCode;
    else
      _language = languageCode;
  }

  Future createGuestSession() async {
    String param = '/authentication/guest_session/new?api_key=$_apikey';
    final r = await _http.request(param);
    if (r.success) {
      if (r.result['success']) {
        session = r.result['guest_session_id'];
        _sessionExpiresTime = DateTime.parse(r.result['expires_at']
            .toString()
            .replaceFirst(new RegExp(' UTC'), ''));
        var date = DateTime.utc(
            _sessionExpiresTime.year,
            _sessionExpiresTime.month,
            _sessionExpiresTime.day,
            _sessionExpiresTime.hour,
            _sessionExpiresTime.minute,
            _sessionExpiresTime.second,
            _sessionExpiresTime.millisecond,
            _sessionExpiresTime.microsecond);
        prefs.setString('guestSession', session);
        prefs.setString('guestSessionExpires', date.toIso8601String());
      }
    }
  }

  Future createRequestToken() async {
    String param = '/authentication/token/new?api_key=$_apikey';
    dynamic r = await _http.request(param);
    if (r != null) {
      if (r['success']) {
        _requestToken = r['request_token'];
      }
    }
  }


}
