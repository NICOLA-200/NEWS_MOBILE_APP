import 'package:flutter_application_1/models/category_model.dart';

List<CategoryModel> getCategories() {
  List<CategoryModel> allCategories = [];

  CategoryModel category = CategoryModel();
  category.categoryName = 'Business';
  category.image = 'images/business.jpg';

  allCategories.add(category);

  category = CategoryModel();
  category.categoryName = 'Entertainment';
  category.image = 'images/Entertainment.jpg';

  allCategories.add(category);

  category = CategoryModel();
  category.categoryName = 'General';
  category.image = 'images/general.jpg';

  allCategories.add(category);

  category = CategoryModel();
  category.categoryName = 'Health';
  category.image = 'images/health.jpg';

    category = CategoryModel();
  category.categoryName = 'Sports';
  category.image = 'images/sports.jpg';

  allCategories.add(category);

  return allCategories;
}
