import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Candidato extends StatefulWidget {
  const Candidato({Key? key, required Map<String, dynamic> this.data})
      : super(key: key);
  final Map<String, dynamic> data;

  @override
  _CandidatoState createState() => _CandidatoState();
}

class _CandidatoState extends State<Candidato> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pagina del candidato'),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 40,),
            Text('Nome : ' + widget.data['Nome']),
            Text('Cognome : ' +widget.data['Cognome']),
            Text('Telefono : ' +widget.data['Telefono']),
            Text('Email : ' +widget.data['Email']),
            Text('Data di nascità : ' +widget.data['Data']),
            Text('Posizione : ' +widget.data['Posizione']),
            Text('Titolo : ' +widget.data['Titolo']),
            Text('Sede : ' +widget.data['Sede']),
            Text('Candidatura : ' +widget.data['Candidatura']),
            TextButton(
                onPressed: () {print(widget.data['UrlPdf']);
                  launch(widget.data['UrlPdf']);
                },
                child: Text('scarica il CV'))
          ],
        ),
      ),
    );
  }
}
