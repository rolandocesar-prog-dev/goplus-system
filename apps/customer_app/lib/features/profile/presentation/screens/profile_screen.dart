import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../auth/presentation/providers/auth_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(authStateProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Perfil'),
      ),
      body: userAsync.when(
        data: (user) {
          if (user == null) {
            return const Center(child: Text('No hay usuario autenticado'));
          }
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Center(
                child: Column(
                  children: [
                    if (user.photoUrl != null)
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(user.photoUrl!),
                      )
                    else
                      const CircleAvatar(
                        radius: 60,
                        child: Icon(Icons.person, size: 60),
                      ),
                    const SizedBox(height: 16),
                    Text(
                      user.displayName ?? 'Usuario',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      user.email,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              Card(
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.person),
                      title: const Text('Información personal'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        // TODO: Navegar a información personal
                      },
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(Icons.location_on),
                      title: const Text('Direcciones guardadas'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        // TODO: Navegar a direcciones
                      },
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(Icons.payment),
                      title: const Text('Métodos de pago'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        // TODO: Navegar a métodos de pago
                      },
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(Icons.settings),
                      title: const Text('Configuración'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        // TODO: Navegar a configuración
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.logout, color: Colors.red),
                  title: const Text(
                    'Cerrar sesión',
                    style: TextStyle(color: Colors.red),
                  ),
                  onTap: () async {
                    final authController = ref.read(authControllerProvider);
                    await authController.signOut();
                  },
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Error: $error'),
        ),
      ),
    );
  }
}
