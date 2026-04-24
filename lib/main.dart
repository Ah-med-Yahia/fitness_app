import 'package:easy_localization/easy_localization.dart';

import 'package:fitness_app/fitness_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'config/bloc_observer/bloc_observer.dart';
import 'config/di/di.dart';
import 'core/constants/app_text_constants.dart';
import 'core/constants/path_constant.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  await configureDependencies();
  await EasyLocalization.ensureInitialized();

  runApp(
    //const FitnessApp(),
    EasyLocalization(
      supportedLocales: const [
        Locale(AppTextConstants.enLangKey),
        Locale(AppTextConstants.arLangKey),
      ],
      path: PathConstant.translationsPath,
      startLocale: null,
      fallbackLocale: const Locale(AppTextConstants.enLangKey),
      useOnlyLangCode: true,
      saveLocale: false,
      child: const FitnessApp(),

    ),
  );
}
