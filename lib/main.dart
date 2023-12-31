// ignore_for_file: prefer_const_constructors, unnecessary_import

import 'package:be_aydi/cubit/cubit.dart';
import 'package:be_aydi/cubit/state.dart';
import 'package:be_aydi/modules/on_boarding_screen.dart';
import 'package:be_aydi/shared/bloc_observer.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'layouts/homepage.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MasryCubit()..insertDataFromJSON('product.json'),),
      ],
      child: BlocConsumer<MasryCubit,MasryStates>(
        listener: (context,state){},
        builder: (context,state){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: BeAydiMasria(),
          );
        },
      ),
    );
  }
}