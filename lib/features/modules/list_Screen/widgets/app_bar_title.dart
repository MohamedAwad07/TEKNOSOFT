import 'package:flutter/material.dart';
import '../../../../shared/cubit/cubit.dart';


class AppBarTitle extends StatelessWidget {
  const AppBarTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding:
          EdgeInsetsDirectional.only(start: 5, end: 10, bottom: 10),
          child: Text(
            "Lists",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
        ),
        Row(
          children: [
            const Icon(
              Icons.timelapse_rounded,
              color: Colors.blueAccent,
              size: 17,
            ),
            const SizedBox(
              width: 5,
            ),
            const Text(
              "Today's Progress",
              style: TextStyle(
                color: Colors.blueAccent,
                fontSize: 14,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(
              width: 7,
            ),
            Text(
              "$cnt tasks left",
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: 12,
              ),
            ),
          ],
        ),
      ],
    );
  }
}