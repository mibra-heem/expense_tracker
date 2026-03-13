// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$transactionRepositoryHash() =>
    r'717624899ec36f52a2983bbeba60b8117a65d217';

/// See also [transactionRepository].
@ProviderFor(transactionRepository)
final transactionRepositoryProvider =
    AutoDisposeProvider<TransactionRepository>.internal(
      transactionRepository,
      name: r'transactionRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$transactionRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TransactionRepositoryRef =
    AutoDisposeProviderRef<TransactionRepository>;
String _$asyncTransactionsHash() => r'f8eb3337b417ea7cde0e076bccc4356d09827209';

/// See also [AsyncTransactions].
@ProviderFor(AsyncTransactions)
final asyncTransactionsProvider =
    AutoDisposeAsyncNotifierProvider<
      AsyncTransactions,
      List<Transaction>
    >.internal(
      AsyncTransactions.new,
      name: r'asyncTransactionsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$asyncTransactionsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$AsyncTransactions = AutoDisposeAsyncNotifier<List<Transaction>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
