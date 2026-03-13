import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/transaction.dart';
import '../../domain/repositories/transaction_repository.dart';
import '../../data/repositories/mock_transaction_repository.dart';

part 'transaction_providers.g.dart';

@riverpod
TransactionRepository transactionRepository(TransactionRepositoryRef ref) {
  return MockTransactionRepository();
}

@riverpod
class AsyncTransactions extends _$AsyncTransactions {
  @override
  Future<List<Transaction>> build() async {
    final repo = ref.watch(transactionRepositoryProvider);
    return repo.getTransactions();
  }

  Future<void> addTransaction(Transaction transaction) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(transactionRepositoryProvider);
      await repo.addTransaction(transaction);
      return repo.getTransactions();
    });
  }
}
