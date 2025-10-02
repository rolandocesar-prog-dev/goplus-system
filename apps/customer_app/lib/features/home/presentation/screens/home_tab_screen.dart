import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../widgets/service_card.dart';

class HomeTabScreen extends ConsumerWidget {
  const HomeTabScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(authStateProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('GoPlus'),
        elevation: 0,
      ),
      body: userAsync.when(
        data: (user) {
          if (user == null) {
            return const Center(child: Text('No hay usuario autenticado'));
          }
          return CustomScrollView(
            slivers: [
              // Header con saludo
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '¡Hola, ${user.displayName?.split(' ').first ?? "Usuario"}!',
                        style: theme.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '¿Qué servicio necesitas hoy?',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.colorScheme.secondary.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Servicios principales
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Nuestros Servicios',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),

              // Cards de servicios
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    ServiceCard(
                      icon: Icons.restaurant_rounded,
                      title: 'Delivery de Comida',
                      description: 'Pide comida de tus restaurantes favoritos',
                      gradient: LinearGradient(
                        colors: [
                          theme.colorScheme.primary,
                          theme.colorScheme.primary.withOpacity(0.7),
                        ],
                      ),
                      onTap: () {
                        // TODO: Navegar a delivery de comida
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Delivery de comida próximamente'),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    ServiceCard(
                      icon: Icons.engineering_rounded,
                      title: 'Profesionales',
                      description: 'Encuentra expertos: abogados, carpinteros y más',
                      gradient: LinearGradient(
                        colors: [
                          theme.colorScheme.secondary,
                          theme.colorScheme.secondary.withOpacity(0.8),
                        ],
                      ),
                      onTap: () {
                        // TODO: Navegar a profesionales
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Directorio de profesionales próximamente'),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    ServiceCard(
                      icon: Icons.store_rounded,
                      title: 'Negocios Locales',
                      description: 'Descubre farmacias, ferreterías y más cerca de ti',
                      gradient: LinearGradient(
                        colors: [
                          theme.colorScheme.primary.withOpacity(0.8),
                          theme.colorScheme.primary.withOpacity(0.6),
                        ],
                      ),
                      onTap: () {
                        // TODO: Navegar a negocios locales
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Negocios locales próximamente'),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 24),
                  ]),
                ),
              ),

              // Sección de acceso rápido
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Acceso Rápido',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: _QuickAccessCard(
                              icon: Icons.history_rounded,
                              label: 'Recientes',
                              onTap: () {
                                // TODO: Ver recientes
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _QuickAccessCard(
                              icon: Icons.favorite_rounded,
                              label: 'Favoritos',
                              onTap: () {
                                // TODO: Ver favoritos
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
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

class _QuickAccessCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _QuickAccessCard({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: theme.colorScheme.secondary.withOpacity(0.1),
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 32,
              color: theme.colorScheme.primary,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
