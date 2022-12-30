import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:login_and_home_page/Services/base_url.dart';
import '../Model/Products.dart';
import '../home_page.dart';

class ProductServices {
  static Dio dio = DioBaseUrl.dio;
  static Future<List<Product>?> getProduct() async {
    try {
      var response = await dio.get('/products');
      Getproducts getProduct = Getproducts.fromJson(response.data);
      return getProduct.products;
    } catch (e) {
      print(
        e.toString(),
      );
    }
    return null;
  }

  static Future<Product?> getSingleProduct(
      {required String title, required price, required description}) async {
    try {
      var response = await dio.put('/products/1',
          data: {
            "title": title,
            "price": int.parse(price),
            "thumbnail": "thumbnail",
            "description": description
          },
          options: Options(headers: {'Content-Type': 'application/json'}));
      Product result = Product.fromJson(response.data);
      log(result.title.toString());
      return result;
    } on DioError catch (e) {
      log(e.error);
    }
    return null;
  }

  static Future LogInMethod(
      {required String username,
      required password,
      required BuildContext context}) async {
    try {
      var response = await dio.post('/auth/login',
          data: {
            "username": username,
            "password": password,
          },
          options: Options(headers: {'Content-Type': 'application/json'}));
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const HomePage()),
          (route) => false);
    } catch (e) {
      const snackBar = SnackBar(content: Text('Incorrect Email or Password'));

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
