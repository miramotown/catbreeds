// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cat_breeds_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$listCatBreedsHash() => r'5a6fc8ba0ccec9a42a695602fedbbf02a99eb284';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [listCatBreeds].
@ProviderFor(listCatBreeds)
const listCatBreedsProvider = ListCatBreedsFamily();

/// See also [listCatBreeds].
class ListCatBreedsFamily extends Family<AsyncValue<List<CatBreedEntity>>> {
  /// See also [listCatBreeds].
  const ListCatBreedsFamily();

  /// See also [listCatBreeds].
  ListCatBreedsProvider call(
    int page,
  ) {
    return ListCatBreedsProvider(
      page,
    );
  }

  @override
  ListCatBreedsProvider getProviderOverride(
    covariant ListCatBreedsProvider provider,
  ) {
    return call(
      provider.page,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'listCatBreedsProvider';
}

/// See also [listCatBreeds].
class ListCatBreedsProvider
    extends AutoDisposeFutureProvider<List<CatBreedEntity>> {
  /// See also [listCatBreeds].
  ListCatBreedsProvider(
    int page,
  ) : this._internal(
          (ref) => listCatBreeds(
            ref as ListCatBreedsRef,
            page,
          ),
          from: listCatBreedsProvider,
          name: r'listCatBreedsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$listCatBreedsHash,
          dependencies: ListCatBreedsFamily._dependencies,
          allTransitiveDependencies:
              ListCatBreedsFamily._allTransitiveDependencies,
          page: page,
        );

  ListCatBreedsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.page,
  }) : super.internal();

  final int page;

  @override
  Override overrideWith(
    FutureOr<List<CatBreedEntity>> Function(ListCatBreedsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ListCatBreedsProvider._internal(
        (ref) => create(ref as ListCatBreedsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        page: page,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<CatBreedEntity>> createElement() {
    return _ListCatBreedsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ListCatBreedsProvider && other.page == page;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, page.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ListCatBreedsRef on AutoDisposeFutureProviderRef<List<CatBreedEntity>> {
  /// The parameter `page` of this provider.
  int get page;
}

class _ListCatBreedsProviderElement
    extends AutoDisposeFutureProviderElement<List<CatBreedEntity>>
    with ListCatBreedsRef {
  _ListCatBreedsProviderElement(super.provider);

  @override
  int get page => (origin as ListCatBreedsProvider).page;
}

String _$listBreedHash() => r'45a35d97c82b82d5c3e16efeb86ede88a735f36c';

/// See also [ListBreed].
@ProviderFor(ListBreed)
final listBreedProvider =
    NotifierProvider<ListBreed, List<CatBreedEntity>>.internal(
  ListBreed.new,
  name: r'listBreedProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$listBreedHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ListBreed = Notifier<List<CatBreedEntity>>;
String _$catBreedPageHash() => r'542f6a3d2224d1dd9742402d80b647456f125990';

/// See also [CatBreedPage].
@ProviderFor(CatBreedPage)
final catBreedPageProvider = NotifierProvider<CatBreedPage, int>.internal(
  CatBreedPage.new,
  name: r'catBreedPageProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$catBreedPageHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CatBreedPage = Notifier<int>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
