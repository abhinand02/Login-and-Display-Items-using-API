import 'package:flutter/material.dart';

import 'Services/products_service.dart';

class EditProduct extends StatelessWidget {
  final String price, title, description;
  EditProduct(
      {super.key,
      required this.price,
      required this.title,
      required this.description});

  final GlobalKey<FormState> titleFormKey = GlobalKey();
  final GlobalKey<FormState> priceFormKey = GlobalKey();
  final GlobalKey<FormState> descriptionFormKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final TextEditingController titleController =
        TextEditingController(text: title);
    final TextEditingController priceController =
        TextEditingController(text: price);
    final TextEditingController descriptionController =
        TextEditingController(text: description);
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          FormTextField(
              controller: titleController,
              formkey: titleFormKey,
              hintText: 'title'),
          FormTextField(
              controller: priceController,
              formkey: priceFormKey,
              hintText: 'price'),
          FormTextField(
              controller: descriptionController,
              formkey: descriptionFormKey,
              hintText: 'description'),
          ElevatedButton(
              onPressed: () {
                ProductServices.getSingleProduct(
                    title: titleController.text,
                    price: priceController.text,
                    description: descriptionController.text);
              },
              child: Text('Edit'))
        ]),
      ),
    );
  }
}

class FormTextField extends StatelessWidget {
  final GlobalKey<FormState> formkey;
  final TextEditingController controller;
  final String hintText;
  const FormTextField(
      {Key? key,
      required this.controller,
      required this.formkey,
      required this.hintText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formkey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            hintText: hintText,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
        ),
      ),
    );
  }
}
