import 'package:academicoar/firebase_options.dart';
import 'package:academicoar/inicio.dart';
import 'package:academicoar/login.dart';
import 'package:academicoar/navegacion_provider.dart';
import 'package:academicoar/pantallacarga.dart';
import 'package:academicoar/perfil.dart';
import 'package:academicoar/principal.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //runApp(const MyApp());
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    ChangeNotifierProvider(create: (context) => Navegacion(), child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.cyan,
          secondary: Colors.blue,
        ),
        useMaterial3: true,
      ),
      //home: Pantallacarga(),
      initialRoute: '/',
      routes: {
        '/': (context) => Pantallacarga(),
        '/login': (context) => InicioSesion(),
        '/perfil': (context) => Perfil(),
        '/inicio': (context) => Inicio(),
        '/principal': (context) => Principal(),
      },
      builder: EasyLoading.init(),
    );
  }
}
