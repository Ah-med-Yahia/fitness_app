import 'package:easy_localization/easy_localization.dart';
import 'package:fitness_app/feature/food_category/presentation/view/widget/meal_cart_item.dart';
import 'package:flutter/material.dart';
import '../../../../../core/request/query_request.dart';
import '../../../../../core/reusable_widgets/custom_error_widget.dart';
import '../../../../../core/reusable_widgets/loading_widget.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../view_model/categories_intent.dart';
import '../../view_model/categories_state.dart';
import '../../view_model/categories_view_model.dart';
import 'categories_item_widget.dart';

class CategoriesBodyWidget extends StatelessWidget {
  const CategoriesBodyWidget({
    super.key,
    required this.state,
    required this.categoriesViewModel,
  });

  final CategoriesState state;
  final CategoriesViewModel categoriesViewModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const SizedBox(height: 18),
          state.categoriesState.isLoading == true
              ? const LoadingWidget()
              : state.categoriesState.data != null
              ? state.categoriesState.data!.categoriesEntity!.isNotEmpty
                    ? DefaultTabController(
                        initialIndex: state.categoriesState.index,
                        length: state
                            .categoriesState
                            .data!
                            .categoriesEntity!
                            .length,
                        child: TabBar(
                          onTap: (value) {
                            categoriesViewModel.doIntent(
                              GetCategoryIntent(
                                DynamicQueries(
                                  queriesData: [
                                    QueryData(
                                      key: 'c',
                                      value:
                                          '${state.categoriesState.data?.categoriesEntity?[state.categoriesState.index].title}',
                                    ),
                                  ],
                                ),
                                index: value,
                              ),
                            );
                          },
                          padding: EdgeInsets.zero,
                          isScrollable: true,
                          tabAlignment: TabAlignment.start,
                          indicatorColor: AppColors.transparent,
                          dividerColor: Colors.transparent,
                          labelPadding: EdgeInsets.zero,
                          tabs: state.categoriesState.data!.categoriesEntity!
                              .map(
                                (e) => CategoriesItemWidget(
                                  itemName: e.title ?? '',
                                  isSelected:
                                      state.categoriesState.index ==
                                      state
                                          .categoriesState
                                          .data!
                                          .categoriesEntity!
                                          .indexOf(e),
                                ),
                              )
                              .toList(),
                        ),
                      )
                    : Container(
                        alignment: Alignment.centerLeft,
                        height: 48,
                        child: Text(
                          'noCategoriesAvailable'.tr(),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      )
              : state.categoriesState.error != null
              ? CustomErrorWidget(
                  errorMessage: state.categoriesState.error?.message ?? '',
                  onRetry: () {
                    categoriesViewModel.doIntent(
                      CategoriesAction(
                        DynamicQueries(
                          queriesData: [
                            QueryData(
                              key: 'c',
                              value:
                                  '${state.categoriesState.data?.categoriesEntity?[state.categoriesState.index].title}',
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )
              : Container(),
          const SizedBox(height: 8),
          state.mealsCategoryState.isLoading == true
              ? const LoadingWidget()
              : state.mealsCategoryState.data != null
              ? state.mealsCategoryState.data?.meals != null &&
                        state.mealsCategoryState.data!.meals!.isEmpty
                    ? SizedBox(
                        height: MediaQuery.sizeOf(context).height * .25,
                        child: const MealCartItem(meal: null),
                      )
                    : Expanded(
                        child: GridView.builder(
                          itemCount:
                              state.mealsCategoryState.data?.meals?.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                mainAxisSpacing: 14,
                                crossAxisSpacing: 14,
                                childAspectRatio: 0.82,
                                crossAxisCount: 2,
                              ),
                          itemBuilder: (context, index) {
                            return MealCartItem(
                              meal:
                                  state.mealsCategoryState.data!.meals![index],
                            );
                          },
                        ),
                      )
              : state.mealsCategoryState.error != null
              ? CustomErrorWidget(
                  errorMessage: state.mealsCategoryState.error?.message ?? '',

                  onRetry: () {
                    categoriesViewModel.doIntent(
                      GetProductsCategoryIntent(
                        DynamicQueries(
                          queriesData: [
                            QueryData(
                              key: 'c',
                              value:
                                  '${state.categoriesState.data?.categoriesEntity?[state.categoriesState.index].id}',
                            ),
                          ],
                        ),
                        // categoryId:
                        //     state
                        //         .categoriesState
                        //         .data
                        //         ?.categoriesEntity?[state.categoriesState.index]
                        //         .id ??
                        //     '',
                      ),
                    );
                  },
                )
              : Container(),
        ],
      ),
    );
  }
}
