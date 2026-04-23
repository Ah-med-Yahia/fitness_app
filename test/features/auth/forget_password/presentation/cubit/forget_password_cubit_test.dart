import 'package:bloc_test/bloc_test.dart';
import 'package:fitness_app/config/base_response/base_response.dart';
import 'package:fitness_app/features/auth/forget_password/domain/usecases/forget_password_use_case.dart';
import 'package:fitness_app/features/auth/forget_password/domain/usecases/reset_password_use_case.dart';
import 'package:fitness_app/features/auth/forget_password/domain/usecases/verify_code_use_case.dart';
import 'package:fitness_app/features/auth/forget_password/presentation/cubit/forget_password_cubit.dart';
import 'package:fitness_app/features/auth/forget_password/presentation/cubit/forget_password_intents.dart';
import 'package:fitness_app/features/auth/forget_password/presentation/cubit/forget_password_side_effects.dart';
import 'package:fitness_app/features/auth/forget_password/presentation/cubit/forget_password_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'forget_password_cubit_test.mocks.dart';

@GenerateMocks([ForgetPasswordUseCase, ResetPasswordUseCase, VerifyCodeUseCase])
void main() {
  late ForgetPasswordCubit cubit;
  late MockForgetPasswordUseCase mockForgetPasswordUseCase;
  late MockResetPasswordUseCase mockResetPasswordUseCase;
  late MockVerifyCodeUseCase mockVerifyCodeUseCase;

  setUp(() {
    mockForgetPasswordUseCase = MockForgetPasswordUseCase();
    mockResetPasswordUseCase = MockResetPasswordUseCase();
    mockVerifyCodeUseCase = MockVerifyCodeUseCase();
    cubit = ForgetPasswordCubit(
      forgetPasswordUseCase: mockForgetPasswordUseCase,
      resetPasswordUseCase: mockResetPasswordUseCase,
      verifyCodeUseCase: mockVerifyCodeUseCase,
    );
  });

  tearDown(() {
    cubit.close();
  });

  group('Email Validation & Send OTP', () {
    const validEmail = 'test@example.com';
    const invalidEmail = 'testexample.com';

    blocTest<ForgetPasswordCubit, ForgetPasswordStates>(
      'should update email and isEmailValid when EmailChangedIntent is added',
      build: () => cubit,
      act: (cubit) => cubit.doIntent(EmailChangedIntent(email: validEmail)),
      expect: () => [
        const ForgetPasswordStates(email: validEmail, isEmailValid: true),
      ],
    );

    blocTest<ForgetPasswordCubit, ForgetPasswordStates>(
      'should emit ShowErrorProvideEmailIntent if email is invalid on SendOtpIntent',
      build: () => cubit,
      act: (cubit) {
        cubit.doIntent(EmailChangedIntent(email: invalidEmail));
        cubit.doIntent(SendOtpIntent());
      },
      expect: () => [
        const ForgetPasswordStates(email: invalidEmail, isEmailValid: false),
      ],
      verify: (cubit) {
        expect(cubit.sideEffects, emits(isA<ShowError>()));
      },
    );

    blocTest<ForgetPasswordCubit, ForgetPasswordStates>(
      'should call usecase, update loading state and emit NavigateToVerifyCodeIntent on SendOtp success',
      build: () {
        when(
          mockForgetPasswordUseCase(any),
        ).thenAnswer((_) async => const BaseResponse.success(null));
        return cubit;
      },
      act: (cubit) {
        cubit.doIntent(EmailChangedIntent(email: validEmail));
        cubit.doIntent(SendOtpIntent());
      },
      expect: () => [
        const ForgetPasswordStates(email: validEmail, isEmailValid: true),
        const ForgetPasswordStates(
          email: validEmail,
          isEmailValid: true,
          isSendOtpLoading: true,
        ),
        const ForgetPasswordStates(
          email: validEmail,
          isEmailValid: true,
          isSendOtpLoading: false,
        ),
      ],
      verify: (cubit) {
        expect(
          cubit.sideEffects,
          emitsThrough(isA<NavigateToNextPageViewSideEffect>()),
        );
        verify(mockForgetPasswordUseCase(any)).called(1);
      },
    );
  });

  group('OTP Validation & Confirm', () {
    const validOtp = '123456';
    const invalidOtp = '12345';

    blocTest<ForgetPasswordCubit, ForgetPasswordStates>(
      'should update otpCode and isOtpCodeValid when OtpCodeChangedIntent is added',
      build: () => cubit,
      act: (cubit) => cubit.doIntent(OtpCodeChangedIntent(otpCode: validOtp)),
      expect: () => [
        const ForgetPasswordStates(otpCode: validOtp, isOtpCodeValid: true),
      ],
    );

    blocTest<ForgetPasswordCubit, ForgetPasswordStates>(
      'should emit ShowErrorVerifyCodeIntent if otp is invalid on ConfirmOtpCodeIntent',
      build: () => cubit,
      act: (cubit) {
        cubit.doIntent(OtpCodeChangedIntent(otpCode: invalidOtp));
        cubit.doIntent(ConfirmOtpCodeIntent());
      },
      expect: () => [
        const ForgetPasswordStates(otpCode: invalidOtp, isOtpCodeValid: false),
      ],
      verify: (cubit) {
        expect(cubit.sideEffects, emits(isA<ShowError>()));
      },
    );

    blocTest<ForgetPasswordCubit, ForgetPasswordStates>(
      'should call usecase, update loading state and emit NavigateToResetPasswordIntent on Verify success',
      build: () {
        when(
          mockVerifyCodeUseCase(any),
        ).thenAnswer((_) async => const BaseResponse.success(null));
        return cubit;
      },
      act: (cubit) {
        cubit.doIntent(OtpCodeChangedIntent(otpCode: validOtp));
        cubit.doIntent(ConfirmOtpCodeIntent());
      },
      expect: () => [
        const ForgetPasswordStates(otpCode: validOtp, isOtpCodeValid: true),
        const ForgetPasswordStates(
          otpCode: validOtp,
          isOtpCodeValid: true,
          isVerifyOtpLoading: true,
        ),
        const ForgetPasswordStates(
          otpCode: validOtp,
          isOtpCodeValid: true,
          isVerifyOtpLoading: false,
        ),
      ],
      verify: (cubit) {
        expect(
          cubit.sideEffects,
          emitsThrough(isA<NavigateToNextPageViewSideEffect>()),
        );
        verify(mockVerifyCodeUseCase(any)).called(1);
      },
    );
  });

  group('Reset Password', () {
    const password = 'Password@123';

    blocTest<ForgetPasswordCubit, ForgetPasswordStates>(
      'should update password states and validate form',
      build: () => cubit,
      act: (cubit) {
        cubit.doIntent(NewPasswordChangedIntent(newPassword: password));
        cubit.doIntent(
          ConfirmNewPasswordChangedIntent(confirmNewPassword: password),
        );
      },
      expect: () => [
        const ForgetPasswordStates(newPassword: password, isFormValid: false),
        const ForgetPasswordStates(
          newPassword: password,
          confirmNewPassword: password,
          isFormValid: true,
        ),
      ],
    );

    blocTest<ForgetPasswordCubit, ForgetPasswordStates>(
      'should call usecase, update loading state and emit NavigateToLoginIntent on ResetPassword success',
      build: () {
        when(
          mockResetPasswordUseCase(any),
        ).thenAnswer((_) async => const BaseResponse.success(null));
        return cubit;
      },
      act: (cubit) {
        cubit.doIntent(NewPasswordChangedIntent(newPassword: password));
        cubit.doIntent(
          ConfirmNewPasswordChangedIntent(confirmNewPassword: password),
        );
        cubit.doIntent(ResetPasswordIntent());
      },
      skip: 2,
      expect: () => [],
      verify: (cubit) {
        expect(cubit.sideEffects, emitsThrough(isA<ShowLoading>()));
        expect(cubit.sideEffects, emitsThrough(isA<HideLoading>()));
        expect(
          cubit.sideEffects,
          emitsThrough(isA<NavigateToLoginSideEffect>()),
        );
      },
    );
  });
}
