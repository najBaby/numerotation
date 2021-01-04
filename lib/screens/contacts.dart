import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:contacts_service/contacts_service.dart';
import 'package:sim_info/sim_info.dart';

import 'widgets.dart';
import 'core/data.dart';
import 'core/services.dart';

class ConfirmActionContact extends StatefulWidget {
  final String question;
  final String result;
  final Future<void> Function() execute;

  ConfirmActionContact({this.execute, this.question, this.result});

  @override
  _ConfirmActionContactState createState() => _ConfirmActionContactState();
}

class _ConfirmActionContactState extends State<ConfirmActionContact> {
  Future future;

  @override
  void initState() {
    super.initState();
  }

  Measures measures;
  ThemeData theme;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    measures = Measures.of(context);
    theme = Theme.of(context);
  }

  Widget get loading => AlertDialog(
        title: Text(
          "Veuillez patienter pour un moment s'il vous plait.",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
            fontSize: measures.labelSize,
          ),
        ),
        content: Container(
          height: measures.value * 40,
          alignment: Alignment.center,
          child: SizedBox.fromSize(
            size: Size.fromRadius(measures.value * 10),
            child: CircularProgressIndicator(
              strokeWidth: measures.value * 2,
            ),
          ),
        ),
      );

  Widget get result => AlertDialog(
        title: Text(
          widget.result,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
            fontSize: measures.labelSize,
          ),
        ),
        actions: [
          TextButton(
            child: Text(
              "Ok",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: measures.labelSize,
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      );

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (context, snaphsot) {
        switch (snaphsot.connectionState) {
          case ConnectionState.done:
            return result;
          case ConnectionState.waiting:
            return loading;
          default:
        }

        return SizedBox(
          height: measures.value * 30,
          child: AlertDialog(
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(
                measures.value * 10,
              ),
            ),
            title: Text(
              widget.question,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w600,
                fontSize: measures.labelSize,
              ),
            ),
            actions: [
              TextButton(
                child: Text(
                  "Non",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: measures.labelSize,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: Text(
                  "Oui",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: measures.labelSize,
                  ),
                ),
                onPressed: () {
                  setState(() {
                    future = widget.execute();
                  });
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class ContactsScreen extends StatefulWidget {
  @override
  _ContactsScreenState createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  String countryName;

  @override
  void initState() {
    super.initState();
    getCountryName();
  }

  Measures measures;
  ThemeData theme;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    measures = Measures.of(context);
    theme = Theme.of(context);
  }

  void showConfirmUpdateDialog() {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return ConfirmActionContact(
          question:
              "Etes-vous sure de vouloir passer vos numéros de 8 à 10 chiffres ?",
          result:
              "Félicitations, vos numéros sont désormais passés à 10 chiffres.",
          execute: () async {
            await updateContacts(countryName);
            setState(() {});
          },
        );
      },
    );
  }

  void showConfirmResetDialog() {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return ConfirmActionContact(
          question:
              "Etes-vous sure de vouloir réinitialiser vos numéros à 8 chiffres ?",
          result:
              "Félicitations, vos numéros sont désormais passés à 8 chiffres.",
          execute: () async {
            await resetContacts(countryName);
            setState(() {});
          },
        );
      },
    );
  }

  Future<void> getCountryName() async {
    countryName = await SimInfo.getIsoCountryCode;
  }

  Widget get loading => Center(
        child: SizedBox.fromSize(
          size: Size.fromRadius(measures.value * 10),
          child: CircularProgressIndicator(
            strokeWidth: measures.value * 2,
          ),
        ),
      );

  Widget updateButton() => BottomAppBar(
        elevation: 0.0,
        child: DefaultButton(
          theme: theme,
          measures: measures,
          icon: Icons.update,
          text: 'Mettre à jour',
          textColor: Colors.white,
          color: theme.primaryColor,
          onPressed: () => showConfirmUpdateDialog(),
        ),
      );

  Widget listViewPhoneModels(Iterable<PhoneModel> phones) {
    var padding = EdgeInsets.symmetric(
      vertical: measures.value * 14.0,
      horizontal: measures.value * 16.0,
    );
    final controller = ScrollController();
    return CupertinoScrollbar(
      controller: controller,
      isAlwaysShown: true,
      thickness: measures.value * 7,
      radius: Radius.circular(measures.value * 5),
      child: ListView.builder(
        controller: controller,
        physics: AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        itemCount: phones.length,
        itemBuilder: (context, index) {
          var phone = phones.elementAt(index);

          return ListItem(
            title: Text(
              phone.name ?? '',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: measures.labelSize,
                letterSpacing: -measures.value * 0.2,
              ),
            ),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  phone.value ?? '',
                  style: TextStyle(
                    fontSize: measures.labelSize,
                    wordSpacing: -measures.value * 0.5,
                    letterSpacing: -measures.value * 0.1,
                  ),
                ),
                Text(
                  phone.network,
                  style: TextStyle(fontSize: measures.labelSize),
                ),
              ],
            ),
            contentPadding: padding,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ContactsService.getContacts(
        withThumbnails: false,
      ),
      builder: (context, snapshot) {
        Widget body, bottom;

        String counter = '';

        var onPressed = () {};

        switch (snapshot.connectionState) {
          case ConnectionState.none:
            break;
          case ConnectionState.active:
          case ConnectionState.waiting:
            body = loading;
            break;
          default:
            final contacts = snapshot.data;
            final models = listPhoneModels(contacts);
            counter = countNewPhoneModels(contacts, models.length);
            body = listViewPhoneModels(models);
            bottom = updateButton();
            onPressed = () {
              showConfirmResetDialog();
            };
        }

        return Scaffold(
          bottomNavigationBar: bottom,
          body: body,
          appBar: AppBar(
            title: RichText(
              textScaleFactor: measures.value,
              text: TextSpan(
                style: TextStyle(
                  fontSize: measures.titleSize,
                ),
                children: [
                  TextSpan(
                    text: counter,
                    style: TextStyle(
                      fontSize: measures.labelSize * 0.9,
                    ),
                  ),
                ],
                text: 'Contacts',
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.more_vert),
                iconSize: measures.iconSize,
                onPressed: onPressed,
              ),
            ],
            leadingWidth: measures.leadingWith,
            leading: IconButton(
              icon: BackButtonIcon(),
              iconSize: measures.iconSize,
              onPressed: () => Navigator.pop(context),
            ),
            toolbarHeight: measures.toolbarHeight,
          ),
        );
      },
    );
  }

  Iterable<Contact> listContacts(Iterable<Contact> all) {
    List<Contact> result = [];
    for (var c in all) {
      for (var p in c.phones) {
        var phone = p.value.split(' ').join();
        if (verifyPhone(phone, countryName)) {
          result.add(c);
          break;
        }
      }
    }
    return result;
  }

  Iterable<PhoneModel> listPhoneModels(Iterable<Contact> all) {
    List<PhoneModel> result = [];
    for (var c in all) {
      for (var p in c.phones) {
        var phone = p.value.split(' ').join();
        if (verifyPhone(phone, countryName)) {
          var phoneType = label(phone);
          var indice = networkIndice(phone);
          var network = phoneType.network(indice);

          result.add(
            PhoneModel(
              contact: c,
              value: p.value,
              name: c.displayName,
              network: networkToString(network),
            ),
          );
        }
      }
    }
    return result;
  }

  String countNewPhoneModels(Iterable<Contact> all, int total) {
    int result = 0;
    for (var c in all) {
      for (var p in c.phones) {
        var phone = p.value.split(' ').join();
        if (verifyPhone(phone, countryName)) {
          if (!checkVersion(phone)) {
            result++;
          }
        }
      }
    }
    if (result == 0) {
      return '\nTous vos numéros sont à jour.';
    }
    if (total == 0) {
      return '\nAucun contact trouvé';
    }
    return '\n$result numéros ne sont pas à jour';
  }

  static Future<void> updateContacts(String countryName) async {
    var contacts = await ContactsService.getContacts(
      withThumbnails: false,
    );
    for (Contact c in contacts) {
      List<Item> phones = [];
      for (Item p in c.phones) {
        var phone = p.value.split(' ').join();
        if (verifyPhone(phone, countryName)) {
          var phoneType = label(phone);
          var indice = networkIndice(phone);
          var network = phoneType.network(indice);

          var update = updatePhone(phone);

          var value = phoneType.format(network);
          p.value = update(value);
          phones.add(p);
        }
      }
      if (phones == c.phones) continue;
      c.phones = phones;
      await ContactsService.updateContact(c);
    }
  }

  static Future<void> resetContacts(String countryName) async {
    var contacts = await ContactsService.getContacts(
      withThumbnails: false,
    );
    for (Contact c in contacts) {
      List<Item> phones = [];
      for (Item p in c.phones) {
        var phone = p.value.split(' ').join();
        if (verifyPhone(phone, countryName)) {
          var phoneType = label(phone);
          var indice = networkIndice(phone);
          var network = phoneType.network(indice);

          var reset = resetPhone(phone);

          var value = phoneType.format(network);
          p.value = reset(value);
          phones.add(p);
        }
      }
      if (phones == c.phones) continue;
      c.phones = phones;
      await ContactsService.updateContact(c);
    }
  }
}
