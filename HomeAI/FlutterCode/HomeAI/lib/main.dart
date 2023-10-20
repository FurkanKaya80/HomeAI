import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';



/*void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Akıllı Ev Sistemleri',
    home: MyHomePage(),
  );
}

class MyHomePage extends StatefulWidget{
  MyHomePage({
    Key? key,
}): super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Akıllı Ev"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            LiteRollingSwitch(
              value: false,
              onChanged: (bool state) {
                print('turned ${(state) ? 'on' : 'off' }');
              },
            ),
            Padding(
                padding: EdgeInsets.only(top: 20),
                child: LiteRollingSwitch(
                  value: true,
                  textOn: 'active',
                  textOff: 'inactive',
                  colorOn: Colors.deepOrange,
                  colorOff: Colors.redAccent,
                  iconOn: Icons.lightbulb_outline,
                  iconOff: Icons.power_settings_new,
                  onChanged: (bool state) {
                    print('turned ${(state) ? 'on' : 'off' }');
                  },
                ),
            )
          ],
        ),
      ),
    );
  }
}*/
//################################################ AYIRAN BÖLÜM ##################
/*
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Akıllı Ev Sistemleri',
        theme: ThemeData(
          brightness: Brightness.dark,
        ),
        home: MyHomePage(),
      );
}

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool lights = false;
  bool role = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Akıllı Ev"),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            child: SwitchListTile(
              title: const Text(
                'Lights',
                style: TextStyle(fontSize: 24),
              ),
              value: lights,
              onChanged: (bool value) {
                setState(() {
                  lights = value;
                });
              },
              secondary: const Icon(Icons.lightbulb_outline),
            ),
          ),
          Positioned(
            top: 50,
            child: SwitchListTile(
              title: const Text(
                'Röle',
                style: TextStyle(fontSize: 24),
              ),
              value: role,
              onChanged: (bool value) {
                setState(() {
                  role = value;
                });
              },
              secondary: const Icon(Icons.mark_chat_read_rounded),
            ),
          )
        ],
      ),
    );
  }
}
*/

/*
// İCONLU OLAN ################
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Kontrol Paneli'),
        ),
        body: ControlPanel(),
      ),
    );
  }
}

class ControlPanel extends StatefulWidget {
  @override
  _ControlPanelState createState() => _ControlPanelState();
}

class _ControlPanelState extends State<ControlPanel> {
  bool lightSwitch = false;
  bool relaySwitch = false;
  double roomTemperature = 24.5; // Örnek sıcaklık değeri

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black, // Arka plan rengi
      padding: EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(
                    lightSwitch ? Icons.lightbulb : Icons.lightbulb_outline,
                    color: lightSwitch ? Colors.yellow : Colors.grey,
                  ),
                  Switch(
                    value: lightSwitch,
                    onChanged: (value) {
                      setState(() {
                        lightSwitch = value;
                      });
                    },
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Icon(
                    relaySwitch ? Icons.power_settings_new : Icons.power_settings_new_outlined,
                    color: relaySwitch ? Colors.green : Colors.grey,
                  ),
                  Switch(
                    value: relaySwitch,
                    onChanged: (value) {
                      setState(() {
                        relaySwitch = value;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 16.0),
          Text(
            'Oda Sıcaklığı: ${roomTemperature.toStringAsFixed(1)}°C',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24.0,
            ),
          ),
        ],
      ),
    );
  }
}*/


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Kontrol Paneli'),
        ),
        body: ControlPanel(),
      ),
    );
  }
}

class ControlPanel extends StatefulWidget {
  @override
  _ControlPanelState createState() => _ControlPanelState();
}

class _ControlPanelState extends State<ControlPanel> {
  bool lightSwitch = false;
  bool relaySwitch = false;
  double roomTemperature = 12.5; // Firebase'den okunan sıcaklık değeri
  late DatabaseReference sicaklikRef; // Firebase veritabanı referansı
  int led = 0;
  int role =0;

  @override
  void initState() {
    super.initState();
    final databaseReference = FirebaseDatabase.instance.reference();
    sicaklikRef = databaseReference.child('Sicaklik');

    // Firebase verilerini dinleme
    sicaklikRef.onValue.listen((event) {
      final dataSnapshot = event.snapshot;
      if (dataSnapshot.value != null) {
        setState(() {
          roomTemperature = double.parse(dataSnapshot.value.toString());
        });
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black, // Arka plan rengi
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(
              Icons.lightbulb,
              color: lightSwitch ? Colors.yellow : Colors.grey,
            ),
            title: Text(
              'Işık',
              style: TextStyle(color: Colors.white, fontSize: 24.0),
            ),
            trailing: Switch(
              value: lightSwitch,
              onChanged: (value) {
                setState(() {
                  lightSwitch = value;
                  DatabaseReference _led = FirebaseDatabase.instance.reference().child("Led");
                  if(value == false){
                    led = 0;
                    _led.set(led++);
                  }
                  else{
                    led = 1;
                    _led.set(led--);
                  }
                });
              },
            ),
          ),
          ListTile(
            leading: Icon(
              relaySwitch ? Icons.power_settings_new : Icons.power_settings_new_outlined,
              color: relaySwitch ? Colors.green : Colors.grey,
            ),
            title: Text(
              'Röle',
              style: TextStyle(color: Colors.white, fontSize: 24.0),
            ),
            trailing: Switch(
              value: relaySwitch,
              onChanged: (value) {
                setState(() {
                  relaySwitch = value;
                  DatabaseReference _role = FirebaseDatabase.instance.reference().child("Role");
                  if(value == false){
                    role = 0;
                    _role.set(0);
                  }
                  else{
                    role = 1;
                    _role.set(1);
                  }
                });
              },
            ),
          ),
          SizedBox(height: 16.0),
          Text(
            'Oda Sıcaklığı: ${roomTemperature.toStringAsFixed(1)}°C',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24.0,
            ),
          ),
        ],
      ),
    );
  }
}