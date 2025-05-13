// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:maos_limpas/core/routes/app_router.dart';
import 'package:maos_limpas/data/datasources/local/app_database.dart';
import 'package:maos_limpas/di/injection.dart' as existing_di;
import 'package:maos_limpas/di/injection_container.dart' as new_di;
import 'package:maos_limpas/ui/screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Inicializar injeção de dependência existente
  existing_di.setupLocator();
  
  // Inicializar nova injeção de dependência para a Sprint 2
  await new_di.init();
  
  // Inicializar banco de dados
  await AppDatabase().database;
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mãos Limpas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
        ),
        cardTheme: CardTheme(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          filled: true,
          fillColor: Colors.grey[50],
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), // Inglês
        Locale('pt', ''), // Português
      ],
      // Usar o router para navegação, mas começar com a tela de login
      home: const LoginScreen(),
      // Configurar o router para navegação após o login
      onGenerateRoute: (settings) {
        // Aqui podemos integrar as rotas do go_router com as rotas existentes
        if (settings.name == '/home') {
          return MaterialPageRoute(
            builder: (context) => router.routerDelegate.build(context),
          );
        }
        return null;
      },
    );
  }
}

// Modificar a classe LoginScreen para navegar para a nova Home após o login
// Isso deve ser feito no arquivo ui/screens/login_screen.dart:
/*
class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ... código existente ...
    
    // Ao fazer login com sucesso:
    onLoginSuccess() {
      Navigator.pushReplacementNamed(context, '/home');
    }
    
    // ... resto do código ...
  }
}
*/

// Classe para inicialização do banco de dados (mantida para compatibilidade)
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
      
      // Navegar para a tela principal após inicialização bem-sucedida
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/home');
      }
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