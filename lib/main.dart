import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'filtro.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const JobAdmin(),
    );
  }
}

class JobAdmin extends StatefulWidget {
  const JobAdmin({Key? key}) : super(key: key);

  @override
  _JobAdminState createState() => _JobAdminState();
}

class _JobAdminState extends State<JobAdmin> {
  bool val = false;
  Map<String, bool> eta = {
    'Opzione 1 : 18-25': false,
    'Opzione 2 : 25-35': false,
    'Opzione 3 : 35-45': false,
    'Opzione 3 : >45': false,
  };
  Map<String, bool> titolo = {
    'Diploma': false,
    'Laurea': false,
  };
  Map<String, bool> posizione = {
    'Cuoco': false,
    'Cameriere': false,
  };
  Map<String, bool> sede = {
    'Milano': false,
    'Roma': false,
    'Genova': false,
  };

  getCheckboxItems() {
    Map<String, List> filtri = {
      'eta': [],
      'titolo': [],
      'posizione': [],
      'sede': []
    };
    eta.forEach((key, value) {
      if (value == true) {
        if (key == 'Opzione 3 : >45') {
          filtri['eta']!.add('45-1000');
        } else
          filtri['eta']!.add(key.split(':')[1]);
      }
    });
    titolo.forEach((key, value) {
      if (value == true) {
        filtri['titolo']!.add(key);
      }
    });
    posizione.forEach((key, value) {
      if (value == true) {
        filtri['posizione']!.add(key);
      }
    });
    sede.forEach((key, value) {
      if (value == true) {
        filtri['sede']!.add(key);
      }
    });
    if (!filtri.isEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Filtro(filtro: filtri)),
      );
    } else {
      setState(() {
        val = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Amministrazione'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text('Selezionare il range di età'),
            ListView(
              shrinkWrap: true,
              primary: false,
              physics: NeverScrollableScrollPhysics(),
              children: eta.keys.map((String key) {
                return CheckboxListTile(
                  title: Text(key),
                  value: eta[key],
                  activeColor: Colors.pink,
                  checkColor: Colors.white,
                  onChanged: (bool? value) {
                    setState(() {
                      eta[key] = value!;
                    });
                  },
                );
              }).toList(),
            ),
            Text('Selezionare titolo di studio'),
            ListView(
              shrinkWrap: true,
              primary: false,
              physics: NeverScrollableScrollPhysics(),
              children: titolo.keys.map((String key) {
                return CheckboxListTile(
                  title: Text(key),
                  value: titolo[key],
                  activeColor: Colors.pink,
                  checkColor: Colors.white,
                  onChanged: (bool? value) {
                    setState(() {
                      titolo[key] = value!;
                    });
                  },
                );
              }).toList(),
            ),
            Text('Selezionare posizione'),
            ListView(
              shrinkWrap: true,
              primary: false,
              physics: NeverScrollableScrollPhysics(),
              children: posizione.keys.map((String key) {
                return CheckboxListTile(
                  title: Text(key),
                  value: posizione[key],
                  activeColor: Colors.pink,
                  checkColor: Colors.white,
                  onChanged: (bool? value) {
                    setState(() {
                      posizione[key] = value!;
                    });
                  },
                );
              }).toList(),
            ),
            Text('Selezionare sede'),
            ListView(
              shrinkWrap: true,
              primary: false,
              physics: NeverScrollableScrollPhysics(),
              children: sede.keys.map((String key) {
                return CheckboxListTile(
                  title: Text(key),
                  value: sede[key],
                  activeColor: Colors.pink,
                  checkColor: Colors.white,
                  onChanged: (bool? value) {
                    setState(() {
                      sede[key] = value!;
                    });
                  },
                );
              }).toList(),
            ),
            ElevatedButton(
                child: Text(
                  "Visualizza candidati",
                  style: TextStyle(fontSize: 18),
                ),
                onPressed: getCheckboxItems),
            if (val) Text('inserisci una preferenza'),
            SizedBox(height: 40,)
          ],
        ),
      ),
    );
  }
}
