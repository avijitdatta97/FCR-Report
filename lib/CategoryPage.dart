import 'package:fcr_report/SubCategoryPage.dart';
import 'package:flutter/material.dart';

class CategoryPage extends StatelessWidget {
  static const String routeName = '/categorypage';

  const CategoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Category"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, SubCategoryPage.routeName);
                },
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: const Text(
                    "Fish",
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
          ],
        ),
      ),
    );
  }
}
