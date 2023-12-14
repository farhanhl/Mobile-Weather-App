import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:weather_app/app/core/widget/dialog.dart';
import 'package:weather_app/app/modules/home/models/quotes_model.dart';
import '../../../core/app_colors.dart';
import '../models/weather_model.dart';
import '../services/home_service.dart';

class HomeController extends GetxController {
  HomeService services;
  HomeController(this.services);
  DateTime now = DateTime.now();
  TextEditingController weatherFieldController = TextEditingController();
  QuotesModel quotesModel = QuotesModel();
  WeatherModel weatherModel = WeatherModel();
  bool isBackButton = false;
  bool isLoading = false;

  String getGreeting() {
    int hour = now.hour;

    if (hour >= 4 && hour < 12) {
      return 'Good morning!';
    } else if (hour >= 12 && hour < 20) {
      return 'Good afternoon!';
    } else {
      return 'Good night!';
    }
  }

  @override
  void onInit() async {
    super.onInit();
    isLoading = true;
    await getQuotesData();
  }

  Future<void> getQuotesData() async {
    isLoading = true;
    services.getQuotesData().then((value) {
      isLoading = false;
      value.author = "- ${value.author!}";
      quotesModel = value;
      update();
    }).catchError(
      (e) {
        isLoading = false;
        log("$e");
      },
    );
  }

  Future<void> getWeatherData(String city) async {
    if (city.isEmpty) {
      Get.snackbar(
        "Notification",
        "Please fill the form",
        backgroundColor: errorColor,
        colorText: lightColor,
        snackPosition: SnackPosition.TOP,
      );
    } else {
      submitForm();
      await services.getWeatherData(city).then((value) {
        weatherModel = value;
        Get.defaultDialog(
          title: "Result",
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                "assets/images/${weatherModel.weather![0].main!}.png",
                alignment: Alignment.center,
                height: 100.h,
                width: 100.w,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 6.h),
                child: Text(
                  "${weatherModel.main!.temp} °C",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24.sp,
                  ),
                ),
              ),
              Text(
                capitalizeFirstLetter(weatherModel.weather![0].description!),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24.sp,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text(
                          "${weatherModel.main!.humidity}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            const Text("Humidity "),
                            FaIcon(
                              FontAwesomeIcons.water,
                              size: 18.sp,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "${weatherModel.wind!.speed}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            const Text("Wind "),
                            FaIcon(
                              FontAwesomeIcons.wind,
                              size: 18.sp,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color?>(colorPalette1),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.sp),
                    ),
                  ),
                ),
                onPressed: () => Get.back(),
                child: const Text("Back"),
              )
            ],
          ),
        );
        finishSubmit();
        update();
      }).catchError(
        (e) {
          finishSubmit();
          final statusCode = getStatusCode("$e");
          CustomDialog.defaultDialog(
            statusCode: statusCode,
            message404: "City not found",
          );
        },
      );
    }
  }

  void submitForm() {
    isBackButton = false;
    EasyLoading.show(
      status: 'Loading...',
      dismissOnTap: false,
      maskType: EasyLoadingMaskType.black,
    );
    FocusManager.instance.primaryFocus?.unfocus();
    update();
  }

  void finishSubmit() {
    isBackButton = true;
    EasyLoading.dismiss();
    update();
  }

  String capitalizeFirstLetter(String word) {
    return word[0].toUpperCase() + word.substring(1);
  }

  int getStatusCode(String exception) {
    RegExp regex = RegExp(r'\[(\d+)\]');
    Match? match = regex.firstMatch(exception);
    String? errorStatusCode;
    int statusCode = 0;

    if (match != null) {
      errorStatusCode = match.group(1)!;
      statusCode = int.parse(errorStatusCode);
      return statusCode;
    } else {
      return statusCode;
    }
  }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  // @override
  // void onClose() {
  //   super.onClose();
  // }
}
