import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../features/modules/result view/result_screen.dart';


double mediaQueryWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double mediaQueryHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

String? validateDate(TextEditingController fromController, String value) {
  TimeOfDay fromTime = parseTimeOfDay(fromController.text);
  TimeOfDay toTime = parseTimeOfDay(value);

  if (toTime.hour < fromTime.hour ||
      (toTime.hour == fromTime.hour && toTime.minute <= fromTime.minute)) {
    return 'Invalid time, must be after from time';
  }
  return null;
}

TimeOfDay parseTimeOfDay(String timeString) {
  final DateFormat format = DateFormat('h:mm a');
  final DateTime dateTime = format.parse(timeString);
  return TimeOfDay(hour: dateTime.hour, minute: dateTime.minute);
}

void navigate(BuildContext context, String name, List<Map> list) {
  Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => ResultScreen(
                name: name,
                targetList: list,
              )));
}

List<Color> categoryColor(String catName) {
  List<Color> colors = [
    const Color(0xffFF6E3C),
    const Color(0xffDD3900),
  ];
  if (catName == "Personal") {
    colors = [
      const Color(0xff477FB7),
      const Color(0xff204D7A),
    ];
    return colors;
  } else if (catName == "Learning") {
    colors = [
      const Color(0xffF5429E),
      const Color(0xff3434a9),
    ];
    return colors;
  } else if (catName == "Work") {
    colors = [
      const Color(0xff04B9A3),
      const Color(0xff007365),
    ];
    return colors;
  }
  return colors;
}

List<Color> priorityColor = [
  Colors.red,
  Colors.blue,
  Colors.green,
];

Color priorityColorPicker(String priority) {
  if (priority == "High") {
    return priorityColor[0];
  } else if (priority == "Low") {
    return priorityColor[2];
  }
  return priorityColor[1];
}

Map<String, int> priorityOrder = {
  'High': 3,
  'Mid': 2,
  'Low': 1,
};
List<Map> sortListByPriority(List<Map> testList) {

  try {
    testList.sort((a, b) =>
        priorityOrder[b['priority']]!.compareTo(priorityOrder[a['priority']]!));
  }catch (nullCheck)
  {
    if (kDebugMode) {
      print("");
    }
  }

  return testList;
}
