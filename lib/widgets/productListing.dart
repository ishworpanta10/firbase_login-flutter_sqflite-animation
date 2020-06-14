import 'dart:developer';

import 'package:firestore_auth/class/product.dart';
import 'package:firestore_auth/screens/productDetails.dart';
import 'package:firestore_auth/screens/rating.dart';
import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

class ProductListing extends StatelessWidget {
  final Product prod;
  final Animation<double> animation;

  ProductListing({@required this.prod, this.animation});

  void _showDialog({BuildContext context, String title, String desc}) {
    Timeline.startSync("Start _showDialog");
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Container(
              height: 60.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(desc),
                  Text("Rs." + prod.price.toString()),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                  child: Text("Close"),
                  onPressed: () {
                    Navigator.pop(context);
                  })
            ],
          );
        });

        Timeline.finishSync();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animation,
      child: Container(
        decoration: BoxDecoration(),
        child: Card(
          margin: const EdgeInsets.only(top: 18),
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, bottom: 20.0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      width: 120,
                      child: Image.asset("images/" + prod.image),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text(
                                prod.heading,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                ),
                              ),
                              Text(prod.description),
                              Text(
                                "Rs." + prod.price.toString(),
                              ),
                              RatingBox(),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    RaisedButton(
                      onPressed: () => _showDialog(
                        context: context,
                        title: prod.heading,
                        desc: prod.description,
                      ),
                      child: Text("Info"),
                    ),
                    RaisedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ProductDetails(
                                  product: prod,
                                )));
                      },
                      child: Text("Detail Page"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
