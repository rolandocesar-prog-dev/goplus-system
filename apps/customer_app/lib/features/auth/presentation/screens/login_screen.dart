import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_theme.dart';
import '../providers/auth_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _loginFormKey = GlobalKey<FormState>();
  final _signupFormKey = GlobalKey<FormState>();

  // Controladores para Login
  final _loginEmailController = TextEditingController();
  final _loginPasswordController = TextEditingController();

  // Controladores para Signup
  final _signupNameController = TextEditingController();
  final _signupEmailController = TextEditingController();
  final _signupPhoneController = TextEditingController();
  final _signupAddressController = TextEditingController();
  final _signupPasswordController = TextEditingController();
  final _signupConfirmPasswordController = TextEditingController();

  bool _isLoginLoading = false;
  bool _isSignupLoading = false;
  bool _obscureLoginPassword = true;
  bool _obscureSignupPassword = true;
  bool _obscureSignupConfirmPassword = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _loginEmailController.dispose();
    _loginPasswordController.dispose();
    _signupNameController.dispose();
    _signupEmailController.dispose();
    _signupPhoneController.dispose();
    _signupAddressController.dispose();
    _signupPasswordController.dispose();
    _signupConfirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final authController = ref.read(authControllerProvider);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                const SizedBox(height: 40),
                // Logo
                Icon(
                  Icons.delivery_dining,
                  size: 80,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(height: 16),
                Text(
                  'GoPlus',
                  style: theme.textTheme.displaySmall?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Servicio a domicilio',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),
                const SizedBox(height: 40),

                // Tabs
                Container(
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppTheme.greyLight),
                  ),
                  child: TabBar(
                    controller: _tabController,
                    indicator: BoxDecoration(
                      color: theme.colorScheme.primary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    labelColor: AppTheme.white,
                    unselectedLabelColor: theme.colorScheme.onSurface,
                    dividerColor: Colors.transparent,
                    tabs: const [
                      Tab(text: 'Iniciar Sesión'),
                      Tab(text: 'Registrarse'),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Tab Views
                SizedBox(
                  height: 520,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildLoginForm(context, theme, authController),
                      _buildSignupForm(context, theme, authController),
                    ],
                  ),
                ),

                const SizedBox(height: 24),
                _buildDivider(theme),
                const SizedBox(height: 24),

                // Google Sign-In
                _buildGoogleButton(context, theme, authController),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginForm(BuildContext context, ThemeData theme, AuthController authController) {
    return Form(
      key: _loginFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: _loginEmailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: 'Email',
              prefixIcon: Icon(Icons.email_outlined),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingresa tu email';
              }
              if (!value.contains('@')) {
                return 'Por favor ingresa un email válido';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _loginPasswordController,
            obscureText: _obscureLoginPassword,
            decoration: InputDecoration(
              labelText: 'Contraseña',
              prefixIcon: const Icon(Icons.lock_outline),
              suffixIcon: IconButton(
                icon: Icon(_obscureLoginPassword ? Icons.visibility_off : Icons.visibility),
                onPressed: () => setState(() => _obscureLoginPassword = !_obscureLoginPassword),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingresa tu contraseña';
              }
              return null;
            },
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _isLoginLoading ? null : () => _handleLogin(context, authController),
            child: _isLoginLoading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('Iniciar Sesión'),
          ),
        ],
      ),
    );
  }

  Widget _buildSignupForm(BuildContext context, ThemeData theme, AuthController authController) {
    return Form(
      key: _signupFormKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _signupNameController,
              decoration: const InputDecoration(
                labelText: 'Nombre completo',
                prefixIcon: Icon(Icons.person_outline),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingresa tu nombre';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _signupEmailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email_outlined),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingresa tu email';
                }
                if (!value.contains('@')) {
                  return 'Por favor ingresa un email válido';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _signupPhoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Teléfono',
                prefixIcon: Icon(Icons.phone_outlined),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingresa tu teléfono';
                }
                if (value.length < 8) {
                  return 'Por favor ingresa un número válido';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _signupAddressController,
              maxLines: 2,
              decoration: const InputDecoration(
                labelText: 'Dirección',
                prefixIcon: Icon(Icons.location_on_outlined),
                alignLabelWithHint: true,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingresa tu dirección';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _signupPasswordController,
              obscureText: _obscureSignupPassword,
              decoration: InputDecoration(
                labelText: 'Contraseña',
                prefixIcon: const Icon(Icons.lock_outline),
                suffixIcon: IconButton(
                  icon: Icon(_obscureSignupPassword ? Icons.visibility_off : Icons.visibility),
                  onPressed: () => setState(() => _obscureSignupPassword = !_obscureSignupPassword),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingresa una contraseña';
                }
                if (value.length < 6) {
                  return 'La contraseña debe tener al menos 6 caracteres';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _signupConfirmPasswordController,
              obscureText: _obscureSignupConfirmPassword,
              decoration: InputDecoration(
                labelText: 'Confirmar contraseña',
                prefixIcon: const Icon(Icons.lock_outline),
                suffixIcon: IconButton(
                  icon: Icon(_obscureSignupConfirmPassword ? Icons.visibility_off : Icons.visibility),
                  onPressed: () => setState(() => _obscureSignupConfirmPassword = !_obscureSignupConfirmPassword),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor confirma tu contraseña';
                }
                if (value != _signupPasswordController.text) {
                  return 'Las contraseñas no coinciden';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _isSignupLoading ? null : () => _handleSignup(context, authController),
              child: _isSignupLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Registrarse'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider(ThemeData theme) {
    return Row(
      children: [
        Expanded(child: Divider(color: theme.colorScheme.onSurface.withOpacity(0.2))),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'o continúa con',
            style: theme.textTheme.bodySmall,
          ),
        ),
        Expanded(child: Divider(color: theme.colorScheme.onSurface.withOpacity(0.2))),
      ],
    );
  }

  Widget _buildGoogleButton(BuildContext context, ThemeData theme, AuthController authController) {
    return OutlinedButton.icon(
      onPressed: () => _handleGoogleSignIn(context, authController),
      icon: Image.network(
        'https://www.google.com/favicon.ico',
        height: 24,
        errorBuilder: (context, error, stackTrace) => const Icon(Icons.g_mobiledata),
      ),
      label: const Text('Continuar con Google'),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 14),
        side: BorderSide(color: theme.colorScheme.onSurface.withOpacity(0.3)),
      ),
    );
  }

  Future<void> _handleLogin(BuildContext context, AuthController authController) async {
    if (!_loginFormKey.currentState!.validate()) return;

    setState(() => _isLoginLoading = true);

    try {
      await authController.signInWithEmailPassword(
        email: _loginEmailController.text,
        password: _loginPasswordController.text,
      );
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString().replaceAll('Exception: ', '')),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoginLoading = false);
    }
  }

  Future<void> _handleSignup(BuildContext context, AuthController authController) async {
    if (!_signupFormKey.currentState!.validate()) return;

    setState(() => _isSignupLoading = true);

    try {
      await authController.signUpWithEmailPassword(
        email: _signupEmailController.text,
        password: _signupPasswordController.text,
        displayName: _signupNameController.text,
        phoneNumber: _signupPhoneController.text,
        address: _signupAddressController.text,
      );
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString().replaceAll('Exception: ', '')),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isSignupLoading = false);
    }
  }

  Future<void> _handleGoogleSignIn(BuildContext context, AuthController authController) async {
    try {
      await authController.signInWithGoogle();
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString().replaceAll('Exception: ', '')),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
