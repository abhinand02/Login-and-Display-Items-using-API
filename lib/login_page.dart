import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Application/Home/home_bloc.dart';
import 'Services/products_service.dart';


class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            mainText(),
            loginForm(width, context),
          ],
        ),
      ),
    );
  }

  Form loginForm(double width, BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 14),
                child: Text(
                  'Email',
                  style: TextStyle(color: Colors.grey.shade800),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 20, bottom: 40),
                child: TextFormField(
                  controller: nameController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  cursorHeight: 25.0,
                  decoration: InputDecoration(
                    icon: const Icon(
                      Icons.email_outlined,
                      color: Colors.black,
                      size: 30,
                    ),
                    hintText: 'Enter Email.',
                    hintStyle: GoogleFonts.lato(),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 14),
                child: Text(
                  'Password',
                  style: TextStyle(color: Colors.grey.shade800),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 20, bottom: 10),
                child: TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  cursorHeight: 25.0,
                  decoration: InputDecoration(
                    icon: const Icon(
                      Icons.lock_outline,
                      color: Colors.black,
                      size: 30,
                    ),
                    hintText: 'Enter Password.',
                    hintStyle: GoogleFonts.lato(),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 80,
          ),
          Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Color.fromARGB(255, 98, 219, 198),
                    Color.fromARGB(255, 48, 159, 140)
                  ]),
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                width: width * .9,
                child: ElevatedButton(
                  onPressed: () async {
                    BlocProvider.of<HomeBloc>(context).add(const GetProducts());
                     ProductServices.LogInMethod(username: nameController.text, password: passwordController.text, context: context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Column mainText() {
    return Column(
      children: const [
        Text(
          'Let\'s Sign You In',
          style: TextStyle(
            fontSize: 50,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Future<void> saveData(email) async {
    // print(email);
    final sharedPref = await SharedPreferences.getInstance();
    await sharedPref.setString('saved_data', email);
  }
}
