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
            Text(widget.data['Nome']),
            Text(widget.data['Cognome']),
            Text(widget.data['Telefono']),
            Text(widget.data['Email']),
            Text(widget.data['Data']),
            Text(widget.data['Posizione']),
            Text(widget.data['Titolo']),
            Text(widget.data['Sede']),
            TextButton(
                onPressed: () {print(widget.data['UrlPdf']);
                  launch("https://firebasestorage.googleapis.com/v0/b/job-69345.appspot.com/o/CV%2Farcimbolid%203.pdf?alt=media&token=0616049e-d276-4f3d-9ded-36fe22bcefc8");
                },
                child: Text('scarica il CV'))
          ],
        ),
      ),
    );
  }
}
