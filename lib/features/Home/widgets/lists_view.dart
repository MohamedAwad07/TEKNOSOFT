import 'package:flutter/material.dart';
import '../../../Helper functions/functions.dart';
import '../../../shared/cubit/cubit.dart';
import '../../modules/list_Screen/model/list_view_model.dart';
import '../../modules/list_Screen/widgets/list_view_item.dart';


class ListsView extends StatelessWidget {
  const ListsView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(
        end: 25,
      ),
      child: Container(
        width: mediaQueryWidth(context),
        height: mediaQueryHeight(context) * 0.35,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
            15,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: LimitedBox(
                maxHeight: 240,
                child: ListView.separated(
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      if (index == 0) {
                        navigate(context, "My Day", myDayList);
                      } else if (index == 1) {
                        navigate(context, "Upcoming", upcomingList);
                      } else {
                        navigate(context, "Important", importantList);
                      }
                    },
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: ListWidget(
                        index: index,
                        modelList: modelList,
                      ),
                    ),
                  ),
                  separatorBuilder: (context, index) => Center(
                    child: Container(
                      width: mediaQueryWidth(context) * 0.72,
                      height: 1,
                      color: Colors.indigo,
                    ),
                  ),
                  itemCount: 3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}