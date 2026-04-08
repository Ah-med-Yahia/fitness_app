import 'dart:ui';
import 'package:fitness_app/app/core/constants/auth_constants.dart';
import 'package:fitness_app/app/core/gen/assets.gen.dart';
import 'package:fitness_app/app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnboardingScaffold extends StatelessWidget {
  final String stepLabel;
  final double stepProgress;
  final String title;
  final String subtitle;
  final Widget cardContent;
  final String buttonLabel;
  final VoidCallback? onNext;
  final bool showBackButton;

  const OnboardingScaffold({
    super.key,
    required this.stepLabel,
    required this.stepProgress,
    required this.title,
    required this.subtitle,
    required this.cardContent,
    this.buttonLabel = AuthTextConstants.next,
    this.onNext,
    this.showBackButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.transparent,
      body: Stack(
        children: [
          Positioned.fill(
            child: Assets.images.authBackground.image(fit: BoxFit.cover),
          ),

          // ── Blur overlay ─────────────────────────
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 12.5, sigmaY: 12.5),
              child: Container(color: AppColors.authOverlay),
            ),
          ),
          SafeArea(
            child: Stack(
              children: [
                Column(
                  children: [
                    const SizedBox(height: 16),
                    Center(
                      child: Assets.images.logo.image(width: 70, height: 48),
                    ),
                    Expanded(
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          return SingleChildScrollView(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                minHeight: constraints.maxHeight,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(
                                    child: _StepIndicator(
                                      label: stepLabel,
                                      progress: stepProgress,
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                  Text(
                                    title,
                                    style: const TextStyle(
                                      fontFamily: 'BaloThambi2',
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800,
                                      color: AppColors.white,
                                      height: 1.4,
                                    ),
                                  ),
                                  if (subtitle.isNotEmpty) ...[
                                    const SizedBox(height: 4),
                                    Text(
                                      subtitle,
                                      style: const TextStyle(
                                        fontFamily: 'BaloThambi2',
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.white,
                                        height: 1.4,
                                      ),
                                    ),
                                  ],
                                  const SizedBox(height: 16),

                                  // ── Glassy card ──────────────────
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(
                                        sigmaX: 34.6,
                                        sigmaY: 34.6,
                                      ),
                                      child: Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.fromLTRB(
                                          16,
                                          24,
                                          16,
                                          24,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppColors.authGlassCard,
                                          borderRadius: BorderRadius.circular(
                                            50,
                                          ),
                                        ),
                                        child: Column(
                                          children: [
                                            cardContent,
                                            const SizedBox(height: 24),
                                            SizedBox(
                                              width: double.infinity,
                                              height: 38,
                                              child: ElevatedButton(
                                                onPressed: onNext,
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      onNext != null
                                                      ? AppColors.primary
                                                      : AppColors
                                                            .disabledButton,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          20,
                                                        ),
                                                  ),
                                                  elevation: 0,
                                                ),
                                                child: Text(
                                                  buttonLabel,
                                                  style: const TextStyle(
                                                    fontFamily: 'BaloThambi2',
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w800,
                                                    color: AppColors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                if (showBackButton)
                  Positioned(
                    top: 16,
                    left: 16,
                    child: GestureDetector(
                      onTap: () => context.pop(),
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.arrow_back_ios_new,
                            color: AppColors.white,
                            size: 10,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StepIndicator extends StatelessWidget {
  final String label;
  final double progress;

  const _StepIndicator({required this.label, required this.progress});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 44,
      height: 44,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircularProgressIndicator(
            value: progress,
            strokeWidth: 3,
            backgroundColor: AppColors.white.withValues(alpha: 0.3),
            valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
          ),
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'BaloThambi2',
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }
}
