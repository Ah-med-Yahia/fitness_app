import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/feature/food/data/models/meal/meal_details_response.dart';
import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class MealDetailsWidget extends StatefulWidget {
  const MealDetailsWidget({super.key, required this.meal});
  final MealDetailsResponse meal;
  //final MealState mealState;

  @override
  State<MealDetailsWidget> createState() => _MealDetailsWidgetState();
}

class _MealDetailsWidgetState extends State<MealDetailsWidget> {
  late final YoutubePlayerController _controller;
  @override
  void initState() {
    super.initState();
    final String videoId =
        YoutubePlayerController.convertUrlToId(
          widget.meal.meals?[0].strYoutube ?? '',
        ) ??
        '';
    _controller = YoutubePlayerController.fromVideoId(
      videoId: videoId, // The ID from the YouTube URL
      autoPlay: false,
      params: const YoutubePlayerParams(
        showControls: true,
        showFullscreenButton: true,
        origin: 'https://www.youtube-nocookie.com',
      ),
    );
    // _controller = YoutubePlayerController
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            // 2. Wrap the player in a YoutubePlayer widget
            child: YoutubePlayer(controller: _controller, aspectRatio: 16 / 9),
          ),
          const SizedBox(height: 24),
          Stack(
            alignment: AlignmentGeometry.bottomCenter,
            children: [
              Container(
                height: 500,
                width: double.infinity,
                decoration: BoxDecoration(
                  // color: const Color(0xFFE8ECF0),
                  //  borderRadius: BorderRadius.circular(24),
                  image: DecorationImage(
                    image: NetworkImage(
                      widget.meal.meals?[0].strMealThumb ?? '',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                color: AppColors.black.withValues(alpha: .7),
                padding: const EdgeInsets.all(4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.meal.meals?[0].strMeal ?? '',
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: AppColors.white,
                        letterSpacing: -0.3,
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Description
                    Text(
                      widget.meal.meals?[0].strInstructions ?? '',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: AppColors.white,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Ingredients Title
          Text('Ingredients'.tr()),
          const SizedBox(height: 16),

          // Ingredients List
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.black,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              children: fillIngredientsList().map((e) {
                return _buildIngredientRow(
                  e.strIngredient ?? '',
                  e.strQuantity ?? '',
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildNutritionCard(String value, String label, String unit) {
    return Column(
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: value,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1A1A1A),
                ),
              ),
              TextSpan(
                text: unit.isNotEmpty ? ' $unit' : '',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF999999),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Color(0xFF999999),
            letterSpacing: 0.3,
          ),
        ),
      ],
    );
  }

  Widget _buildIngredientRow(String name, String quantity) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(name),
              Text(
                quantity,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          const Divider(color: Colors.grey, thickness: .35),
        ],
      ),
    );
  }

  List<IngredientsMeal> fillIngredientsList() {
    final List<IngredientsMeal> ingredientsList = [];
    for (int i = 1; i <= 20; i++) {
      final String ingredientName = 'strIngredient$i';
      final String ingredientQuantity = 'strMeasure$i';
      final String? ingredient = widget.meal.meals?[0].toJson()[ingredientName];
      final String? quantity = widget.meal.meals?[0]
          .toJson()[ingredientQuantity];
      if (ingredient != null && ingredient.isNotEmpty) {
        ingredientsList.add(
          IngredientsMeal(strIngredient: ingredient, strQuantity: quantity),
        );
      }
    }
    return ingredientsList;
  }
}

class IngredientsMeal {
  String? strIngredient;
  String? strQuantity;
  IngredientsMeal({this.strIngredient, this.strQuantity});
}
