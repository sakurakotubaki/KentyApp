// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dio_generator.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$futureGeneratorHash() => r'4001871eae1e0094e53ff70a3e9c83afe1e9545d';

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

typedef FutureGeneratorRef = AutoDisposeFutureProviderRef<List<Post>?>;

/// See also [futureGenerator].
@ProviderFor(futureGenerator)
const futureGeneratorProvider = FutureGeneratorFamily();

/// See also [futureGenerator].
class FutureGeneratorFamily extends Family<AsyncValue<List<Post>?>> {
  /// See also [futureGenerator].
  const FutureGeneratorFamily();

  /// See also [futureGenerator].
  FutureGeneratorProvider call(
    dynamic ref,
  ) {
    return FutureGeneratorProvider(
      ref,
    );
  }

  @override
  FutureGeneratorProvider getProviderOverride(
    covariant FutureGeneratorProvider provider,
  ) {
    return call(
      provider.ref,
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
  String? get name => r'futureGeneratorProvider';
}

/// See also [futureGenerator].
class FutureGeneratorProvider extends AutoDisposeFutureProvider<List<Post>?> {
  /// See also [futureGenerator].
  FutureGeneratorProvider(
    this.ref,
  ) : super.internal(
          (ref) => futureGenerator(
            ref,
            ref,
          ),
          from: futureGeneratorProvider,
          name: r'futureGeneratorProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$futureGeneratorHash,
          dependencies: FutureGeneratorFamily._dependencies,
          allTransitiveDependencies:
              FutureGeneratorFamily._allTransitiveDependencies,
        );

  final dynamic ref;

  @override
  bool operator ==(Object other) {
    return other is FutureGeneratorProvider && other.ref == ref;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, ref.hashCode);

    return _SystemHash.finish(hash);
  }
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member
