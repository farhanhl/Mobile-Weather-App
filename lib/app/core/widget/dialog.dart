import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:weather_app/app/core/app_colors.dart';

class CustomDialog {
  static defaultDialog({
    required int statusCode,
    String message400 = "Bad Request",
    String message401 = "Unauthorized",
    String message404 = "Not Found",
    String message500 = "Internal Server Error",
    dynamic defaultMessage = "Something Went Wrong",
  }) {
    return Get.defaultDialog(
      barrierDismissible: false,
      title: "",
      content: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0.sp),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                "assets/images/error.png",
                height: 150.h,
                width: 150.w,
                fit: BoxFit.fill,
              ),
              SizedBox(height: 10.h),
              Text(
                "Error!",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
              ),
              SizedBox(height: 5.h),
              Text(
                statusCode == 400
                    ? message400
                    : statusCode == 401
                        ? message401
                        : statusCode == 404
                            ? message404
                            : statusCode == 500
                                ? message500
                                : defaultMessage,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 15.h),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Get.back(),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color?>(primaryColor),
                      ),
                      child: const Text("Close"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
