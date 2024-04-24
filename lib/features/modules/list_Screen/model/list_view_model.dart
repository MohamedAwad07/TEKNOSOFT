  import 'package:flutter/material.dart';

  class Model {
    late Icon icon;
    late String head;

    Model({
      required this.icon,
      required this.head,
    });
  }
  List<Model> modelList = [
    Model(
      icon: const Icon(
        Icons.sunny,
        color: Colors.indigo,
      ),
      head: 'My Day',
    ),
    Model(
      icon: const Icon(
        Icons.calendar_month_rounded,
        color: Colors.indigo,
      ),
      head: 'Upcoming',
    ),
    Model(
      icon: const Icon(
        Icons.star,
        color: Colors.indigo,
      ),
      head: 'Important',
    ),
  ];


  class Category {
    late List<Color> colors;
    late Icon icon;
    late String head;


    Category({
      required this.colors,
      required this.icon,
      required this.head,
    }) ;
  }

  List<Category> categoryList = [
    Category(
      colors: [
        const Color(0xff477FB7),
        const Color(0xff204D7A),
      ],
      icon: const Icon(
        Icons.person_outline,
        size: 30,
        color: Colors.white70,
      ),
      head: 'Personal',
    ),
    Category(
      colors: [
        const Color(0xffF5429E),
        const Color(0xff3434a9),
      ],
      icon: const Icon(
        Icons.edit_outlined,
        size: 30,
        color: Colors.white70,
      ),
      head: 'Learning',
    ),
    Category(
      colors: [
        const Color(0xff04B9A3),
        const Color(0xff007365),
      ],
      icon: const Icon(
        Icons.work_outline_outlined,
        size: 30,
        color: Colors.white70,
      ),
      head: 'Work',
    ),
    Category(
      colors: [
        const Color(0xffFF6E3C),
        const Color(0xffDD3900),
      ],
      icon: const Icon(
        Icons.shopping_bag_outlined,
        size: 30,
        color: Colors.white70,
      ),
      head: 'Shopping',
    ),
  ];

