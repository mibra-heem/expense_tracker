import '../../domain/entities/transaction.dart';
import '../../domain/repositories/transaction_repository.dart';

class MockTransactionRepository implements TransactionRepository {
  final List<Transaction> _transactions = [
    Transaction(
      id: '1',
      title: 'Supermarket',
      amount: 89.50,
      date: DateTime.now().subtract(const Duration(hours: 2)),
      category: 'Food',
      iconName: 'shopping_basket',
    ),
    Transaction(
      id: '2',
      title: 'Starbucks',
      amount: 12.30,
      date: DateTime.now(),
      category: 'Food',
      iconName: 'coffee',
    ),
    Transaction(
      id: '3',
      title: 'Salary',
      amount: 4800.00,
      date: DateTime.now().subtract(const Duration(days: 1)),
      category: 'Work',
      isCredit: true,
      iconName: 'work',
    ),
  ];

  @override
  Future<List<Transaction>> getTransactions() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _transactions;
  }

  @override
  Future<void> addTransaction(Transaction transaction) async {
    _transactions.insert(0, transaction);
  }

  @override
  Future<void> deleteTransaction(String id) async {
    _transactions.removeWhere((tx) => tx.id == id);
  }
}
