import 'package:flutter/material.dart';
import 'package:untitled2/maps.dart';

void main() => runApp(
    MaterialApp(

        routes: <String,WidgetBuilder>
        {
          'add': (BuildContext) => add()
        },

        home: maps()
    )
);
