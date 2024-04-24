import 'package:flutter/material.dart';
import '../../../../Helper functions/functions.dart';
import '../../../../shared/cubit/cubit.dart';
import '../model/list_view_model.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    super.key,
    required this.categoryList,
    required this.index,
  });

  final List<Category> categoryList;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(
        top : 20,
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.only(
          end: 12,
        ),
        child: Container(
          width: mediaQueryWidth(context) * 0.42,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              15,
            ),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: categoryList[index].colors,
            ),
          ),
          child: Padding(
            padding: const EdgeInsetsDirectional.only(
              start: 20,
              top: 10,
              bottom: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                    bottom: 10,
                  ),
                  child: categoryList[index].icon,
                ),
                Text(
                  categoryList[index].head,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white70,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                 "${categoryL[index]} Tasks",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[500],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}