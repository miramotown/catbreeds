// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$darkModeHash() => r'54d687970391283e693e0beb87bef8e54d34d8da';

/// See also [DarkMode].
@ProviderFor(DarkMode)
final darkModeProvider = AutoDisposeNotifierProvider<DarkMode, bool>.internal(
  DarkMode.new,
  name: r'darkModeProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$darkModeHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$DarkMode = AutoDisposeNotifier<bool>;
String _$apiKeyHash() => r'db80f0806fd09e754c7c4ecbe423fcd14d962956';

/// See also [ApiKey].
@ProviderFor(ApiKey)
final apiKeyProvider = NotifierProvider<ApiKey, String>.internal(
  ApiKey.new,
  name: r'apiKeyProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$apiKeyHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ApiKey = Notifier<String>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
