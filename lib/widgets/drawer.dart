import 'package:firestore_auth/forms/formpage.dart';
import 'package:flutter/material.dart';

Widget buildDrawer(BuildContext context) {
  return Drawer(
    child: ListView(
      children: <Widget>[
        UserAccountsDrawerHeader(
          accountName: Text("Ishwor Panta"),
          accountEmail: Text("ishworpanta10@gmail.com"),
          currentAccountPicture: CircleAvatar(
            child: FlutterLogo(),
          ),
        ),
        ListTile(
          leading: Icon(Icons.contacts),
          title: Text("Contacts"),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => FormPage()),
            );
          },
        ),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text("Settings"),
          onTap: () {},
          // onTap: () {
          //   Navigator.of(context).push(
          //     MaterialPageRoute(builder: (_) => FormPage()),
          //   );
          // },
        ),
      ],
    ),
  );
}
