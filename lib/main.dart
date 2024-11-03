import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:testutaflutter/UI/profesor.dart';
import 'package:testutaflutter/utils/colors.dart';


void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});


  // This widget is the root of your application.

  Size generalSize = Size(450, 240);


  @override
  Widget build(BuildContext context) {
    if(kIsWeb){ //web
      print("kIsWeb");
      generalSize = Size(480, 400);
    }else{
        if (Platform.isAndroid){
          print("Android");
          generalSize = Size(160, 240);
        }else if(Platform.isWindows){
          print("isWindows");
          generalSize = Size(450, 240);
        }else  if(Platform.isLinux){
          print("isLinux");
          generalSize = Size(160, 240);
        }else if(Platform.isIOS){
          print("isIOS");
          generalSize = Size(160, 240);
        }
    }

    return ScreenUtilInit(
      designSize: generalSize ,//const Size(160, 240),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        title: 'Flutter Demo UTA',
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor:secondary),
            useMaterial3: true,
            primaryColor: Colors.amber,
          ),
        
        home:  const ProfesorViewUI()  
      ),
    );
  }
}
