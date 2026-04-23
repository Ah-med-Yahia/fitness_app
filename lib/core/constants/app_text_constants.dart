import 'package:easy_localization/easy_localization.dart';

class AppTextConstants {
  AppTextConstants._();

  static const String enLangKey = 'en';
  static const String arLangKey = 'ar';

  // Common
  static String get loading => 'common.loading'.tr();
  static String get cancel => 'common.cancel'.tr();
  static String get confirm => 'common.confirm'.tr();
  static String get done => 'common.done'.tr();
  static String get next => 'common.next'.tr();
  static String get back => 'common.back'.tr();

  //OnBoarding
  static String get skip => 'onBoarding.skip'.tr();
  static String get page1Title => 'onBoarding.page1Title'.tr();
  static String get page1Description => 'onBoarding.page1Description'.tr();
  static String get page2Title => 'onBoarding.page2Title'.tr();
  static String get page2Description => 'onBoarding.page2Description'.tr();
  static String get page3Title => 'onBoarding.page3Title'.tr();
  static String get page3Description => 'onBoarding.page3Description'.tr();

  // Auth
  static String get email => 'auth.email'.tr();
  static String get forgetPassword => 'auth.forgetPassword'.tr();
  static String get enterYourEmail => 'auth.enterYourEmail'.tr();
  static String get sendOtp => 'auth.sendOtp'.tr();
  static String get otpCode => 'auth.otpCode'.tr();
  static String get enterYourOtpCheckYourEmail =>
      'auth.enterYourOtpCheckYourEmail'.tr();
  static String get didntRecieveVerificationCode =>
      'auth.didntRecieveVerificationCode'.tr();
  static String get resendCode => 'auth.resendCode'.tr();
  static String get makeSureIts8CharactersOrMore =>
      'auth.makeSureIts8CharactersOrMore'.tr();
  static String get createNewPassword => 'auth.createNewPassword'.tr();
  static String get newPassword => 'auth.newPassword'.tr();
  static String get confirmPassword => 'auth.confirmPassword'.tr();

  // Validation Messages
  static String get pleaseEnterValidEmail =>
      'validation.pleaseEnterValidEmail'.tr();
  static String get pleaseEnterValidOtp =>
      'validation.pleaseEnterValidOtp'.tr();
  static String get pleaseEnterValidPassword =>
      'validation.pleaseEnterValidPassword'.tr();

  // Success Messages
  static String get otpSentSuccessfully => 'messages.otpSentSuccessfully'.tr();
  static String get passwordResetSuccessfully =>
      'messages.passwordResetSuccessfully'.tr();
}
