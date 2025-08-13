import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const GoPlusAdminApp());
}

class GoPlusAdminApp extends StatelessWidget {
  const GoPlusAdminApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GoPlus Admin',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.red, // Color distintivo para admin
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.red,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      themeMode: ThemeMode.system, // Admin panel con tema automático
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.grey.shade900 : Colors.red.shade50,
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 500),
          padding: const EdgeInsets.all(50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(28),
                decoration: BoxDecoration(
                  color: isDark ? Colors.red.shade900 : Colors.red.shade100,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.red.withOpacity(0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.admin_panel_settings,
                  size: 72,
                  color: Colors.red.shade600,
                ),
              ),
              const SizedBox(height: 35),
              Text(
                'GoPlus Admin',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.red.shade200 : Colors.red.shade800,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 15),
              Text(
                'Panel de Administración del Sistema',
                style: TextStyle(
                  fontSize: 18,
                  color: isDark ? Colors.red.shade300 : Colors.red.shade600,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 50),

              // Progress indicator más sofisticado para admin
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      backgroundColor:
                          isDark ? Colors.red.shade800 : Colors.red.shade100,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.red.shade600,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.security,
                    size: 24,
                    color: Colors.red.shade600,
                  ),
                ],
              ),

              const SizedBox(height: 25),
              Text(
                'Verificando permisos de administrador...',
                style: TextStyle(
                  fontSize: 14,
                  color: isDark ? Colors.red.shade400 : Colors.red.shade500,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
