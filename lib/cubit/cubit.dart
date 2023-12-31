// ignore_for_file: avoid_print, non_constant_identifier_names

import 'dart:convert';
import 'dart:ffi';

import 'package:be_aydi/cubit/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';

class MasryCubit extends Cubit<MasryStates> {
  MasryCubit() : super(MasryInitialState());
  static MasryCubit get(context) => BlocProvider.of(context);
  Map<String, Map<String, dynamic>> Products = {};

  Future<void> insertDataFromJSON(String jsonFileName) async {
    // Read the JSON file
    final jsonFile = await rootBundle.loadString('assets/files/$jsonFileName');
    final jsonData = json.decode(jsonFile);

    try {
      // Clear existing data
      Products.clear();

      for (final product in jsonData) {
        final barcode = product['barcode'] as String;
        final name = product['name'] as String;
        final description = product['description'] as String;
        final rate = product['rate'] as double;

        // Populate the Products map
        Products[barcode] = {'barcode': barcode, 'name': name, 'description': description, 'rate': rate};
      }

      emit(MasryInsertFromJsonSuccessState());
      print(Products.length);
    } catch (error) {
      print('Error during JSON insertion: $error');
      emit(MasryInsertFromJsonErrorState());
    }
  }

}


//
// // ignore_for_file: avoid_print, non_constant_identifier_names
//
// import 'dart:convert';
//
// import 'package:be_aydi_masria/cubit/state.dart';
// import 'package:be_aydi_masria/layouts/homepage.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:sqflite/sqflite.dart';
//
// class MasryCubit extends Cubit<MasryStates> {
//   MasryCubit() : super(MasryInitialState());
//   static MasryCubit get(context) => BlocProvider.of(context);
//   late Database db;
//   Map<String, Map<String, dynamic>> Products = {};
//
//   Future<void> insertDataFromJSON(String jsonFileName) async {
//     // Read the JSON file
//     final jsonFile = await rootBundle.loadString('assets/files/$jsonFileName');
//     final jsonData = json.decode(jsonFile);
//     print(jsonData);
//     await db.transaction((txn) async {
//       for (final product in jsonData) {
//         final barcode = product['barcode'] as String;
//         final name = product['name'] as String;
//
//         await txn
//             .rawInsert(
//           'INSERT INTO products (barcode, name) VALUES ("$barcode","$name")',
//         )
//             .then((value) {
//           print("success");
//           emit(MasryInsertFromJsonSuccessState());
//           GetProduct(db);
//         }).catchError((error) {
//           print("error");
//           emit(MasryInsertFromJsonErrorState());
//         });
//       }
//     });
//   }
//
//   Future<void> createdatabase() async {
//     // barcode String
//     // name String
//     await openDatabase(
//       'masry.dp',
//       version: 2,
//       onCreate: (db, version) {
//         print('Database Created!');
//         db
//             .execute(
//             'CREATE TABLE products (barcode TEXT PRIMARY KEY, name TEXT)')
//             .then((value) {
//           print('Table Created!');
//         }).catchError((onError) {
//           print('error when created table ${onError.toString()}');
//         });
//       },
//       onOpen: (db) {
//         GetProduct(db);
//         print('Database Opened!');
//       },
//     ).then((value) {
//       db = value;
//       emit(MasryCreateDatabaseState());
//     });
//   }
//
//   Future InsertToDatabase({
//     required String barcode,
//     required String name,
//   }) async {
//     return await db.transaction((txn) async {
//       txn
//           .rawInsert(
//           'INSERT INTO products (barcode,name) VALUES ("$barcode","$name")')
//           .then((value) {
//         print('$value insert successfully!');
//         ShowToastMessage(
//             message: "Added Successfully", state: ToastStates.SUCCESS);
//         GetProduct(db);
//         emit(MasryInsertDatabaseState());
//       }).catchError((error) {
//         ShowToastMessage(message: "Added Failed", state: ToastStates.ERROR);
//         print('error when insert raw ${error.toString()}');
//       });
//     });
//   }
//
//   void GetProduct(db) {
//     Products = {};
//     emit(MasryGetDatabaseLoadingState());
//     db.rawQuery('SELECT * FROM products').then((value) {
//       value.forEach((element) {
//         Products[element["barcode"]] = element;
//       });
//       // print(Products);
//       emit(MasryGetDatabaseState());
//     });
//   }
//
//   void UpdateDatabase({
//     required String name,
//     required String barcode,
//   }) async {
//     db
//         .rawUpdate('UPDATE products SET name = ? WHERE barcode = ?',
//         ['$name', barcode])
//         .then((value) {})
//         .then((value) {
//       ShowToastMessage(
//           message: "Updated Successfully", state: ToastStates.SUCCESS);
//       GetProduct(db);
//       emit(MasryUpdateDatabaseState());
//     })
//         .catchError((error) {
//       ShowToastMessage(message: "Updated Failed", state: ToastStates.ERROR);
//     });
//   }
//
//   void DeleteDatabase({
//     required String barcode,
//   }) async {
//     // db.rawDelete("DELETE FROM products").then((value){
//     //   GetProduct(db);
//     //   emit(MasryDeleteDatabaseState());
//     // }).catchError((error){
//     // });
//     db
//         .rawDelete('DELETE FROM products WHERE barcode = ?', [barcode])
//         .then((value) {})
//         .then((value) {
//       ShowToastMessage(
//           message: "Deleted Successfully", state: ToastStates.SUCCESS);
//       GetProduct(db);
//       emit(MasryDeleteDatabaseState());
//     })
//         .catchError((error) {
//       ShowToastMessage(message: "Deleted Failed", state: ToastStates.ERROR);
//     });
//   }
// }
