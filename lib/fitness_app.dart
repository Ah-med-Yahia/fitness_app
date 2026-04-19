import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/routing/app_router.dart';
import 'package:fitness_app/core/routing/app_routes_constant.dart';
import 'package:fitness_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class FitnessApp extends StatelessWidget {
  const FitnessApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute:AppRoutesConstants.foodCategoryRoute,
      onGenerateRoute: RouteGenerator.getRoutes,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
    );
  }
}