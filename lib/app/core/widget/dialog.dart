import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:weather_app/app/core/app_colors.dart';

class CustomDialog {
  static defaultDialog() {
    return Get.defaultDialog(
      barrierDismissible: false,
      title: "",
      content: Padding(
        padding: EdgeInsets.all(8.0.sp),
        child: Column(
          children: [
            Image.asset(
              "assets/images/error.png",
              height: 150.h,
              width: 150.w,
              fit: BoxFit.fill,
            ),
            SizedBox(
              height: 10.h,
            ),
            const Text("Error!"),
            SizedBox(
              height: 10.h,
            ),
            const Text(
              "Something went wrong",
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 15.h,
            ),
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
      ),
    );
  }
}
