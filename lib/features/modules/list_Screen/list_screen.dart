import 'package:flutter/material.dart';
import 'package:todo_app/features/modules/list_Screen/widgets/app_bar_title.dart';
import 'package:todo_app/features/modules/list_Screen/widgets/view_body.dart';
import '../../../Helper functions/functions.dart';
import '../../../shared/cubit/cubit.dart';
import '../../Home/todoHome.dart';
import '../../Home/widgets/floating_button.dart';

var scaffoldKey = GlobalKey<ScaffoldState>();

class ListsScreen extends StatelessWidget {
  const ListsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffF2F4F4),
        key: scaffoldKey,
        appBar: AppBar(
          toolbarHeight: 100,
          backgroundColor: const Color(0xffF2F4F4),
          title: const AppBarTitle(),
          actions: [
            Padding(
              padding: const EdgeInsetsDirectional.only(
                end: 10,
                bottom: 20,
              ),
              child: Tooltip(
                message: "Filter Tasks",
                child: IconButton(
                  color: Colors.black45,
                  onPressed: () {
                    navigate(context , "Filter Tasks" , priorityList);
                  },
                  icon: const Icon(
                    Icons.filter_list,
                    size: 30,
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsetsDirectional.only(
                end: 20,
                bottom: 20,
              ),
              child: SizedBox(
                width: 35, // Set the desired width
                height: 35, // Set the desired height
                child: CircleAvatar(
                  radius: 25, // Set the radius to half of the desired size
                  backgroundImage: AssetImage(
                    "assets/images/avatar.jpg",
                  ),
                ),
              ),
            )
          ],
          elevation: 0.5,
        ),
        body: const ViewBody(),
        floatingActionButton: FloatingActionButton(
          tooltip: 'Add Task',
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const HomeScreen()));
          },
          child: const FloatingButton(),
        ),
      ),
    );
  }
}



