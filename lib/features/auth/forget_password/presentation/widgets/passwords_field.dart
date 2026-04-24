import 'package:fitness_app/core/constants/app_text_constants.dart';
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/core/validators/app_validators.dart';
import 'package:fitness_app/features/auth/forget_password/presentation/cubit/forget_password_cubit.dart';
import 'package:fitness_app/features/auth/forget_password/presentation/cubit/forget_password_intents.dart';
import 'package:fitness_app/features/auth/forget_password/presentation/cubit/forget_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PasswordsField extends StatefulWidget {
  const PasswordsField({
    super.key,
    required this.passwordController,
    required this.confirmPasswordController,
  });
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  @override
  State<PasswordsField> createState() => _PasswordsFieldState();
}

class _PasswordsFieldState extends State<PasswordsField> {
  late TextTheme textTheme;
  @override
  void didChangeDependencies() {
    textTheme = Theme.of(context).textTheme;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<ForgetPasswordCubit, ForgetPasswordStates>(
          buildWhen: (previous, current) =>
              previous.isObscurePassword != current.isObscurePassword,
          builder: (context, state) {
            return TextFormField(
              controller: widget.passwordController,
              obscureText: state.isObscurePassword,
              style: textTheme.bodyMedium?.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              onChanged: (value) {
                context.read<ForgetPasswordCubit>().doIntent(
                  NewPasswordChangedIntent(newPassword: value),
                );
              },
              validator: (value) => AppValidators.validatePassword(value),
              cursorColor: AppColors.white,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.lock_outline, size: 25),
                suffixIcon: GestureDetector(
                  onTap: () {
                    context.read<ForgetPasswordCubit>().doIntent(
                      ToggleObscurePasswordIntent(),
                    );
                  },
                  child: Icon(
                    state.isObscurePassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    size: 22,
                  ),
                ),
                hintText: AppTextConstants.newPassword,
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              onTapOutside: (event) {
                FocusScope.of(context).unfocus();
              },
            );
          },
        ),
        const SizedBox(height: 12),
        BlocBuilder<ForgetPasswordCubit, ForgetPasswordStates>(
          buildWhen: (previous, current) =>
              previous.isObscureConfirmPassword !=
              current.isObscureConfirmPassword,
          builder: (context, state) {
            return TextFormField(
              controller: widget.confirmPasswordController,
              obscureText: state.isObscureConfirmPassword,
              style: textTheme.bodyMedium?.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              onChanged: (value) {
                context.read<ForgetPasswordCubit>().doIntent(
                  ConfirmNewPasswordChangedIntent(confirmNewPassword: value),
                );
              },
              validator: (value) => AppValidators.validatePassword(value),
              cursorColor: AppColors.white,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.lock_outline, size: 25),
                suffixIcon: GestureDetector(
                  onTap: () {
                    context.read<ForgetPasswordCubit>().doIntent(
                      ToggleObscureConfirmPasswordIntent(),
                    );
                  },
                  child: Icon(
                    state.isObscureConfirmPassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: AppColors.white,
                    size: 22,
                  ),
                ),
                hintText: AppTextConstants.confirmPassword,
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              onTapOutside: (event) {
                FocusScope.of(context).unfocus();
              },
            );
          },
        ),
      ],
    );
  }
}
