import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Pantallacarga extends StatefulWidget {
  @override
  _PantallacargaState createState() => _PantallacargaState();
}

class _PantallacargaState extends State<Pantallacarga> {
  @override
  void initState() {
    super.initState();
    _inicio();
  }

  Future<void> _inicio() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? dato = prefs.getString('id');

    if (dato != null) {
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.pushReplacementNamed(context, '/principal');
      });
    } else {
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.pushReplacementNamed(context, '/inicio');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pantalla de carga"),
        backgroundColor: Color(0xFF49868C),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/Logo1.png', width: 200, height: 200),

              const CircularProgressIndicator(),
              const SizedBox(height: 20),
              const Text(
                "Cargando",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
