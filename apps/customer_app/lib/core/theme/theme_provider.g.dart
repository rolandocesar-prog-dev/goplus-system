// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider para gestionar el modo de tema (claro/oscuro)

@ProviderFor(ThemeNotifier)
const themeProvider = ThemeNotifierProvider._();

/// Provider para gestionar el modo de tema (claro/oscuro)
final class ThemeNotifierProvider
    extends $NotifierProvider<ThemeNotifier, ThemeMode> {
  /// Provider para gestionar el modo de tema (claro/oscuro)
  const ThemeNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'themeProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$themeNotifierHash();

  @$internal
  @override
  ThemeNotifier create() => ThemeNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ThemeMode value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ThemeMode>(value),
    );
  }
}

String _$themeNotifierHash() => r'1e7e06cc4ec61a5c73491d7cd841f498c88b07fc';

/// Provider para gestionar el modo de tema (claro/oscuro)

abstract class _$ThemeNotifier extends $Notifier<ThemeMode> {
  ThemeMode build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<ThemeMode, ThemeMode>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ThemeMode, ThemeMode>,
              ThemeMode,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
