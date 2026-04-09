// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schema_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$schemaMetaCacheHash() => r'382fa2bfb86017bce6a1558ddbf23f6db6e1cafe';

/// See also [schemaMetaCache].
@ProviderFor(schemaMetaCache)
final schemaMetaCacheProvider = Provider<SchemaMetaCache>.internal(
  schemaMetaCache,
  name: r'schemaMetaCacheProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$schemaMetaCacheHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SchemaMetaCacheRef = ProviderRef<SchemaMetaCache>;
String _$schemaServiceHash() => r'd94b3e22de03dab4008f90194d8afbbc4eea6669';

/// See also [schemaService].
@ProviderFor(schemaService)
final schemaServiceProvider = Provider<SchemaService>.internal(
  schemaService,
  name: r'schemaServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$schemaServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SchemaServiceRef = ProviderRef<SchemaService>;
String _$explorerSchemasHash() => r'2ea75c1140cb57472260a5ab2ef2b48c6d4f7ccd';

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

/// Schemas for the object tree (cached inside [SchemaService]).
///
/// Copied from [explorerSchemas].
@ProviderFor(explorerSchemas)
const explorerSchemasProvider = ExplorerSchemasFamily();

/// Schemas for the object tree (cached inside [SchemaService]).
///
/// Copied from [explorerSchemas].
class ExplorerSchemasFamily extends Family<AsyncValue<List<SchemaInfo>>> {
  /// Schemas for the object tree (cached inside [SchemaService]).
  ///
  /// Copied from [explorerSchemas].
  const ExplorerSchemasFamily();

  /// Schemas for the object tree (cached inside [SchemaService]).
  ///
  /// Copied from [explorerSchemas].
  ExplorerSchemasProvider call(
    String connectionId,
  ) {
    return ExplorerSchemasProvider(
      connectionId,
    );
  }

  @override
  ExplorerSchemasProvider getProviderOverride(
    covariant ExplorerSchemasProvider provider,
  ) {
    return call(
      provider.connectionId,
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
  String? get name => r'explorerSchemasProvider';
}

/// Schemas for the object tree (cached inside [SchemaService]).
///
/// Copied from [explorerSchemas].
class ExplorerSchemasProvider extends FutureProvider<List<SchemaInfo>> {
  /// Schemas for the object tree (cached inside [SchemaService]).
  ///
  /// Copied from [explorerSchemas].
  ExplorerSchemasProvider(
    String connectionId,
  ) : this._internal(
          (ref) => explorerSchemas(
            ref as ExplorerSchemasRef,
            connectionId,
          ),
          from: explorerSchemasProvider,
          name: r'explorerSchemasProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$explorerSchemasHash,
          dependencies: ExplorerSchemasFamily._dependencies,
          allTransitiveDependencies:
              ExplorerSchemasFamily._allTransitiveDependencies,
          connectionId: connectionId,
        );

  ExplorerSchemasProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.connectionId,
  }) : super.internal();

  final String connectionId;

  @override
  Override overrideWith(
    FutureOr<List<SchemaInfo>> Function(ExplorerSchemasRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ExplorerSchemasProvider._internal(
        (ref) => create(ref as ExplorerSchemasRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        connectionId: connectionId,
      ),
    );
  }

  @override
  FutureProviderElement<List<SchemaInfo>> createElement() {
    return _ExplorerSchemasProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ExplorerSchemasProvider &&
        other.connectionId == connectionId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, connectionId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ExplorerSchemasRef on FutureProviderRef<List<SchemaInfo>> {
  /// The parameter `connectionId` of this provider.
  String get connectionId;
}

class _ExplorerSchemasProviderElement
    extends FutureProviderElement<List<SchemaInfo>> with ExplorerSchemasRef {
  _ExplorerSchemasProviderElement(super.provider);

  @override
  String get connectionId => (origin as ExplorerSchemasProvider).connectionId;
}

String _$explorerTablesHash() => r'87e05630c84d16ded9f016ed8078d3239dad746e';

/// Tables under a schema; cache key is `connectionId|schema`.
///
/// Copied from [explorerTables].
@ProviderFor(explorerTables)
const explorerTablesProvider = ExplorerTablesFamily();

/// Tables under a schema; cache key is `connectionId|schema`.
///
/// Copied from [explorerTables].
class ExplorerTablesFamily extends Family<AsyncValue<List<TableInfo>>> {
  /// Tables under a schema; cache key is `connectionId|schema`.
  ///
  /// Copied from [explorerTables].
  const ExplorerTablesFamily();

  /// Tables under a schema; cache key is `connectionId|schema`.
  ///
  /// Copied from [explorerTables].
  ExplorerTablesProvider call(
    String cacheKey,
  ) {
    return ExplorerTablesProvider(
      cacheKey,
    );
  }

  @override
  ExplorerTablesProvider getProviderOverride(
    covariant ExplorerTablesProvider provider,
  ) {
    return call(
      provider.cacheKey,
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
  String? get name => r'explorerTablesProvider';
}

/// Tables under a schema; cache key is `connectionId|schema`.
///
/// Copied from [explorerTables].
class ExplorerTablesProvider extends FutureProvider<List<TableInfo>> {
  /// Tables under a schema; cache key is `connectionId|schema`.
  ///
  /// Copied from [explorerTables].
  ExplorerTablesProvider(
    String cacheKey,
  ) : this._internal(
          (ref) => explorerTables(
            ref as ExplorerTablesRef,
            cacheKey,
          ),
          from: explorerTablesProvider,
          name: r'explorerTablesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$explorerTablesHash,
          dependencies: ExplorerTablesFamily._dependencies,
          allTransitiveDependencies:
              ExplorerTablesFamily._allTransitiveDependencies,
          cacheKey: cacheKey,
        );

  ExplorerTablesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.cacheKey,
  }) : super.internal();

  final String cacheKey;

  @override
  Override overrideWith(
    FutureOr<List<TableInfo>> Function(ExplorerTablesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ExplorerTablesProvider._internal(
        (ref) => create(ref as ExplorerTablesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        cacheKey: cacheKey,
      ),
    );
  }

  @override
  FutureProviderElement<List<TableInfo>> createElement() {
    return _ExplorerTablesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ExplorerTablesProvider && other.cacheKey == cacheKey;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, cacheKey.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ExplorerTablesRef on FutureProviderRef<List<TableInfo>> {
  /// The parameter `cacheKey` of this provider.
  String get cacheKey;
}

class _ExplorerTablesProviderElement
    extends FutureProviderElement<List<TableInfo>> with ExplorerTablesRef {
  _ExplorerTablesProviderElement(super.provider);

  @override
  String get cacheKey => (origin as ExplorerTablesProvider).cacheKey;
}

String _$schemaKeywordsHash() => r'3e79cd14fe17118cfc9ba2175cbc476b0e0b9e49';

/// Keywords for autocomplete: schema + table names (best-effort).
///
/// Copied from [schemaKeywords].
@ProviderFor(schemaKeywords)
const schemaKeywordsProvider = SchemaKeywordsFamily();

/// Keywords for autocomplete: schema + table names (best-effort).
///
/// Copied from [schemaKeywords].
class SchemaKeywordsFamily extends Family<AsyncValue<List<String>>> {
  /// Keywords for autocomplete: schema + table names (best-effort).
  ///
  /// Copied from [schemaKeywords].
  const SchemaKeywordsFamily();

  /// Keywords for autocomplete: schema + table names (best-effort).
  ///
  /// Copied from [schemaKeywords].
  SchemaKeywordsProvider call(
    String connectionId,
  ) {
    return SchemaKeywordsProvider(
      connectionId,
    );
  }

  @override
  SchemaKeywordsProvider getProviderOverride(
    covariant SchemaKeywordsProvider provider,
  ) {
    return call(
      provider.connectionId,
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
  String? get name => r'schemaKeywordsProvider';
}

/// Keywords for autocomplete: schema + table names (best-effort).
///
/// Copied from [schemaKeywords].
class SchemaKeywordsProvider extends FutureProvider<List<String>> {
  /// Keywords for autocomplete: schema + table names (best-effort).
  ///
  /// Copied from [schemaKeywords].
  SchemaKeywordsProvider(
    String connectionId,
  ) : this._internal(
          (ref) => schemaKeywords(
            ref as SchemaKeywordsRef,
            connectionId,
          ),
          from: schemaKeywordsProvider,
          name: r'schemaKeywordsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$schemaKeywordsHash,
          dependencies: SchemaKeywordsFamily._dependencies,
          allTransitiveDependencies:
              SchemaKeywordsFamily._allTransitiveDependencies,
          connectionId: connectionId,
        );

  SchemaKeywordsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.connectionId,
  }) : super.internal();

  final String connectionId;

  @override
  Override overrideWith(
    FutureOr<List<String>> Function(SchemaKeywordsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SchemaKeywordsProvider._internal(
        (ref) => create(ref as SchemaKeywordsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        connectionId: connectionId,
      ),
    );
  }

  @override
  FutureProviderElement<List<String>> createElement() {
    return _SchemaKeywordsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SchemaKeywordsProvider &&
        other.connectionId == connectionId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, connectionId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SchemaKeywordsRef on FutureProviderRef<List<String>> {
  /// The parameter `connectionId` of this provider.
  String get connectionId;
}

class _SchemaKeywordsProviderElement extends FutureProviderElement<List<String>>
    with SchemaKeywordsRef {
  _SchemaKeywordsProviderElement(super.provider);

  @override
  String get connectionId => (origin as SchemaKeywordsProvider).connectionId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
