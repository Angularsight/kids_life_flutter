import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kids_life_flutter/ui/main_page/particular_category/particular_category.dart';

class CategoriesCard extends StatelessWidget {
  final String? category;
  const CategoriesCard({Key? key, this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipOval(
            child: CircleAvatar(
                radius: 40,
                child: Container(
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                  image: NetworkImage(
                      'https://img.webmd.com/dtmcms/live/webmd/consumer_assets/site_images/articles/health_tools/best_foods_as_you_age_slideshow/1800ss_getty_rf_fiber_foods.jpg?resize=650px:*'),
                  fit: BoxFit.cover,
                ))))),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "$category",
            style: Theme.of(context).textTheme.headline2,
          ),
        )
      ],
    );
  }
}
