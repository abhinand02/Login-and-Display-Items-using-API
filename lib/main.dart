import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_and_home_page/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Application/Home/home_bloc.dart';
import 'login_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPref = await SharedPreferences.getInstance();
  final savedData = sharedPref.getString('saved_data');
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=> HomeBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: savedData != null ? const HomePage() : LoginPage(),
        theme: ThemeData(
          primarySwatch: Colors.grey,
        ),
      ),
    ),
  );  
}
