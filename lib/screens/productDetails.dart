import 'package:firestore_auth/class/product.dart';
import 'package:firestore_auth/screens/rating.dart';
import 'package:flutter/material.dart';

class ProductDetails extends StatefulWidget {
  final Product product;
  ProductDetails({
    this.product,
  });

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    final CurvedAnimation curve =
        CurvedAnimation(parent: controller, curve: Curves.easeIn);
    animation = Tween<double>(
      begin: 50,
      end: 400.0,
    ).animate(curve);
    animation.addListener(() {
      setState(() {});
    });
    // animation.addStatusListener(listener);

    controller.forward();
  }

  // void listener(AnimationStatus status) {
  //   if (status == AnimationStatus.completed) {
  //     controller.reverse();
  //   } else if (status == AnimationStatus.dismissed) {
  //     controller.forward();
  //   }
  // }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget builder(BuildContext context, Widget child) {
    return Container(
      height: animation.value,
      width: animation.value,
      child: Image.asset("images/" + widget.product.image),
    );
  }

  bool load = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.heading),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // if (load) ...[Text("data")], // Spread operator return list of widgget on condition
              //.. cascade operator in dart
              //Performance overlay
              //Basic utils in pub
              Container(
                height: animation.value,
                width: animation.value,
                child: Image.asset("images/" + widget.product.image),
              ),
              RatingBox(),

              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        widget.product.heading,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(widget.product.description),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        "Rs." + widget.product.price.toString(),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        height: 10,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            Container(
                              color: Colors.blue,
                              height: 100,
                              width: 100,
                            ),
                            Container(
                              color: Colors.red,
                              height: 100,
                              width: 100,
                            ),
                            Container(
                              color: Colors.green,
                              height: 100,
                              width: 100,
                            ),
                            Container(
                              color: Colors.red,
                              height: 100,
                              width: 100,
                            ),
                            Container(
                              color: Colors.grey,
                              height: 100,
                              width: 100,
                            ),
                          ],
                        ),
                      ),
                      AnimatedBuilder(
                        animation: animation,
                        builder: builder,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
