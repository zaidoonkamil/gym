import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sqflite/sqflite.dart';
import 'package:untitled1/core/cubit/states.dart';
import 'package:untitled1/core/widgets/snack_bar.dart';


class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);
  bool ready=false;


  Database? database;
  List<Map> newTasks = [];
  List<Map> newTasks2 = [];

  void createDatabase() {
    openDatabase(
      'azza.db',
      version: 1,
      onCreate: (database, version) {
        print('///////////////////////////// ');
        print('Database created');
        database.execute('''
        CREATE TABLE tabb (
          id INTEGER PRIMARY KEY,
          name TEXT,
          phone TEXT,
          subTime TEXT,
          subPrice TEXT,
          weight TEXT,
          image TEXT
        )
      ''').then((value) {
          print('///////////////////////////// ');
          print('Table created');
        }).catchError((error) {
          print('///////////////////////////// ');
          print('Error when creating table: $error');
        });
      },
      onOpen: (database) {
        print('///////////////////////////// ');
        print('Database opened');
      },
    ).then((value) {
      database = value;
      newTasks = getDataFromDatabase(database);
      emit(AppCreateDatabaseState());
    });
    ready=true;
  }

  List<Map<dynamic, dynamic>> getDataFromDatabase(database) {
    newTasks=[];
    newTasks2=[];
    emit(AppGetDatabaseLoadingState());
    database.rawQuery('SELECT * FROM tabb').then((value) {
      value.forEach((element) {
        String dateString = element["subTime"];
        List<String> dateParts = dateString.split("-");
        int year = int.parse(dateParts[0]);
        int month = int.parse(dateParts[1]);
        int day = int.parse(dateParts[2]);
        DateTime dateTime = DateTime(year, month, day);
        if (dateTime.isBefore(DateTime.now())) {
          newTasks2.add(element);
        }else{
          newTasks.add(element);
        }
      });
    });
    emit(AppGetDatabaseState());
    return newTasks;
  }

  List<Map> filterTasksByDateTime(List<Map> tasks) {
    final now = DateTime.now();
    return tasks.where((task) {
      final taskDateTime = task['dateTime'] as DateTime;
      return taskDateTime.isBefore(now);
    }).toList();
  }


  List<Map<dynamic, dynamic>> searchByName(String name) {
    List<Map<dynamic, dynamic>> results = [];
    for (var task in newTasks) {
      if (task['name'] == name) {
        results.add(task);
      }
    }
    newTasks.clear();
    newTasks.addAll(results);
    emitt();
    return newTasks;
  }
  List<Map<dynamic, dynamic>> searchByName2(String name) {
    List<Map<dynamic, dynamic>> results = [];
    for (var task in newTasks2) {
      if (task['name'] == name) {
        results.add(task);
      }
    }
    newTasks2.clear();
    newTasks2.addAll(results);
    emitt();
    return newTasks2;
  }

  emitt(){
    emit(emitNoThink());
  }
  Future<XFile?> pickImage() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    return image;
  }

  insertToDatabase({
    required BuildContext context,
    required String name,
    required String phone,
    required String subTime,
    required String subPrice,
    required String weight,
    required String imagePath,
  }) async {
    await database?.transaction((txn) {
      txn.rawInsert(
        'INSERT INTO tabb ( name , phone , subTime , subPrice , weight ,image ) VALUES("$name", "$phone", "$subTime", "$subPrice", "$weight", "$imagePath" )',
      ).then((value) {
        print('$value inserted successfully');
        emit(AppInsertDatabaseState());
        getDataFromDatabase(database);
      }).catchError((error) {
        showSnackBar(context, 'لم تتم عملية التخزين بنجاح قم بأعادة المحاولة', Colors.red);

        print('Error When Inserting New Record ${error.toString()}');
      });

      return Future.value();
    });
  }

  void updateData({
    required BuildContext context,
    required int id,
    required String name,
    required String phone,
    required String subTime,
    required String subPrice,
    required String weight,
    required String imagePath,
  }) async {
    final updateStatement = '''
    UPDATE tabb
    SET name = '$name',
        phone = '$phone',
        subTime = '$subTime',
        subPrice = '$subPrice',
        weight = '$weight',
        image = '$imagePath'
    WHERE id = $id
  ''';

    database?.transaction((txn) async {
      await txn.rawUpdate(updateStatement).then((value) {
        emit(AppUpdateDatabaseState());
        getDataFromDatabase(database);
      }).catchError((e) {
        showSnackBar(context, 'لم تتم عملية التخزين بنجاح قم بأعادة المحاولة', Colors.red);
        print('Error When Updating Record: ${e.toString()}');
      });
    });
  }



}
