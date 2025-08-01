// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'empathy_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$popularItemIdsHash() => r'206984ccdcbca2f7eb4d13e1e9d6e903132c1373';

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

/// See also [popularItemIds].
@ProviderFor(popularItemIds)
const popularItemIdsProvider = PopularItemIdsFamily();

/// See also [popularItemIds].
class PopularItemIdsFamily extends Family<AsyncValue<List<String>>> {
  /// See also [popularItemIds].
  const PopularItemIdsFamily();

  /// See also [popularItemIds].
  PopularItemIdsProvider call({
    int limit = 20,
    EmpathyType? filterByType,
  }) {
    return PopularItemIdsProvider(
      limit: limit,
      filterByType: filterByType,
    );
  }

  @override
  PopularItemIdsProvider getProviderOverride(
    covariant PopularItemIdsProvider provider,
  ) {
    return call(
      limit: provider.limit,
      filterByType: provider.filterByType,
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
  String? get name => r'popularItemIdsProvider';
}

/// See also [popularItemIds].
class PopularItemIdsProvider extends AutoDisposeFutureProvider<List<String>> {
  /// See also [popularItemIds].
  PopularItemIdsProvider({
    int limit = 20,
    EmpathyType? filterByType,
  }) : this._internal(
          (ref) => popularItemIds(
            ref as PopularItemIdsRef,
            limit: limit,
            filterByType: filterByType,
          ),
          from: popularItemIdsProvider,
          name: r'popularItemIdsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$popularItemIdsHash,
          dependencies: PopularItemIdsFamily._dependencies,
          allTransitiveDependencies:
              PopularItemIdsFamily._allTransitiveDependencies,
          limit: limit,
          filterByType: filterByType,
        );

  PopularItemIdsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.limit,
    required this.filterByType,
  }) : super.internal();

  final int limit;
  final EmpathyType? filterByType;

