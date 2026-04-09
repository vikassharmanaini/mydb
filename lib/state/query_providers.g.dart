// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'query_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$queryServiceForHash() => r'2251b65fc0302308c22f727278a0385bc4803625';

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

/// [QueryService] for an open connection, or `null` if [connectionId] is not live.
///
/// Copied from [queryServiceFor].
@ProviderFor(queryServiceFor)
const queryServiceForProvider = QueryServiceForFamily();

/// [QueryService] for an open connection, or `null` if [connectionId] is not live.
///
/// Copied from [queryServiceFor].
class QueryServiceForFamily extends Family<AsyncValue<QueryService?>> {
  /// [QueryService] for an open connection, or `null` if [connectionId] is not live.
  ///
  /// Copied from [queryServiceFor].
  const QueryServiceForFamily();

  /// [QueryService] for an open connection, or `null` if [connectionId] is not live.
  ///
  /// Copied from [queryServiceFor].
  QueryServiceForProvider call(
    String connectionId,
  ) {
    return QueryServiceForProvider(
      connectionId,
    );
  }

  @override
  QueryServiceForProvider getProviderOverride(
    covariant QueryServiceForProvider provider,
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
  String? get name => r'queryServiceForProvider';
}

/// [QueryService] for an open connection, or `null` if [connectionId] is not live.
///
/// Copied from [queryServiceFor].
class QueryServiceForProvider extends FutureProvider<QueryService?> {
  /// [QueryService] for an open connection, or `null` if [connectionId] is not live.
  ///
  /// Copied from [queryServiceFor].
  QueryServiceForProvider(
    String connectionId,
  ) : this._internal(
          (ref) => queryServiceFor(
            ref as QueryServiceForRef,
            connectionId,
          ),
          from: queryServiceForProvider,
          name: r'queryServiceForProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$queryServiceForHash,
          dependencies: QueryServiceForFamily._dependencies,
          allTransitiveDependencies:
              QueryServiceForFamily._allTransitiveDependencies,
          connectionId: connectionId,
        );

  QueryServiceForProvider._internal(
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
    FutureOr<QueryService?> Function(QueryServiceForRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: QueryServiceForProvider._internal(
        (ref) => create(ref as QueryServiceForRef),
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
  FutureProviderElement<QueryService?> createElement() {
    return _QueryServiceForProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is QueryServiceForProvider &&
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
mixin QueryServiceForRef on FutureProviderRef<QueryService?> {
  /// The parameter `connectionId` of this provider.
  String get connectionId;
}

class _QueryServiceForProviderElement
    extends FutureProviderElement<QueryService?> with QueryServiceForRef {
  _QueryServiceForProviderElement(super.provider);

  @override
  String get connectionId => (origin as QueryServiceForProvider).connectionId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
