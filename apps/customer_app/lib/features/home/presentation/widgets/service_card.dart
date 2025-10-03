import 'package:flutter/material.dart';

class ServiceCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Gradient gradient;
  final VoidCallback onTap;

  const ServiceCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.gradient,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        // ✅ Quitar altura fija, dejar que el contenido determine la altura
        constraints: const BoxConstraints(
          minHeight: 140,  // Altura mínima para consistencia
        ),
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.primary.withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: ClipRRect(  // ✅ Clip para evitar overflow del ícono decorativo
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              // Icono decorativo de fondo
              Positioned(
                right: -30,  // ✅ Ajustado para que no sobresalga tanto
                bottom: -30,
                child: Icon(
                  icon,
                  size: 120,  // ✅ Reducido de 140 a 120
                  color: Colors.white.withOpacity(0.12),  // ✅ Más sutil
                ),
              ),
              // Contenido
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,  // ✅ Importante: ajustar al contenido
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.25),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        icon,
                        size: 28,  // ✅ Reducido de 32 a 28
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      title,
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,  // ✅ Tamaño controlado
                      ),
                      maxLines: 1,  // ✅ Máximo 1 línea para el título
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),  // ✅ Reducido de 4 a 6
                    Text(
                      description,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 13,  // ✅ Tamaño controlado
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              // Flecha indicadora
              Positioned(
                right: 16,
                top: 16,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.25),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.arrow_forward_rounded,
                    size: 18,  // ✅ Reducido de 20 a 18
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}