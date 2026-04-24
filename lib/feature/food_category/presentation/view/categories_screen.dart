import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/feature/food_category/presentation/view/widget/categories_body_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/di/di.dart';

import '../../../../core/request/query_request.dart';
import '../view_model/categories_intent.dart';
import '../view_model/categories_state.dart';
import '../view_model/categories_view_model.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final CategoriesViewModel categoriesViewModel = getIt<CategoriesViewModel>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesViewModel, CategoriesState>(
      bloc: categoriesViewModel
        ..doIntent(
          CategoriesAction(
            DynamicQueries(
              queriesData: [
                QueryData(
                  key: 'c',
                  value:
                      '${categoriesViewModel.state.categoriesState.data?.categoriesEntity?[0].title}',
                ),
              ],
            ),
          ),
        ),
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              backgroundColor: Colors.black,
              leading: const Icon(
                Icons.keyboard_arrow_left,
                color: AppColors.primary,
              ),
              title: Text('foodRecommendation'.tr()),
            ),

            body: CategoriesBodyWidget(
              state: state,
              categoriesViewModel: categoriesViewModel,
            ),
          ),
        );
      },
    );
  }
}
