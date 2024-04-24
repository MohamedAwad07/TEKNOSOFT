import 'package:flutter/cupertino.dart';
import '../../../Helper functions/functions.dart';
import '../../../shared/cubit/cubit.dart';
import '../../modules/list_Screen/model/list_view_model.dart';
import '../../modules/list_Screen/widgets/category_item.dart';



class CategoriesView extends StatelessWidget {
  const CategoriesView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: LimitedBox(
        maxHeight: 320,
        child: ListView.builder(
          itemCount: (categoryList.length / 2).ceil(),
          itemBuilder: (BuildContext context, int index) {
            return Row(
              children: [
                GestureDetector(
                  onTap: () {
                    if (index == 1) {
                      navigate(context, "Work", workList);
                    } else {
                      navigate(context, "Personal", personalList);
                    }
                  },
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: CategoryItem(
                      categoryList: categoryList,
                      index: index * 2,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                if ((index * 2 + 1) < categoryList.length)
                  GestureDetector(
                    onTap: () {
                      if (index == 1) {
                        navigate(context, "Shopping", shoppingList);
                      } else {
                        navigate(context, "Learning", learningList);
                      }
                    },
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: CategoryItem(
                        categoryList: categoryList,
                        index: index * 2 + 1,
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}