import 'package:fitness_app/feature/food/data/models/meal/meal_details_response.dart';
import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';

class MealDetailsWidget extends StatelessWidget {
  const MealDetailsWidget({super.key,required this.meal});
final MealDetailsResponse meal;
  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Back button and header area
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new, size: 20),
                onPressed: () {},
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(
                  minWidth: 40,
                  minHeight: 40,
                ),
              ),
            ),
            const Spacer(),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: IconButton(
                icon: const Icon(Icons.favorite_border, size: 22),
                onPressed: () {},
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(
                  minWidth: 40,
                  minHeight: 40,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),

        // Recipe Image placeholder
        Container(
          height: 220,
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFFE8ECF0),
            borderRadius: BorderRadius.circular(24),
            image: DecorationImage(
              image: NetworkImage(
                meal.meals?[0].strMealThumb??'',
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 24),

        // Title
         Text(
          meal.meals?[0].strMeal??'',
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
         meal.meals?[0].strInstructions??'',
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: AppColors.white,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 24),

        // Nutrition Row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildNutritionCard('100', 'K Energy', 'kcal'),
            _buildNutritionCard('15', 'G Protein', 'g'),
            _buildNutritionCard('58', 'G Carbs', 'g'),
            _buildNutritionCard('20', 'G Fat', 'g'),
          ],
        ),
        const SizedBox(height: 32),

        // Ingredients Title
        const Text(
          'Ingredients',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1A1A1A),
          ),
        ),
        const SizedBox(height: 16),

        // Ingredients List
        Column(
          children: [
            _buildIngredientRow('Meal Breasts', '250g'),
            const Divider(height: 1, thickness: 1, color: Color(0xFFF0F0F0)),
            _buildIngredientRow('Unsalted Butter', '1tbsp'),
            const Divider(height: 1, thickness: 1, color: Color(0xFFF0F0F0)),
            _buildIngredientRow('Sesame Or Vegetable Oil', '2 Tsp'),
            const Divider(height: 1, thickness: 1, color: Color(0xFFF0F0F0)),
            _buildIngredientRow('Fresh Ginger', '2 Tsp'),
            const Divider(height: 1, thickness: 1, color: Color(0xFFF0F0F0)),
            _buildIngredientRow('Large Eggs', '100 G'),
            const Divider(height: 1, thickness: 1, color: Color(0xFFF0F0F0)),
            _buildIngredientRow('Large Eggs', '100 G'),
            const Divider(height: 1, thickness: 1, color: Color(0xFFF0F0F0)),
            _buildIngredientRow('Large Eggs', '100 G'),
            const Divider(height: 1, thickness: 1, color: Color(0xFFF0F0F0)),
            _buildIngredientRow('Large eggs', '100 G'),
            const Divider(height: 1, thickness: 1, color: Color(0xFFF0F0F0)),
            _buildIngredientRow('Large Eggs', '100 G'),
            const Divider(height: 1, thickness: 1, color: Color(0xFFF0F0F0)),
            _buildIngredientRow('Large Eggs', '100 g'),
          ],
        ),
        const SizedBox(height: 40),

        // Start Cooking Button
        SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1A1A1A),
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.3,
              ),
            ),
            child: const Text('Start Cooking'),
          ),
        ),
      ],
    );
  }

  Widget _buildNutritionCard(String value, String label, String unit) {
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xFF333333),
            ),
          ),
          Text(
            quantity,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Color(0xFF888888),
            ),
          ),
        ],
      ),
    );
  }
}