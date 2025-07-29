import 'package:bookstore_app/core/app_routes/app_router.dart';
import 'package:bookstore_app/core/app_routes/routes.dart';
import 'package:bookstore_app/core/services/local/shared_prefs_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookStore extends StatelessWidget {
  const BookStore({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: startRoute(),
        onGenerateRoute: AppRouter.onGenerateRoute,
      ),
    );
  }

     startRoute (){
    if (SharedPrefsHelper.getData(key:  SharedPrefsKey.userToken)!= null){
      return Routes.bottomNavBarScreen;
    } else {
      return Routes.splashScreen;
    }
  }}
