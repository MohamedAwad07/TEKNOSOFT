import 'package:flutter/material.dart';
import '../../../../shared/cubit/cubit.dart';
import '../model/list_view_model.dart';

class ListWidget extends StatelessWidget {
   const ListWidget({
    super.key, required this.index, required this.modelList,
  });
  final int index;
  final List<Model> modelList;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 30,
        top: 20,
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.only(
            bottom: 10
        ),
        child: Row(
          children: [
            modelList[index].icon,
            const SizedBox(
              width: 15,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                    bottom: 10,
                  ),
                  child: Text(
                    modelList[index].head,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.indigo,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  '${manga[index]} tasks',
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}