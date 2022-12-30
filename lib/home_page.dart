import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_and_home_page/edit_product.dart';
import 'package:login_and_home_page/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:login_and_home_page/constants/styles.dart';

import 'Application/Home/home_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 212, 208, 208),
      appBar: appBar(context),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state.allProducts == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.separated(
            itemBuilder: (context, index) {
              final data = state.allProducts![index];
              return ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => EditProduct(
                          price: data.price.toString(),
                          title: data.title,
                          description: data.description)));
                },
                leading: Image.network(data.thumbnail),
                title: Text(
                  data.title,
                  style: const TextStyle(color: Colors.black, fontSize: 18),
                ),
                subtitle: Text(
                  "₹${data.price.toString()}",
                  style: const TextStyle(color: Colors.black, fontSize: 15),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const Divider(
                thickness: .4,
              );
            },
            itemCount: 20,
            physics: const AlwaysScrollableScrollPhysics(),
          );
        },
      ),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      title: const Text('Home'),
      backgroundColor: const Color.fromARGB(55, 98, 219, 198),
      actions: [
        IconButton(
            icon: const Icon(Icons.logout_rounded),
            tooltip: 'Log Out',
            onPressed: () {
              logoutUser(context);
            })
      ],
    );
  }

  logoutUser(BuildContext ctx) async {
    return showDialog(
      context: ctx,
      builder: (ctx1) {
        return AlertDialog(
          content: Text(
            'Are you sure to Logout?',
            style: popupHeading,
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: Text(
                    'Cancel',
                    style: buttonTextStyle,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    clearData();
                    Navigator.pushReplacement(
                      ctx,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  child: Text(
                    'Yes',
                    style: buttonTextStyle,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

Future<void> clearData() async {
  SharedPreferences sharedPref = await SharedPreferences.getInstance();
  sharedPref.remove('saved_data');
}
