import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/contact.dart';
import 'new_contact_form.dart';

//https://pub.dev/packages/hive

class ContactPage extends StatelessWidget {
  const ContactPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Hive Tutorial'),
        ),
        body: Column(
          children: <Widget>[
            Expanded(child: _buildListView()),
            NewContactForm(),
          ],
        ));
  }

  //https://stackoverflow.com/questions/60257233/the-box-contacts-is-already-open-and-of-type-boxcontact-when-trying-to-acces
  ListView _buildListView() {
    final contactsBox = Hive.box('contacts');
    // return ListView(
    //   children: <Widget>[
    //     ListTile(
    //       title: Text('Name'),
    //       subtitle: Text('Age'),
    //     )
    //   ],
    // );
    return ListView.builder(
      itemCount: contactsBox.length,
      itemBuilder: (BuildContext context, int index) {

        // final Contact contact = Hive.box('contacts').getAt(index);

        final contact = contactsBox.getAt(index) as Contact;

        // List listOfContacts = contactsBox.values.toList();
        // Contact contact = listOfContacts[index];

        return ListTile(
          title: Text(contact.name),
          subtitle: Text(contact.age.toString()),
        );
      },
    );
  }
}
