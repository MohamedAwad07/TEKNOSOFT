import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/shared/cubit/states.dart';
import '../../Helper functions/functions.dart';


List<Map> personalList = [];
List<Map> learningList = [];
List<Map> workList = [];
List<Map> shoppingList = [];
DateTime selectedDatee = DateTime.now();
bool isBottomSheet = false;
int cnt = 0;
IconData iconFloating = Icons.add;
List<Map> newTasks = [];
List<Map> doneTasks = [];
List<Map> dates = [];
List<Map> myDayList = [];
List<Map> upcomingList = [];
List<Map> importantList = [];
List<Map> priorityList = [];
List<int> categoryL = [1 , 1 , 1 , 1];
List<int> manga = [1 , 1 , 1];
bool isUpdate = false;
late Database database;

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialStates());

  static AppCubit get(context) => BlocProvider.of(context);

  //variables
  bool isImportant = false;


  void changeButtonSheetState({
    required bool isShow,
    required IconData icon,
  }) {
    isBottomSheet = isShow;
    iconFloating = icon;
    emit(AppChangeButtonState());
  }

  void isImportantChange() {
    isImportant = !isImportant;
    emit(AppIsImportantState());
  }

  void createDatabase() {
    openDatabase(
      'TodoApplication1.db',
      version: 1,
      onCreate: (database, version) {
        debugPrint('Database created');
        database
            .execute(
            'CREATE TABLE tasks (id INTEGER PRIMARY KEY , title TEXT , date TEXT , fromTime TEXT , toTime TEXT , category TEXT , important TEXT , priority TEXT , status TEXT)')
            .then((value) {
          debugPrint('table created');
        }).catchError((error) {
          debugPrint('Error is ${error.toString()}');
        });
      },
      onOpen: (database) {
       //getDataFromDatabase(database);
       getData(database);
        debugPrint('Database opened');
      },
    ).then((value) {
      database = value;
      emit(AppCreateDatabase());
    });
  }

  insertIntoDatabase({
    required String title,
    required String date,
    required String from,
    required String to,
    required String category,
    required String important,
    required String priority,
  }) async {
    await database.transaction((txn) {
      txn
          .rawInsert(
          'INSERT INTO tasks (title , date , fromTime , toTime , category, important , priority , status) VALUES ("$title" , "$date" ,"$from" , "$to" , "$category" , "$important" , "$priority" , "New" )')
          .then((value) {
        debugPrint('$value inserted successfully');
        cnt++;
        myDay(DateFormat('yyyy-MM-dd').format(selectedDatee));
        upComing(DateFormat('yyyy-MM-dd').format(selectedDatee));
        getDataFromDatabase(database);
        isImportant = false;
        emit(AppInsertDatabase());
      }).catchError((error) {
        debugPrint('Error when inserted is ${error.toString()}');
      });
      return Future.value(42);
    });
  }

  Future<void> getDataFromDatabase(database) async {
    newTasks = [];
    doneTasks = [];
    importantList = [];
    priorityList = [];
    await database.rawQuery('SELECT * FROM tasks').then((value) {
      value.forEach((element) {
        if (element['status'] == 'New') {
          newTasks.add(element);

        } else if (element['status'] == 'Done') {
          doneTasks.add(element);
        }});

      emit(AppGetDatabase());
    });
  }

  Future<void> getData(database) async {
    personalList = [];
    learningList = [];
    workList = [];
    shoppingList = [];
    doneTasks = [];
    importantList = [];
    dates = [];
    cnt = 0;
    priorityList = [];
    myDayList = [];
    upcomingList = [];
    await database.rawQuery('SELECT * FROM tasks').then((value) {
      String sui = DateFormat('yyyy-MM-dd').format(selectedDatee);

      value.forEach((element) {
        DateTime firstDate = DateTime.parse(element['date']);

        if (element['status'] == 'New' && element['date'] == sui) {
          dates.add(element);
          cnt++;
        } else if (element['status'] == 'Done') {
          doneTasks.add(element);
        } else if (element['date'] == sui) {
          myDayList.add(element);
        } else if (firstDate.isAfter(selectedDatee)) {
          upcomingList.add(element);
        }
        else if (element['important'] == "Yes") {
          importantList.add(element);
        }
        else if (element['category'] == "Personal") {
          personalList.add(element);
        }
        else if (element['category'] == "Learning") {
          learningList.add(element);
        }
        else if (element['category'] == "Work") {
          workList.add(element);
        }
        else if(element['category'] == "Shopping"){
          shoppingList.add(element);
        }
      });

      manga[0] = myDayList.length;
      manga[1] = upcomingList.length;
      manga[2] = importantList.length;
      categoryL[0] = personalList.length;
      categoryL[1] = learningList.length;
      categoryL[2] = workList.length;
      categoryL[3] = shoppingList.length;

      emit(AppGetDataState());
    });
  }

  Future<void> updateData({
    required String colToUpdate,
    required String value,
    required int id,
  }) async {
    await database.rawUpdate(
      'UPDATE tasks SET "$colToUpdate" = ? WHERE id = ?',
      [value, id],
    ).then((value) {
      //getDataFromDatabase(database);
      getData(database);
      emit(AppUpdateDatabase());
    });
  }

  Future<void> deleteData({
    required int id,
  }) async {
    await database.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      if (kDebugMode) {
        print("Deleted Successfully");
      }
      getDataFromDatabase(database);
      getData(database);
    });
  }


  Future<void> searchForDates(String selectedDate) async {
    dates = [];
    await database.rawQuery('SELECT * FROM tasks WHERE date = ? AND status = ?',
        [selectedDate, "New"]).then((value) {
      for (var element in value) {
        dates.add(element);
      }
      cnt = dates.length;
     emit(AppSearchForDatesState());
    });
  }

  EasyDateTimeLine dateShow() {
    return EasyDateTimeLine(
      dayProps: EasyDayProps(
        inactiveDayStyle: DayStyle(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(18)),
            border: Border.all(
              color: const Color(0xff3371FF),
              width: 0.3, // Adjust border width if needed
            ),
          ),
        ),
        dayStructure: DayStructure.dayStrDayNum,
        width: 55,
        height: 90,
        activeDayStyle: const DayStyle(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(18)),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xff3371FF),
                Color(0xff8426D6),
              ],
            ),
          ),
        ),
      ),
      initialDate: selectedDatee,
      onDateChange: (selectedDate) {
        String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
        selectedDatee = selectedDate;
        searchForDates(formattedDate);
        //emit(AppGetDatesState());
      },
    );
  }

  Future<void> myDay(String selectedDate) async {
    myDayList = [];
    await database.rawQuery(
        'SELECT * FROM tasks WHERE date = ?', [selectedDate]).then((value) {
      for (var element in value) {
        myDayList.add(element);
      }
      manga[0] = myDayList.length;
      //emit(AppMyDayState());
    });
  }

  Future<void>  upComing(String selectedDate) async {
    upcomingList = [];
    await database.rawQuery('SELECT * FROM tasks WHERE date > ? AND status = ?',
        [selectedDate, "New"]).then((value) {
      for (var element in value) {
        upcomingList.add(element);
      }
      manga[1] = upcomingList.length;
    });
  }

  Future<void>  importantListT() async {
    importantList = [];
    await database.rawQuery('SELECT * FROM tasks WHERE important = ?',
        ["Yes"]).then((value) {
      for (var element in value) {
        importantList.add(element);
      }
      manga[2] = importantList.length;
    });
  }

  Future<void> getCategories() async {
    personalList = [];
    learningList = [];
    workList = [];
    shoppingList = [];
    await database.rawQuery('SELECT * FROM tasks',
    ).then((value) {
      for (var element in value) {
        if (element['category'] == "Personal") {
          personalList.add(element);
        }
        else if (element['category'] == "Learning") {
          learningList.add(element);
        }
        else if (element['category'] == "Work") {
          workList.add(element);
        }
        else {
          shoppingList.add(element);
        }
      }

      categoryL[0] = personalList.length;
      categoryL[1] = learningList.length;
      categoryL[2] = workList.length;
      categoryL[3] = shoppingList.length;

    });
  }

  Future<void> getPriority()async {
    priorityList = [];
    await database.rawQuery('SELECT * FROM tasks').then((value) {
      value.forEach((element) {
        if(element['priority'] != "Manga" && element['status'] == "New")
        {
          priorityList.add(element);
        }
      });
      priorityList = sortListByPriority(priorityList);
     // emit(AppGetPriorityState());
    });
  }
}