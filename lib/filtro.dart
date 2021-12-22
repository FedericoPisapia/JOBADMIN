import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'dart:core';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import 'candidato.dart';


class Filtro extends StatefulWidget {
  const Filtro({Key? key, required this.filtro}) : super(key: key);
  final Map<String, List> filtro;

  @override
  _FiltroState createState() => _FiltroState();
}

class _FiltroState extends State<Filtro> {

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filtro'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('users').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData)
                  return Center(
                      child: CircularProgressIndicator(
                    backgroundColor: Colors.deepPurple,
                  ));

                return ListView(
                  shrinkWrap: true,
                  primary: false,
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;
                    String dataNascita = data['Data'];
                    List data_split = dataNascita.split('/');
                    if (data_split[2].toString().length == 2) {
                      if(int.parse(data_split[2])<=30)
                      data_split[2] = '20' + data_split[2];
                      else data_split[2] = '19' + data_split[2];
                    }
                    DateTime date = DateTime(int.parse(data_split[2]),
                        int.parse(data_split[1]), int.parse(data_split[0]));

                    print(calculateAge(date).toString());
                    int eta = calculateAge(date);
                    bool show = false;
                    for (int i = 0; i < widget.filtro['eta']!.length; i++) {
                      var ageRange = widget.filtro['eta']![i];
                      List listAges = ageRange.split("-");
                      int ageMin = int.parse(listAges[0]);
                      int ageMax = int.parse(listAges[1]);

                      if (eta > ageMin && eta < ageMax) {
                        show = true;
                      }
                    }
                    show = show &&
                        widget.filtro['titolo']!.contains(data['Titolo']);
                    show = show &&
                        widget.filtro['posizione']!.contains(data['Posizione']);
                    show = show && widget.filtro['sede']!.contains(data['Sede']);

                    if (!show) {
                      return Container();
                    }
                    return ListTile(
                      onTap: () {Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Candidato(data : data)),
                      );},
                      title: Text(data['Nome'] + " " + data['Cognome']),
                      subtitle: Text(data['Titolo']+ ', ' + eta.toString() + ' anni'  ),
                      trailing: IconButton(
                        icon: Icon(Icons.assignment_returned_outlined),
                        onPressed: () async {
                          launch(data['UrlPdf']);
                          },
                      ),
                    );
                  }).toList(),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

calculateAge(DateTime birthDate) {
  DateTime currentDate = DateTime.now();
  int age = currentDate.year - birthDate.year;
  int month1 = currentDate.month;
  int month2 = birthDate.month;
  if (month2 > month1) {
    age--;
  } else if (month1 == month2) {
    int day1 = currentDate.day;
    int day2 = birthDate.day;
    if (day2 > day1) {
      age--;
    }
  }
  return age;
}
