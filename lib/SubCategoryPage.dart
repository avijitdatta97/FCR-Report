import 'package:fcr_report/FishFormPage.dart';
import 'package:flutter/material.dart';

import 'CategoryPage.dart';

class SubCategoryPage extends StatelessWidget {
  static const String routeName = '/subcategorypage';

  const SubCategoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Subcategory"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {

                },
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: const Text(
                    "Talapia",
                    style: TextStyle(fontSize: 30),
                  ),
                )),
            SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {},
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: const Text(
                    "Poltty",
                    style: TextStyle(fontSize: 30),
                  ),
                )),
            SizedBox(height: 20,),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, CategoryPage.routeName);
                },
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: const Text(
                    "Cattle",
                    style: TextStyle(fontSize: 30),
                  ),
                )),
            SizedBox(height: 20,),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, CategoryPage.routeName);
                },
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: const Text(
                    "Roi",
                    style: TextStyle(fontSize: 30),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
