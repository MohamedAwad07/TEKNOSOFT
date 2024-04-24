import 'package:flutter/material.dart';
import '../../../Home/widgets/categories_view.dart';
import '../../../Home/widgets/lists_view.dart';


class ViewBody extends StatelessWidget {
  const ViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsetsDirectional.only(
        top: 20,
        start: 15,
        bottom: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListsView(),
          CategoriesView(),
        ],
      ),
    );
  }
}




