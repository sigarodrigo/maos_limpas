import 'package:flutter/material.dart';
import 'data/datasources/local/app_database.dart';
import 'di/injection.dart';
import 'ui/screens/login_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';



void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mãos Limpas',
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), // Inglês
        Locale('pt', ''), // Português
      ],
      home: const LoginScreen(),
    );
  }
}

class DatabaseInitScreen extends StatefulWidget {
  const DatabaseInitScreen({super.key});

  @override
  State<DatabaseInitScreen> createState() => _DatabaseInitScreenState();
}

class _DatabaseInitScreenState extends State<DatabaseInitScreen> {
  String? _status;

  @override
  void initState() {
    super.initState();
    _initDb();
  }

  Future<void> _initDb() async {
    try {
      await AppDatabase().database;
      setState(() {
        _status = "Banco de dados inicializado com sucesso!";
      });
    } catch (e) {
      setState(() {
        _status = "Erro ao inicializar o banco de dados: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mãos Limpas')),
      body: Center(
        child: _status == null
            ? const CircularProgressIndicator()
            : Text(_status!, style: const TextStyle(fontSize: 18)),
      ),
    );
  }
}