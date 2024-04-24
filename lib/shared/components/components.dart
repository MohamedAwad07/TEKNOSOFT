import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../Helper functions/functions.dart';
import '../../features/Home/todoHome.dart';
import '../cubit/cubit.dart';

Widget defaultTextForm({
  required TextEditingController controller,
  required String label,
  required IconData preIcon,
  required String? Function(String? value) validate,
  Function(String value)? onChange,
  Function(String value)? onSubmit,
  void Function()? onTap,
  required TextInputType keyBoardType,
  void Function()? obscure,
  bool isPassword = false,
  IconData? sufIcon,
}) =>
    TextFormField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        prefixIcon: Icon(
          preIcon,
        ),
        suffixIcon: sufIcon != null
            ? IconButton(
                onPressed: obscure,
                icon: Icon(
                  sufIcon,
                ))
            : null,
      ),
      validator: validate,
      keyboardType: keyBoardType,
      onChanged: onChange,
      onFieldSubmitted: onSubmit,
      onTap: onTap,
    );

Widget buildTaskItem(Map model, context, bool isIgnoring) => IgnorePointer(
      ignoring: isIgnoring,
      child: Dismissible(
        key: Key(model['id'].toString()),
        background: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Align(
            alignment: Alignment.centerLeft,
              child: Icon(
            Icons.delete,
            color: Colors.red,
            size: 45,
          )),
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional.only(
            start: 15,
            end: 15,
            top: 10,
          ),
          child: Container(
            alignment: Alignment.center,
            width: mediaQueryWidth(context) * 0.92,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                15,
              ),
              color: Colors.white,
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                    bottom: 5,
                  ),
                  child: IconButton(
                    onPressed: () {
                      AppCubit.get(context).updateData(
                          value: "Done",
                          id: model['id'],
                          colToUpdate: 'status');
                    },
                    icon: Tooltip(
                      message: "Add to done Tasks",
                      child: Icon(
                        model['status'] == "Done"
                            ? Icons.sentiment_very_satisfied_sharp
                            : Icons.sentiment_dissatisfied,
                        size: 28,
                        color: model['status'] == "Done"
                            ? Colors.lightBlueAccent
                            : Colors.indigo,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 25,
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                    top: 5,
                    bottom: 5,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${model['title']}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        '${model['date']}',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${model['fromTime']}',
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 13,
                            ),
                          ),
                          Text(
                            ' - ',
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 13,
                            ),
                          ),
                          Text(
                            '${model['toTime']}',
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 12,
                            width: 12,
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: categoryColor(model['category']),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            '${model['category']}',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                    end: 10,
                    top: 3,
                  ),
                  child: Tooltip(
                    message: "Priority ${model['priority']}",
                    child: Container(
                      height: 12,
                      width: 12,
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        color: priorityColorPicker(model['priority']),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                    end: 5,
                    top: 2,
                  ),
                  child: Tooltip(
                    message: "Edit",
                    child: IgnorePointer(
                      ignoring: isIgnoring,
                      child: IconButton(
                        onPressed: () {
                          titleController.text = model['title'];
                          fromController.text = model['fromTime'];
                          toController.text = model['toTime'];
                          categoryController.text = model['category'];
                          priorityController.text = model['priority'];

                          if (isBottomSheet) {
                            if (formKey.currentState!.validate()) {}
                          } else {
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
                                              keyBoardType:
                                                  TextInputType.datetime,
                                              label: 'From',
                                              onTap: () {
                                                showTimePicker(
                                                  context: context,
                                                  initialTime: TimeOfDay.now(),
                                                ).then((value) => {
                                                      fromController.text =
                                                          value!
                                                              .format(context)
                                                              .toString(),
                                                    });
                                              },
                                              preIcon:
                                                  Icons.watch_later_outlined,
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
                                              keyBoardType:
                                                  TextInputType.datetime,
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
                                              preIcon:
                                                  Icons.watch_later_outlined,
                                              validate: (value) {
                                                if (value!.isEmpty) {
                                                  return 'Time must not be empty';
                                                } else {
                                                  return validateDate(
                                                      fromController,
                                                      value.toString());
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
                                              preIcon: Icons.title,
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
                                              keyBoardType:
                                                  TextInputType.datetime,
                                              label: 'Priority',
                                              preIcon:
                                                  Icons.priority_high_outlined,
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
                                      AppCubit.get(context)
                                          .changeButtonSheetState(
                                        isShow: false,
                                        icon: Icons.add,
                                      ),
                                      AppCubit.get(context).searchForDates(
                                          DateFormat('yyyy-MM-dd')
                                              .format(selectedDatee)),
                                      AppCubit.get(context)
                                          .deleteData(id: model['id']),
                                    });

                            AppCubit.get(context).changeButtonSheetState(
                              isShow: true,
                              icon: Icons.edit,
                            );
                          }
                        },
                        icon: const Icon(
                          Icons.edit_note_sharp,
                          size: 25,
                          color: Colors.teal,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                    end: 5,
                  ),
                  child: Tooltip(
                    message: "Make important",
                    child: IgnorePointer(
                      ignoring: isIgnoring,
                      child: IconButton(
                        onPressed: () {
                          AppCubit.get(context).isImportantChange();

                          AppCubit.get(context).isImportant
                              ? AppCubit.get(context).updateData(
                                  colToUpdate: 'important',
                                  value: "Yes",
                                  id: model['id'],
                                )
                              : AppCubit.get(context).updateData(
                                  colToUpdate: 'important',
                                  value: "No",
                                  id: model['id'],
                                );
                        },
                        icon: Icon(
                          model['important'] == "Yes"
                              ? Icons.star
                              : Icons.star_border_sharp,
                          size: 25,
                          color: Colors.teal,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        onDismissed: (direction) {
          AppCubit.get(context).deleteData(
            id: model['id'],
          );
        },
      ),
    );

Widget noTasksBuilder({
  required List<Map> taskView,
  required bool isIgnoring,
}) =>
    ConditionalBuilder(
      condition: taskView.isNotEmpty,
      builder: (context) => ListView.separated(
        itemBuilder: (context, index) =>
            buildTaskItem(taskView[index], context, isIgnoring),
        separatorBuilder: (context, index) => Container(),
        itemCount: taskView.length,
      ),
      fallback: (context) => const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.menu,
              color: Colors.grey,
              size: 60.0,
            ),
            Text(
              'No Tasks yet , Please add some Tasks',
              style: TextStyle(
                color: Colors.black45,
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 70.0,
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                'You can remove a task by dragging it to the left or right',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black45,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
      ),
    );
