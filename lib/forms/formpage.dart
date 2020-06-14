import 'package:firestore_auth/class/contact.dart';
import 'package:firestore_auth/utils/dbhelper.dart';
import 'package:flutter/material.dart';

class FormPage extends StatefulWidget {
  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  DatabaseHelper _databaseHelper;

  Contact _contact = Contact();

  List<Contact> _contacts = [];

  final formKey = GlobalKey<FormState>();

  final _controllerName = TextEditingController();
  final _controllerPhone = TextEditingController();
  final _controllerEmail = TextEditingController();

  @override
  void initState() {
    super.initState();
    _databaseHelper = DatabaseHelper.instance;
    _refreshContactList();
  }

  _refreshContactList() async {
    List<Contact> x = await _databaseHelper.fetchContacts();
    setState(() {
      _contacts = x;
    });
  }

  _onSubmit() async {
    var form = formKey.currentState;
    if (form.validate()) {
      form.save();
      if (_contact.id == null) {
        await _databaseHelper.insertContact(_contact);
      } else {
        await _databaseHelper.updateContact(_contact);
      }
      print('''
      Full Name : ${_contact.name}
      Mobile : ${_contact.phone}
      ''');
      _contacts.add(Contact(
          id: null,
          name: _contact.name,
          phone: _contact.phone,
          email: _contact.email));
      // form.reset();
      _resetForm();
      await _refreshContactList();
    }
  }

  _resetForm() {
    setState(() {
      formKey.currentState.reset();
      _controllerName.clear();
      _controllerPhone.clear();
      _controllerEmail.clear();
      _contact.id = null;
    });
  }

  _showForEdit(index) {
    setState(() {
      _contact = _contacts[index];
      _controllerName.text = _contacts[index].name;
      _controllerPhone.text = _contacts[index].phone;
      _controllerEmail.text = _contacts[index].email;
    });
  }

  _handleDelete(index) async {
    await _databaseHelper.deleteContact(_contacts[index].id);
    _resetForm();

    _refreshContactList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Form"),
      ),
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[_form(), _list()],
        ),
      ),
    );
  }

  _form() => Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextFormField(
                  controller: _controllerName,
                  decoration: InputDecoration(
                    labelText: "Enter Your name",
                    // border: OutlineInputBorder(
                    //   borderRadius: BorderRadius.circular(10),
                    // ),
                  ),
                  validator: (value) =>
                      value.isEmpty ? "Name is required" : null,
                  onSaved: (value) {
                    setState(() {
                      _contact.name = value;
                    });
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  controller: _controllerPhone,
                  decoration: InputDecoration(
                    labelText: "Enter Your Phone number",
                    // border: OutlineInputBorder(
                    //   borderRadius: BorderRadius.circular(10),
                    // ),
                  ),
                  validator: (value) =>
                      value.isEmpty ? "Phone is required" : null,
                  onSaved: (value) {
                    setState(() {
                      _contact.phone = value;
                    });
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  controller: _controllerEmail,
                  decoration: InputDecoration(
                    labelText: "Enter Your email ",
                    // border: OutlineInputBorder(
                    //   borderRadius: BorderRadius.circular(10),
                    // ),
                  ),
                  validator: (value) =>
                      value.isEmpty ? "Email is required" : null,
                  onSaved: (value) {
                    setState(() {
                      _contact.email = value;
                    });
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    color: Colors.blue,
                    textColor: Colors.white,
                    onPressed: _onSubmit,
                    child: Text("Save"),
                  ),
                )
              ],
            ),
          ),
        ),
      );

  _list() => Expanded(
        child: Card(
          child: Scrollbar(
            child: ListView.builder(
              itemCount: _contacts.length,
              itemBuilder: (context, index) {
                void _callDialog(
                    {BuildContext context,
                    String name,
                    String phone,
                    String email}) {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          title: Text("Are you sure to delete $name "),
                          content: ListTile(
                            title: Text(
                              "Email :" + email,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 14.0),
                            ),
                            subtitle: Text(
                              "Phone :" + phone,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 14.0),
                            ),
                          ),
                          actions: <Widget>[
                            FlatButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text("Cancel"),
                            ),
                            FlatButton(
                              onPressed: () {
                                _handleDelete(index);
                                Navigator.pop(context);
                              },
                              child: Text("Delete"),
                            )
                          ],
                        );
                      });
                }

                return Column(
                  children: <Widget>[
                    ListTile(
                      leading: Icon(
                        Icons.account_circle,
                        size: 40.0,
                        color: Colors.blue,
                      ),
                      title: Text(
                        _contacts[index].name.toUpperCase(),
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      isThreeLine: true,
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Email : " + _contacts[index].email,
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 14.0),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            "Phone : " + _contacts[index].phone,
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 14.0),
                          ),
                        ],
                      ),
                      onTap: () {
                        _showForEdit(index);
                      },
                      trailing: IconButton(
                          icon: Icon(
                            Icons.delete_sweep,
                            color: Colors.blue,
                          ),
                          onPressed: () {
                            _callDialog(
                                context: context,
                                name: _contacts[index].name,
                                phone: _contacts[index].phone,
                                email: _contacts[index].email);
                          }),
                    ),
                    Divider(),
                  ],
                );
              },
            ),
          ),
        ),
      );
}