  @override
  Override overrideWith(
    FutureOr<List<String>> Function(PopularItemIdsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PopularItemIdsProvider._internal(
        (ref) => create(ref as PopularItemIdsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        limit: limit,
        filterByType: filterByType,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<String>> createElement() {
    return _PopularItemIdsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PopularItemIdsProvider &&
        other.limit == limit &&
        other.filterByType == filterByType;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, limit.hashCode);
    hash = _SystemHash.combine(hash, filterByType.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin PopularItemIdsRef on AutoDisposeFutureProviderRef<List<String>> {
  /// The parameter `limit` of this provider.
  int get limit;

  /// The parameter `filterByType` of this provider.
  EmpathyType? get filterByType;
}

class _PopularItemIdsProviderElement
    extends AutoDisposeFutureProviderElement<List<String>>
    with PopularItemIdsRef {
  _PopularItemIdsProviderElement(super.provider);

  @override
  int get limit => (origin as PopularItemIdsProvider).limit;
  @override
  EmpathyType? get filterByType =>
      (origin as PopularItemIdsProvider).filterByType;
}

String _$empathyTypeStatsHash() => r'55b367ab985a24e21d08a10f0705130ab099b28b';

/// See also [empathyTypeStats].
@ProviderFor(empathyTypeStats)
const empathyTypeStatsProvider = EmpathyTypeStatsFamily();

/// See also [empathyTypeStats].
class EmpathyTypeStatsFamily extends Family<AsyncValue<Map<EmpathyType, int>>> {
  /// See also [empathyTypeStats].
  const EmpathyTypeStatsFamily();

  /// See also [empathyTypeStats].
  EmpathyTypeStatsProvider call(
    String itemId,
  ) {
    return EmpathyTypeStatsProvider(
      itemId,
    );
  }

  @override
  EmpathyTypeStatsProvider getProviderOverride(
    covariant EmpathyTypeStatsProvider provider,
  ) {
    return call(
      provider.itemId,
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
  String? get name => r'empathyTypeStatsProvider';
}

/// See also [empathyTypeStats].
class EmpathyTypeStatsProvider
    extends AutoDisposeFutureProvider<Map<EmpathyType, int>> {
  /// See also [empathyTypeStats].
  EmpathyTypeStatsProvider(
    String itemId,
  ) : this._internal(
          (ref) => empathyTypeStats(
            ref as EmpathyTypeStatsRef,
            itemId,
          ),
          from: empathyTypeStatsProvider,
          name: r'empathyTypeStatsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$empathyTypeStatsHash,
          dependencies: EmpathyTypeStatsFamily._dependencies,
          allTransitiveDependencies:
              EmpathyTypeStatsFamily._allTransitiveDependencies,
          itemId: itemId,
        );

  EmpathyTypeStatsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.itemId,
  }) : super.internal();

  final String itemId;

  @override
  Override overrideWith(
    FutureOr<Map<EmpathyType, int>> Function(EmpathyTypeStatsRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: EmpathyTypeStatsProvider._internal(
        (ref) => create(ref as EmpathyTypeStatsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        itemId: itemId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Map<EmpathyType, int>> createElement() {
    return _EmpathyTypeStatsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is EmpathyTypeStatsProvider && other.itemId == itemId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, itemId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin EmpathyTypeStatsRef
    on AutoDisposeFutureProviderRef<Map<EmpathyType, int>> {
  /// The parameter `itemId` of this provider.
  String get itemId;
}

class _EmpathyTypeStatsProviderElement
    extends AutoDisposeFutureProviderElement<Map<EmpathyType, int>>
    with EmpathyTypeStatsRef {
  _EmpathyTypeStatsProviderElement(super.provider);

  @override
  String get itemId => (origin as EmpathyTypeStatsProvider).itemId;
}

String _$empathyActionsHash() => r'1658a8b7daba1fbb94ffc069ec24ef54b7cc2b6e';

/// See also [empathyActions].
@ProviderFor(empathyActions)
final empathyActionsProvider = AutoDisposeProvider<EmpathyActions>.internal(
  empathyActions,
  name: r'empathyActionsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$empathyActionsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef EmpathyActionsRef = AutoDisposeProviderRef<EmpathyActions>;
String _$userEmpathyListHash() => r'2c1e04be8e1dd764feb870ec478846b4e576958f';

/// See also [UserEmpathyList].
@ProviderFor(UserEmpathyList)
final userEmpathyListProvider =
    AutoDisposeAsyncNotifierProvider<UserEmpathyList, List<Empathy>>.internal(
  UserEmpathyList.new,
  name: r'userEmpathyListProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$userEmpathyListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$UserEmpathyList = AutoDisposeAsyncNotifier<List<Empathy>>;
String _$itemEmpathyStatsHash() => r'4120568aafd25ee205c7b35a74b8d77095ede1ba';

abstract class _$ItemEmpathyStats
    extends BuildlessAutoDisposeAsyncNotifier<EmpathyStats> {
  late final String itemId;

  FutureOr<EmpathyStats> build(
    String itemId,
  );
}

/// See also [ItemEmpathyStats].
@ProviderFor(ItemEmpathyStats)
const itemEmpathyStatsProvider = ItemEmpathyStatsFamily();

/// See also [ItemEmpathyStats].
class ItemEmpathyStatsFamily extends Family<AsyncValue<EmpathyStats>> {
  /// See also [ItemEmpathyStats].
  const ItemEmpathyStatsFamily();

  /// See also [ItemEmpathyStats].
  ItemEmpathyStatsProvider call(
    String itemId,
  ) {
    return ItemEmpathyStatsProvider(
      itemId,
    );
  }

  @override
  ItemEmpathyStatsProvider getProviderOverride(
    covariant ItemEmpathyStatsProvider provider,
  ) {
    return call(
      provider.itemId,
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
  String? get name => r'itemEmpathyStatsProvider';
}

/// See also [ItemEmpathyStats].
class ItemEmpathyStatsProvider extends AutoDisposeAsyncNotifierProviderImpl<
    ItemEmpathyStats, EmpathyStats> {
  /// See also [ItemEmpathyStats].
  ItemEmpathyStatsProvider(
    String itemId,
  ) : this._internal(
          () => ItemEmpathyStats()..itemId = itemId,
          from: itemEmpathyStatsProvider,
          name: r'itemEmpathyStatsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$itemEmpathyStatsHash,
          dependencies: ItemEmpathyStatsFamily._dependencies,
          allTransitiveDependencies:
              ItemEmpathyStatsFamily._allTransitiveDependencies,
          itemId: itemId,
        );

  ItemEmpathyStatsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.itemId,
  }) : super.internal();

  final String itemId;

  @override
  FutureOr<EmpathyStats> runNotifierBuild(
    covariant ItemEmpathyStats notifier,
  ) {
    return notifier.build(
      itemId,
    );
  }

  @override
  Override overrideWith(ItemEmpathyStats Function() create) {
    return ProviderOverride(
      origin: this,
      override: ItemEmpathyStatsProvider._internal(
        () => create()..itemId = itemId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        itemId: itemId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<ItemEmpathyStats, EmpathyStats>
      createElement() {
    return _ItemEmpathyStatsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ItemEmpathyStatsProvider && other.itemId == itemId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, itemId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ItemEmpathyStatsRef on AutoDisposeAsyncNotifierProviderRef<EmpathyStats> {
  /// The parameter `itemId` of this provider.
  String get itemId;
}

class _ItemEmpathyStatsProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<ItemEmpathyStats,
        EmpathyStats> with ItemEmpathyStatsRef {
  _ItemEmpathyStatsProviderElement(super.provider);

  @override
  String get itemId => (origin as ItemEmpathyStatsProvider).itemId;
}

String _$userItemEmpathyHash() => r'594d44044714d6f8a1f9c6a628de4ec5954344b5';

abstract class _$UserItemEmpathy
    extends BuildlessAutoDisposeAsyncNotifier<bool> {
  late final String itemId;

  FutureOr<bool> build(
    String itemId,
  );
}

/// See also [UserItemEmpathy].
@ProviderFor(UserItemEmpathy)
const userItemEmpathyProvider = UserItemEmpathyFamily();

/// See also [UserItemEmpathy].
class UserItemEmpathyFamily extends Family<AsyncValue<bool>> {
  /// See also [UserItemEmpathy].
  const UserItemEmpathyFamily();

  /// See also [UserItemEmpathy].
  UserItemEmpathyProvider call(
    String itemId,
  ) {
    return UserItemEmpathyProvider(
      itemId,
    );
  }

  @override
  UserItemEmpathyProvider getProviderOverride(
    covariant UserItemEmpathyProvider provider,
  ) {
    return call(
      provider.itemId,
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
  String? get name => r'userItemEmpathyProvider';
}

/// See also [UserItemEmpathy].
class UserItemEmpathyProvider
    extends AutoDisposeAsyncNotifierProviderImpl<UserItemEmpathy, bool> {
  /// See also [UserItemEmpathy].
  UserItemEmpathyProvider(
    String itemId,
  ) : this._internal(
          () => UserItemEmpathy()..itemId = itemId,
          from: userItemEmpathyProvider,
          name: r'userItemEmpathyProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$userItemEmpathyHash,
          dependencies: UserItemEmpathyFamily._dependencies,
          allTransitiveDependencies:
              UserItemEmpathyFamily._allTransitiveDependencies,
          itemId: itemId,
        );

  UserItemEmpathyProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.itemId,
  }) : super.internal();

  final String itemId;

  @override
  FutureOr<bool> runNotifierBuild(
    covariant UserItemEmpathy notifier,
  ) {
    return notifier.build(
      itemId,
    );
  }

  @override
  Override overrideWith(UserItemEmpathy Function() create) {
    return ProviderOverride(
      origin: this,
      override: UserItemEmpathyProvider._internal(
        () => create()..itemId = itemId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        itemId: itemId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<UserItemEmpathy, bool>
      createElement() {
    return _UserItemEmpathyProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UserItemEmpathyProvider && other.itemId == itemId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, itemId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin UserItemEmpathyRef on AutoDisposeAsyncNotifierProviderRef<bool> {
  /// The parameter `itemId` of this provider.
  String get itemId;
}

class _UserItemEmpathyProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<UserItemEmpathy, bool>
    with UserItemEmpathyRef {
  _UserItemEmpathyProviderElement(super.provider);

  @override
  String get itemId => (origin as UserItemEmpathyProvider).itemId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
