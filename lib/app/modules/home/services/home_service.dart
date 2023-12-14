import 'package:dio/dio.dart';
import '../../../core/api.dart';
import '../models/quotes_model.dart';
import '../models/weather_model.dart';

class HomeService {
  Api api;
  HomeService(this.api);

  Future<WeatherModel> getWeatherData(String city) {
    return api.getWeatherData(city).then((value) {
      return WeatherModel.fromJson(value.data);
    }).catchError(
      (e) {
        throw Exception(
          e.runtimeType == DioError
              ? (e as DioError).error
              : "Something went wrong: $e",
        );
      },
    );
  }

  Future<QuotesModel> getQuotesData() {
    return api.getQuotesData().then((value) {
      return QuotesModel.fromJson(value.data[0]);
    }).catchError(
      (e) {
        throw Exception(
          e.runtimeType == DioError
              ? (e as DioError).error
              : "Something went wrong: $e",
        );
      },
    );
  }
}
