import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'contacts.dart';
import 'core/services.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var measure = Measures.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          CupertinoIcons.sum,
          color: Colors.black,
          size: measure.iconSize,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            iconSize: measure.iconSize,
            color: Colors.black,
            onPressed: () {},
          ),
        ],
        title: Text(
          "Bonne Année 2021",
          style: TextStyle(
            color: Colors.black,
            fontSize: measure.titleSize,
          ),
        ),
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.white,
        toolbarHeight: measure.toolbarHeight,
      ),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(measure.value * 30),
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Icon(
                    CupertinoIcons.phone_fill,
                    color: Colors.black,
                  ),
                ),
                height: measure.toolbarHeight * 2.5,
              ),
              Text(
                "Nouvelle\nNumérotation\nIvoirienne",
                textScaleFactor: measure.value,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.w900,
                  letterSpacing: -measure.value * 2,
                  fontSize: measure.titleSize * 1.5,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: measure.value * 20,
                ),
                child: Text(
                  "Les numéros ivoiriens passent "
                  "de 8 à 10 chiffres à partir du 31 Janvier 2021.",
                  textScaleFactor: measure.value,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w400,
                    fontSize: measure.labelSize,
                    letterSpacing: -measure.value * 0.5,
                  ),
                ),
              ),
              Text(
                "Mettez vos contacts à jour maintenant.",
                textScaleFactor: measure.value,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                  fontSize: measure.labelSize,
                  letterSpacing: -measure.value,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0.0,
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: measure.value * 8.0,
            horizontal: measure.value * 16.0,
          ),
          child: RaisedButton.icon(
            color: theme.primaryColor,
            textColor: Colors.white,
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(
                measure.value * 8,
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                CupertinoPageRoute(builder: (_) => ContactsScreen()),
              );
            },
            icon: Icon(
              Icons.launch,
              size: measure.iconSize,
            ),
            label: Text(
              "Commencez",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: measure.labelSize,
              ),
            ),
          ),
          height: measure.toolbarHeight * 1.1,
        ),
      ),
    );
  }
}
