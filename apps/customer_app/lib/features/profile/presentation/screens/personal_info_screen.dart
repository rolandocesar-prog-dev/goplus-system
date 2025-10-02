import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../auth/presentation/providers/auth_provider.dart';

class PersonalInfoScreen extends ConsumerWidget {
  const PersonalInfoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(authStateProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Información Personal'),
      ),
      body: userAsync.when(
        data: (user) {
          if (user == null) {
            return const Center(child: Text('No hay usuario autenticado'));
          }

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Avatar Section
              Center(
                child: Stack(
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
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: CircleAvatar(
                        radius: 18,
                        backgroundColor: theme.colorScheme.primary,
                        child: Icon(
                          Icons.camera_alt_rounded,
                          size: 18,
                          color: theme.colorScheme.onPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Información del Usuario
              _buildSectionTitle('Información Básica', theme),
              const SizedBox(height: 16),

              _InfoCard(
                icon: Icons.person_outline_rounded,
                label: 'Nombre completo',
                value: user.displayName ?? 'No especificado',
                theme: theme,
              ),
              const SizedBox(height: 12),

              _InfoCard(
                icon: Icons.email_outlined,
                label: 'Correo electrónico',
                value: user.email,
                theme: theme,
              ),
              const SizedBox(height: 12),

              _InfoCard(
                icon: Icons.phone_outlined,
                label: 'Teléfono',
                value: user.phoneNumber ?? 'No especificado',
                theme: theme,
              ),

              const SizedBox(height: 32),
              _buildSectionTitle('Cuenta', theme),
              const SizedBox(height: 16),

              _InfoCard(
                icon: Icons.verified_user_outlined,
                label: 'ID de Usuario',
                value: user.uid,
                theme: theme,
              ),
              const SizedBox(height: 12),

              _InfoCard(
                icon: Icons.check_circle_outline_rounded,
                label: 'Estado de la cuenta',
                value: user.isActive ? 'Activa' : 'Inactiva',
                theme: theme,
                valueColor: user.isActive
                    ? theme.colorScheme.primary
                    : theme.colorScheme.error,
              ),
              const SizedBox(height: 12),

              if (user.createdAt != null) ...[
                _InfoCard(
                  icon: Icons.calendar_today_outlined,
                  label: 'Miembro desde',
                  value: DateFormat('dd/MM/yyyy').format(user.createdAt!),
                  theme: theme,
                ),
                const SizedBox(height: 12),
              ],

              if (user.updatedAt != null) ...[
                _InfoCard(
                  icon: Icons.update_rounded,
                  label: 'Última actualización',
                  value: DateFormat('dd/MM/yyyy HH:mm').format(user.updatedAt!),
                  theme: theme,
                ),
              ],

              const SizedBox(height: 32),

              // Botón de editar
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    // TODO: Implementar edición de perfil
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Función de edición próximamente'),
                      ),
                    );
                  },
                  icon: const Icon(Icons.edit_rounded),
                  label: const Text('Editar Información'),
                ),
              ),
              const SizedBox(height: 16),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline_rounded,
                size: 64,
                color: theme.colorScheme.error,
              ),
              const SizedBox(height: 16),
              Text(
                'Error al cargar la información',
                style: theme.textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                error.toString(),
                style: theme.textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, ThemeData theme) {
    return Text(
      title,
      style: theme.textTheme.titleMedium?.copyWith(
        color: theme.colorScheme.primary,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final ThemeData theme;
  final Color? valueColor;

  const _InfoCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.theme,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.colorScheme.secondary.withOpacity(0.1),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: theme.colorScheme.primary,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.secondary.withOpacity(0.6),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: valueColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
