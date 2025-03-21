import 'package:academicoar/inicio.dart';
import 'package:academicoar/map.dart';
import 'package:academicoar/navegacion_provider.dart';
import 'package:academicoar/perfil.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Principal extends StatefulWidget {
  @override
  _PrincipalState createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> with WidgetsBindingObserver {
  List<Widget> _paginas = [];
  List<BottomNavigationBarItem> _elementos = [];
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
    _IniciarPantallas();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future<void> _IniciarPantallas() async {
    setState(() {
      _paginas = [Inicio(), Mapa(), Perfil()];
      _elementos = [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
        BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Mapa'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    final navegacionProvider = Provider.of<Navegacion>(context);
    final int paginaActual = navegacionProvider.paginaActual;
    if (_paginas.isEmpty) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      body: IndexedStack(index: paginaActual, children: _paginas),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: paginaActual,
        items: _elementos,
        onTap: (index) {
          navegacionProvider.cambiarPagina(index);
        },
        backgroundColor: Color(0xFF49868C),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black,
      ),
    );
  }
}
