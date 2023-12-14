import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'app/core/api.dart';
import 'app/routes/app_pages.dart';

void main() async {
  runApp(
    ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: "Weather App",
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
          builder: EasyLoading.init(),
          initialBinding: BindingsBuilder(
            () async {
              Get.put(
                Api(),
                permanent: true,
              );
            },
          ),
        );
      },
    ),
  );
}
