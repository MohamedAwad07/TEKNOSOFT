import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:todo_app/shared/cubit/cubit.dart';
import 'package:todo_app/shared/observer.dart';
import 'features/Home/todoHome.dart';
import 'dart:io' show Platform;
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows) {
    databaseFactory = databaseFactoryFfi;
    sqfliteFfiInit();
  }
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
