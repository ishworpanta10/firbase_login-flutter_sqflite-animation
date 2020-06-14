import 'exports.dart';

class HomePage extends StatefulWidget {
  HomePage({this.auth, this.onSignedOut});
  final BaseAuth auth;
  final VoidCallback onSignedOut;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(controller);
    // animation.addListener(() {
    //   setState(() {});
    // });
    controller.forward();
  }

  void signedOut() async {
    try {
      await widget.auth.logOut();
      widget.onSignedOut();
    } catch (e) {
      print("Error : $e");
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller.forward();
    return Scaffold(
      appBar: AppBar(
        title: Text("Firbase App Covid"),
        centerTitle: true,
        elevation: 0.0,
        titleSpacing: 1.2,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: signedOut,
          )
        ],
      ),
      drawer: buildDrawer(context),
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: products.length,
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        itemBuilder: (BuildContext context, index) {
          return Column(
            children: <Widget>[
              ProductListing(
                prod: products[index],
                animation: animation,
              ),
            ],
          );
        },
      ),
    );
  }
}
