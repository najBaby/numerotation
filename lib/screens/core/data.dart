import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';

class Data extends InheritedWidget {
  Data({
    @required Widget child,
  }) : super(child: child);

  @override
  bool updateShouldNotify(_) => true;
  static Data of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<Data>();
}

class PhoneItem {
  String type;
  String name;
  String phone;

  PhoneItem({
    this.type,
    this.name,
    this.phone,
  });
}

class PhoneModel {
  PhoneModel({
    this.name,
    this.value,
    this.label,
    this.network,
    this.contact,
  });

  Contact contact;
  String name;
  String value;
  String label;
  String network;
}
