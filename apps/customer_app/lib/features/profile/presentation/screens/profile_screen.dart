import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/theme_provider.dart';
import '../../../auth/presentation/providers/auth_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(authStateProvider);
    final theme = Theme.of(context);

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
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
                        child: Icon(
                          Icons.person_rounded,
                          size: 60,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    const SizedBox(height: 16),
                    Text(
                      user.displayName ?? 'Usuario',
                      style: theme.textTheme.displaySmall,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      user.email,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.secondary.withOpacity(0.6),
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
                      leading: Icon(
                        Icons.person_outline_rounded,
                        color: theme.colorScheme.secondary,
                      ),
                      title: const Text('Información personal'),
                      trailing: Icon(
                        Icons.chevron_right_rounded,
                        color: theme.colorScheme.secondary.withOpacity(0.4),
                      ),
                      onTap: () {
                        context.go('/profile/personal-info');
                      },
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: Icon(
                        Icons.location_on_outlined,
                        color: theme.colorScheme.secondary,
                      ),
                      title: const Text('Direcciones guardadas'),
                      trailing: Icon(
                        Icons.chevron_right_rounded,
                        color: theme.colorScheme.secondary.withOpacity(0.4),
                      ),
                      onTap: () {
                        // TODO: Navegar a direcciones
                      },
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: Icon(
                        Icons.payment_outlined,
                        color: theme.colorScheme.secondary,
                      ),
                      title: const Text('Métodos de pago'),
                      trailing: Icon(
                        Icons.chevron_right_rounded,
                        color: theme.colorScheme.secondary.withOpacity(0.4),
                      ),
                      onTap: () {
                        // TODO: Navegar a métodos de pago
                      },
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: Icon(
                        Icons.settings_outlined,
                        color: theme.colorScheme.secondary,
                      ),
                      title: const Text('Configuración'),
                      trailing: Icon(
                        Icons.chevron_right_rounded,
                        color: theme.colorScheme.secondary.withOpacity(0.4),
                      ),
                      onTap: () {
                        // TODO: Navegar a configuración
                      },
                    ),
                    const Divider(height: 1),
                    _buildThemeToggle(context, ref, theme),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Card(
                child: ListTile(
                  leading: Icon(
                    Icons.logout_rounded,
                    color: theme.colorScheme.error,
                  ),
                  title: Text(
                    'Cerrar sesión',
                    style: TextStyle(color: theme.colorScheme.error),
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

  Widget _buildThemeToggle(BuildContext context, WidgetRef ref, ThemeData theme) {
    final themeMode = ref.watch(themeProvider);
    final themeNotifier = ref.read(themeProvider.notifier);
    final isDark = themeMode == ThemeMode.dark;

    return ListTile(
      leading: Icon(
        isDark ? Icons.dark_mode_outlined : Icons.light_mode_outlined,
        color: theme.colorScheme.secondary,
      ),
      title: const Text('Modo oscuro'),
      trailing: Switch(
        value: isDark,
        onChanged: (value) {
          themeNotifier.setThemeMode(value ? ThemeMode.dark : ThemeMode.light);
        },
        activeColor: theme.colorScheme.primary,
      ),
    );
  }
}
