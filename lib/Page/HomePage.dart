import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile_api/Util/statement.dart';

import '../API/API.dart';
import '../Item/urunItem.dart';
import '../Model/Product.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Product> kapakUrunleri = [];
  List<Product> urunler = [];

  Future<void> getProduct() async {
    var data = await API.getProduct();
    Map valueMap = jsonDecode(data['products']);
    valueMap.forEach((key, value) {
      Product product = Product.fromJson(value);
     kapakUrunleri.add(product);
    });
    urunler = kapakUrunleri.reversed.toList();
    setState(() {});
    if(kapakUrunleri.isEmpty) statement(context, jsonDecode(data['message']));
  }

  @override
  void initState() {
    super.initState();
    getProduct();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SizedBox(
          width: width,
          height: height,
          child: RefreshIndicator(
            onRefresh: () async {
              print("asd");
              getProduct();
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                        child: Text(
                      "Favori ürünler",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 23,
                          fontWeight: FontWeight.bold),
                    )),
                  ),
                  SizedBox(
                    height: 200,
                    width: width,
                    child: ListView.builder(
                        itemCount: kapakUrunleri.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, i) {
                          Product product = kapakUrunleri[i];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: urunItem(
                                context: context,
                                u: product,
                                color: Colors.lightBlue.shade800,
                                width: width / 1.9,
                                height: height),
                          );
                        }),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                        child: Text(
                      "Ürünler",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 23,
                          fontWeight: FontWeight.bold),
                    )),
                  ),
                  GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 5.0,
                      mainAxisSpacing: 5.0,
                    ),
                    itemCount: urunler.length,
                    itemBuilder: (context, index) {
                      Product product = urunler[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: urunItem(
                            context: context,
                            color: Colors.red,
                            u: product,
                            width: width / 1.9,
                            height: height),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
