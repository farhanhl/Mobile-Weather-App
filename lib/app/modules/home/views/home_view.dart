import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../core/api.dart';
import '../../../core/app_colors.dart';
import '../controllers/home_controller.dart';
import '../services/home_service.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(
        HomeService(
          Get.find<Api>(),
        ),
      ),
      builder: (controller) {
        return WillPopScope(
          onWillPop: () async {
            if (controller.isBackButton) {
              return true;
            } else {
              return false;
            }
          },
          child: Scaffold(
            body: DoubleBackToCloseApp(
              snackBar: const SnackBar(
                content: Text(
                  "Tap again to exit",
                  style: TextStyle(fontFamily: 'Lato'),
                ),
                backgroundColor: primaryColor,
              ),
              child: Center(
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        primaryColor,
                        secondaryColor,
                      ],
                    ),
                  ),
                  child: SafeArea(
                    child: Container(
                      padding: EdgeInsets.all(16.sp),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: lightColor,
                              borderRadius: BorderRadius.circular(6.sp),
                              gradient: const LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: [
                                  colorPalette1,
                                  colorPalette2,
                                ],
                              ),
                            ),
                            padding: EdgeInsets.all(12.sp),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  controller.getGreeting(),
                                  style: TextStyle(
                                    fontSize: 32.0.sp,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8.h),
                                  child: controller.isLoading
                                      ? const SizedBox.shrink()
                                      : Text(
                                          controller.quotesModel.content ?? "-",
                                          maxLines: 4,
                                          style: TextStyle(
                                            fontSize: 18.sp,
                                            color: secondaryColor,
                                          ),
                                        ),
                                ),
                                controller.isLoading
                                    ? const SizedBox.shrink()
                                    : Text(
                                        controller.quotesModel.author ?? "-",
                                        maxLines: 4,
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          color: primaryColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.h),
                            child: TextFormField(
                              controller: controller.weatherFieldController,
                              decoration: InputDecoration(
                                hintText: "City",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.r),
                                  borderSide: BorderSide(
                                    width: 1.w,
                                    color: lightColor,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.r),
                                  borderSide: BorderSide(
                                    width: 1.w,
                                    color: lightColor,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.r),
                                  borderSide: BorderSide(
                                    width: 1.w,
                                    color: lightColor,
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.r),
                                  borderSide: BorderSide(
                                    width: 1.w,
                                    color: errorColor,
                                  ),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 10.h,
                                  horizontal: 10.h,
                                ),
                                filled: true,
                                fillColor: lightColor,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color?>(
                                      colorPalette1),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.sp),
                                ),
                              ),
                            ),
                            onPressed: () => controller.getWeatherData(
                              controller.weatherFieldController.text,
                            ),
                            child: const Text("Submit"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
