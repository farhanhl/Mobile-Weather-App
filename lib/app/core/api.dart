import 'package:dio/dio.dart';

const baseUrlWeather = "https://api.openweathermap.org";
const apiKeyWeather = "f434b38ca3e5ddddeb469b6aa2f7525f";
const baseUrlQuotes = "https://api.quotable.io";

class Api {
  final Dio dioWeather = Dio(
    BaseOptions(
      baseUrl: baseUrlWeather,
      contentType: 'application/json',
      connectTimeout: 60 * 1000,
      receiveTimeout: 60 * 1000,
    ),
  );
  final Dio dioQuotes = Dio(
    BaseOptions(
      baseUrl: baseUrlQuotes,
      contentType: 'application/json',
      connectTimeout: 60 * 1000,
      receiveTimeout: 60 * 1000,
    ),
  );

  Future<Response> getWeatherData(String city) => dioWeather.get(
        "/data/2.5/weather?q=$city&units=metric&appid=$apiKeyWeather",
      );

  Future<Response> getQuotesData() => dioQuotes.get(
        "/quotes/random",
      );
}
