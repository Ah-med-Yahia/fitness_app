import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:fitness_app/core/routing/app_routes_constant.dart';
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/core/utils/ui_utils.dart';
import '../../view_model/login_cubit.dart';
import '../../view_model/login_intent.dart';
import '../../view_model/state/login_state.dart';
import '../widgets/login_background_layers.dart';
import '../widgets/login_form.dart';
import '../widgets/login_glass_card.dart';
import '../widgets/login_header.dart';
import 'package:fitness_app/core/constants/auth_constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.transparent,
      body: Stack(
        children: [const LoginBackgroundLayers(), _buildContent(context)],
      ),
    );
  }

  Widget _buildContent(BuildContext context) => SafeArea(
    child: SizedBox.expand(
      child: SingleChildScrollView(
        padding: AuthUiConstants.screenHorizontalPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 46),
            const LoginHeader(),
            const SizedBox(height: 8),
            _buildLoginCard(context),
            const SizedBox(height: 24),
          ],
        ),
      ),
    ),
  );

  Widget _buildLoginCard(BuildContext context) => LoginGlassCard(
    child: BlocConsumer<LoginCubit, LoginState>(
      listener: _onStateChanged,
      builder: (context, state) {
        final isLoading = state == const LoginState.loading();
        return LoginForm(
          formKey: _formKey,
          emailController: _emailController,
          passwordController: _passwordController,
          obscurePassword: _obscurePassword,
          onTogglePasswordVisibility: () =>
              setState(() => _obscurePassword = !_obscurePassword),
          isLoading: isLoading,
          onLoginPressed: () => _onLoginPressed(context),
        );
      },
    ),
  );

  void _onStateChanged(BuildContext context, LoginState state) {
    state.whenOrNull(
      loading: UIUtils.showEasyLoading,
      success: (_) {
        UIUtils.hideEasyLoading();
        context.go(AppRoutesConstants.foodCategoryRoute);
      },
      failure: (message) {
        UIUtils.hideEasyLoading();
        UIUtils.showMessage(
          message,
          backGroundColor: AppColors.red,
          textColor: AppColors.white,
        );
      },
    );
  }

  void _onLoginPressed(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<LoginCubit>().doIntent(
        UserLoginIntent(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        ),

      );
    }
  }
}
