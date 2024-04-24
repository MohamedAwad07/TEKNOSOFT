import 'package:flutter/material.dart';
import '../../../Helper functions/functions.dart';
import '../../../shared/components/components.dart';
import '../../../shared/cubit/cubit.dart';


class HomeBody extends StatelessWidget {
  const HomeBody({
    super.key,
    required this.cubit,
  });

  final AppCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white70, // Start color
            Color(
              0xFFD5D8DC,
            ), // End color
          ],
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.only(
              start: 10,
              end: 10,
            ),
            child: SizedBox(
              height: 160,
              child: cubit.dateShow(),
            ),
          ),
          SizedBox(
            width: mediaQueryWidth(context),
            height: mediaQueryHeight(context) * 0.65,
            child: noTasksBuilder(taskView: dates, isIgnoring: false),
          ),
        ],
      ),
    );
  }
}
