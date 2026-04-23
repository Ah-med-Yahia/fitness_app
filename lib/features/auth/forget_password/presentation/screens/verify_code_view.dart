import 'package:fitness_app/core/constants/app_text_constants.dart';
import 'package:fitness_app/core/shared/presentation/widgets/blurred_card.dart';
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/features/auth/forget_password/presentation/cubit/forget_password_cubit.dart';
import 'package:fitness_app/features/auth/forget_password/presentation/cubit/forget_password_intents.dart';
import 'package:fitness_app/features/auth/forget_password/presentation/cubit/forget_password_state.dart';
import 'package:fitness_app/features/auth/forget_password/presentation/widgets/otp_page_view_footer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';

class VerifyCodeView extends StatefulWidget {
  const VerifyCodeView({super.key});

  @override
  State<VerifyCodeView> createState() => _VerifyCodeViewState();
}

class _VerifyCodeViewState extends State<VerifyCodeView> {
  final TextEditingController _otpController = TextEditingController();
  late final TextTheme textTheme;
  late final Size screenSize;

  PinTheme _buildDefaultPinTheme(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return PinTheme(
      width: screenSize.width * .1,
      height: screenSize.width * .1,
      textStyle: textTheme.titleLarge?.copyWith(
        color: AppColors.primary,
        fontWeight: FontWeight.bold,
      ),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.white, width: 2)),
      ),
    );
  }

  PinTheme _buildFocusedPinTheme(BuildContext context) {
    return _buildDefaultPinTheme(context).copyWith(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.primary, width: 3)),
      ),
    );
  }

  PinTheme _buildSubmittedPinTheme(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return _buildDefaultPinTheme(context).copyWith(
      textStyle: textTheme.titleLarge?.copyWith(
        color: AppColors.primary,
        fontWeight: FontWeight.bold,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.primary.withValues(alpha: .8),
            width: 2,
          ),
        ),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    textTheme = Theme.of(context).textTheme;
    screenSize = MediaQuery.sizeOf(context);
  }

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppTextConstants.otpCode,
          style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          AppTextConstants.enterYourOtpCheckYourEmail,
          style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w300),
        ),
        const SizedBox(height: 20),
        BlurredCard(
          child: Column(
            children: [
              Pinput(
                controller: _otpController,
                length: 6,
                pinputAutovalidateMode: PinputAutovalidateMode.disabled,
                defaultPinTheme: _buildDefaultPinTheme(context),
                focusedPinTheme: _buildFocusedPinTheme(context),
                submittedPinTheme: _buildSubmittedPinTheme(context),
                onTapUpOutside: (_) {
                  FocusScope.of(context).unfocus();
                },
                cursor: Container(
                  width: 2,
                  height: 24,
                  color: AppColors.primary,
                ),
                onChanged: (value) {
                  context.read<ForgetPasswordCubit>().doIntent(
                    OtpCodeChangedIntent(otpCode: value),
                  );
                },
              ),

              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: screenSize.height * .06,
                child: BlocBuilder<ForgetPasswordCubit, ForgetPasswordStates>(
                  buildWhen: (previous, current) =>
                      previous.isVerifyOtpLoading !=
                          current.isVerifyOtpLoading ||
                      previous.isOtpCodeValid != current.isOtpCodeValid,
                  builder: (context, state) {
                    final isLoading = state.isVerifyOtpLoading;
                    final isOtpCodeValid = state.isOtpCodeValid;
                    return ElevatedButton(
                      onPressed: isOtpCodeValid
                          ? () {
                              context.read<ForgetPasswordCubit>().doIntent(
                                ConfirmOtpCodeIntent(),
                              );
                            }
                          : null,
                      child: isLoading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.5,
                                color: AppColors.white,
                              ),
                            )
                          : Text(
                              AppTextConstants.confirm,
                              style: textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              OtpPageViewFooter(
                email: context.read<ForgetPasswordCubit>().state.email,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
