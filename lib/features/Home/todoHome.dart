import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/features/Home/widgets/floating_button.dart';
import 'package:todo_app/features/Home/widgets/home_body.dart';
import 'package:todo_app/features/modules/list_Screen/list_screen.dart';
import '../../Helper functions/functions.dart';
import '../../shared/components/components.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';



var scafKey = GlobalKey<ScaffoldState>();
var formKey = GlobalKey<FormState>();

var titleController = TextEditingController();
var fromController = TextEditingController();
var toController = TextEditingController();
var categoryController = TextEditingController();
var priorityController = TextEditingController();

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          if (state is AppInsertDatabase) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return SafeArea(
            child: Scaffold(
              key: scafKey,
              appBar: AppBar(
                backgroundColor: Colors.grey[100],
                title: const Align(
                  child: Text(
                    "Upcoming",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                ),
                leading: IconButton(
                  color: Colors.black45,
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_back_ios),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                      end: 15,
                    ),
                    child: Tooltip(
                      message: "Go to My Lists",
                      child: IconButton(
                        color: Colors.black45,
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ListsScreen()));
                          cubit.myDay(
                              DateFormat('yyyy-MM-dd').format(selectedDatee));
                          cubit.upComing(
                              DateFormat('yyyy-MM-dd').format(selectedDatee));
                          cubit.importantListT();
                          cubit.getCategories();
                          cubit.getPriority();

                        },
                        icon: const Icon(
                          Icons.format_list_bulleted,
                          color: Colors.lightBlue,
                        ),
                      ),
                    ),
                  ),
                ],
                elevation: 0.5,
              ),
              body: HomeBody(cubit: cubit),
              floatingActionButton: FloatingActionButton(
                tooltip: 'Add Task',
                onPressed: () {
                  if (isBottomSheet) {
                    if (formKey.currentState!.validate()) {
                      cubit.insertIntoDatabase(
                        title: titleController.text,
                        date: DateFormat('yyyy-MM-dd')
                            .format(selectedDatee)
                            .toString(),
                        from: fromController.text,
                        to: toController.text,
                        category: categoryController.text,
                        important: cubit.isImportant ? "Yes" : "No",
                        priority: priorityController.text,
                      );
                    }
                  } else {
                    titleController.text = "";
                    fromController.text = "";
                    toController.text = "";
                    categoryController.text = "";
                    priorityController.text = "";
                    scafKey.currentState
                        ?.showBottomSheet(
                          (context) => SingleChildScrollView(
                            // Wrap with SingleChildScrollView
                            child: Container(
                              color: Colors.white,
                              padding: const EdgeInsets.all(20.0),
                              child: Form(
                                key: formKey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    defaultTextForm(
                                      controller: titleController,
                                      keyBoardType: TextInputType.text,
                                      label: 'Task title',
                                      preIcon: Icons.title,
                                      validate: (value) {
                                        if (value!.isEmpty) {
                                          return 'Title must not be empty';
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(
                                      height: 15.0,
                                    ),
                                    defaultTextForm(
                                      controller: fromController,
                                      keyBoardType: TextInputType.datetime,
                                      label: 'From',
                                      onTap: () {
                                        showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now(),
                                        ).then((value) => {
                                              fromController.text = value!
                                                  .format(context)
                                                  .toString(),
                                            });
                                      },
                                      preIcon: Icons.watch_later_outlined,
                                      validate: (value) {
                                        if (value!.isEmpty) {
                                          return 'Time must not be empty';
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(
                                      height: 15.0,
                                    ),
                                    defaultTextForm(
                                      controller: toController,
                                      keyBoardType: TextInputType.datetime,
                                      label: 'To',
                                      onTap: () {
                                        showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now(),
                                        ).then((value) => {
                                              toController.text = value!
                                                  .format(context)
                                                  .toString(),
                                            });
                                      },
                                      preIcon: Icons.watch_later_outlined,
                                      validate: (value) {
                                        if (value!.isEmpty) {
                                          return 'Time must not be empty';
                                        } else {
                                          return validateDate(
                                              fromController, value.toString());
                                        }
                                      },
                                    ),
                                    const SizedBox(
                                      height: 15.0,
                                    ),
                                    defaultTextForm(
                                      controller: categoryController,
                                      keyBoardType: TextInputType.text,
                                      label: 'Task Category',
                                      preIcon: Icons.category_outlined,
                                      validate: (value) {
                                        if (value!.isEmpty) {
                                          return 'Category must not be empty';
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(
                                      height: 15.0,
                                    ),
                                    defaultTextForm(
                                      controller: priorityController,
                                      keyBoardType: TextInputType.datetime,
                                      label: 'Priority',
                                      preIcon: Icons.priority_high_outlined,
                                      validate: (value) {
                                        if (value!.isEmpty) {
                                          return 'priority must not be empty';
                                        }
                                        return null;
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          elevation: 50.0,
                        )
                        .closed
                        .then((value) => {
                              cubit.changeButtonSheetState(
                                isShow: false,
                                icon: Icons.add,
                              ),
                              cubit.searchForDates(
                                  DateFormat('yyyy-MM-dd').format(selectedDatee)),
                            });
                    cubit.changeButtonSheetState(
                      isShow: true,
                      icon: Icons.add,
                    );
                  }
                },
                backgroundColor: Colors.transparent,
                elevation: 0,
                foregroundColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const FloatingButton(),
              ),
            ),
          );
        },
      ),
    );
  }
}
