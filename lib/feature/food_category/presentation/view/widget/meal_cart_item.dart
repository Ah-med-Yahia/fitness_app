import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness_app/core/routing/app_routes_constant.dart';
import 'package:fitness_app/feature/food/domain/models/meals_entity.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/theme/app_colors.dart';
class MealCartItem extends StatefulWidget {
  const MealCartItem({super.key, required this.meal});
  final Meal? meal;
  @override
  State<MealCartItem> createState() => _MealCartItemState();
}

class _MealCartItemState extends State<MealCartItem> {
  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: () {
        context.pushNamed(
          AppRoutesConstants.foodDetailsRoute,
          pathParameters: {
            'id':widget.meal?.idMeal??''
          },
        );
        //Navigator.pushNamed(context,AppRoutesConstants.foodDetailsRoute,arguments:widget.meal?.idMeal);
      },
      child:
      ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Image
            Image.network(
              widget.meal?.strMealThumb ?? '',
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                color: const Color(0xFF2A2A2A),
                child: const Icon(Icons.fastfood,
                    color: Color(0xFF444444), size: 48),
              ),
            ),
            // Gradient overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.75),
                  ],
                  stops: const [0.45, 1.0],
                ),
              ),
            ),
            // Title
            Positioned(
              bottom: 18,
              left: 12,
              right: 12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.meal?.strMeal ?? '',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      height: 1.3,
                    ),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),

    );


  }
}
