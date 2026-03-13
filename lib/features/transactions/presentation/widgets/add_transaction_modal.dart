import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../domain/entities/transaction.dart';
import '../providers/transaction_providers.dart';

class AddTransactionModal extends ConsumerStatefulWidget {
  const AddTransactionModal({super.key});

  @override
  ConsumerState<AddTransactionModal> createState() =>
      _AddTransactionModalState();
}

class _AddTransactionModalState extends ConsumerState<AddTransactionModal> {
  String _amount = "0.00";
  String _activeCategory = "Housing";
  bool _attachReceipt = false;
  String _note = "";

  void _onKeyTap(String value) {
    HapticFeedback.lightImpact();
    setState(() {
      if (value == ".") {
        if (!_amount.contains(".")) {
          _amount += ".";
        }
      } else {
        if (_amount == "0.00") {
          _amount = value;
        } else if (_amount == "0") {
          _amount = value;
        } else {
          // Limit to 2 decimal places
          if (_amount.contains(".")) {
            final parts = _amount.split(".");
            if (parts[1].length < 2) {
              _amount += value;
            }
          } else {
            _amount += value;
          }
        }
      }
    });
  }

  void _onBackspace() {
    HapticFeedback.mediumImpact();
    setState(() {
      if (_amount.length > 1) {
        _amount = _amount.substring(0, _amount.length - 1);
        if (_amount.endsWith(".")) {
          // Keep the dot if we want, or remove it. Let's keep it consistent.
        }
      } else {
        _amount = "0.00";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final backgroundColor = isDark ? const Color(0xFF121212) : Colors.white;

    return Container(
      height: MediaQuery.of(context).size.height * 0.95,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        children: [
          _buildHeader(context, isDark),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(height: 32),
                  _buildAmountSection(isDark),
                  const SizedBox(height: 32),
                  _buildDateSelector(isDark),
                  const SizedBox(height: 48),
                  _buildCategorySection(isDark),
                  const SizedBox(height: 32),
                  _buildAttachReceiptToggle(isDark),
                  const SizedBox(height: 32),
                  _buildNumericKeypad(isDark),
                  const SizedBox(height: 24),
                  _buildNoteField(isDark),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool isDark) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(
              Icons.close_rounded,
              color: isDark ? Colors.white70 : Colors.black54,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          const Text(
            'New Expense',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          TextButton(
            onPressed: _handleSave,
            child: const Text(
              'SAVE',
              style: TextStyle(
                color: Color(0xFF6C63FF),
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAmountSection(bool isDark) {
    return Column(
      children: [
        Text(
          'AMOUNT',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.grey.withValues(alpha: 0.6),
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              '\$',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.grey.withValues(alpha: 0.4),
              ),
            ),
            const SizedBox(width: 4),
            Text(
              _amount,
              style: TextStyle(
                fontSize: 64,
                fontWeight: FontWeight.bold,
                color: _amount.startsWith("0")
                    ? Colors.grey.withValues(alpha: 0.4)
                    : isDark
                    ? Colors.white
                    : const Color(0xFF0F172A),
              ),
            ),
          ],
        ),
      ],
    ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1, end: 0);
  }

  Widget _buildDateSelector(bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.05)
            : const Color(0xFFF8F9FB),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.1)
              : Colors.black.withValues(alpha: 0.05),
        ),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.calendar_today_rounded,
            size: 18,
            color: Color(0xFF6C63FF),
          ),
          SizedBox(width: 12),
          Text(
            'Today, 2:45 PM',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms, delay: 100.ms);
  }

  Widget _buildCategorySection(bool isDark) {
    final categories = [
      {'name': 'Housing', 'icon': Icons.home_rounded},
      {'name': 'Food', 'icon': Icons.restaurant_rounded},
      {'name': 'Fun', 'icon': Icons.celebration_rounded},
      {'name': 'Work', 'icon': Icons.business_center_rounded},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 24, bottom: 20),
          child: Text(
            'CATEGORY',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
              letterSpacing: 1,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: categories.map((cat) {
            final isSelected = _activeCategory == cat['name'];
            return GestureDetector(
              onTap: () =>
                  setState(() => _activeCategory = cat['name'] as String),
              child: Column(
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFF6C63FF)
                          : (isDark
                                ? Colors.white.withValues(alpha: 0.05)
                                : const Color(0xFFF8F9FB)),
                      shape: BoxShape.circle,
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: const Color(
                                  0xFF6C63FF,
                                ).withValues(alpha: 0.3),
                                blurRadius: 12,
                                offset: const Offset(0, 6),
                              ),
                            ]
                          : [],
                    ),
                    child: Icon(
                      cat['icon'] as IconData,
                      color: isSelected
                          ? Colors.white
                          : (isDark ? Colors.white70 : Colors.black54),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    cat['name'] as String,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.w500,
                      color: isSelected ? const Color(0xFF6C63FF) : Colors.grey,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    ).animate().fadeIn(duration: 400.ms, delay: 200.ms);
  }

  Widget _buildAttachReceiptToggle(bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isDark
              ? Colors.white.withValues(alpha: 0.03)
              : const Color(0xFFF8F9FB),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isDark
                ? Colors.white.withValues(alpha: 0.05)
                : Colors.black.withValues(alpha: 0.02),
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.02),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(
                Icons.receipt_long_rounded,
                color: Color(0xFF6C63FF),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Attach Receipt',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Auto-scan for details',
                    style: TextStyle(
                      color: Colors.grey.withValues(alpha: 0.6),
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            Switch(
              value: _attachReceipt,
              onChanged: (v) => setState(() => _attachReceipt = v),
              activeTrackColor: const Color(0xFF6C63FF),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 400.ms, delay: 300.ms);
  }

  Widget _buildNumericKeypad(bool isDark) {
    final keys = ["1", "2", "3", "4", "5", "6", "7", "8", "9", ".", "0", "⌫"];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 2,
          mainAxisSpacing: 0,
          crossAxisSpacing: 0,
        ),
        itemCount: keys.length,
        itemBuilder: (context, index) {
          final key = keys[index];
          final isBackspace = key == "⌫";

          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => isBackspace ? _onBackspace() : _onKeyTap(key),
            child: Container(
              alignment: Alignment.center,
              child: isBackspace
                  ? Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE2E8F0),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.backspace_rounded,
                        color: Color(0xFF475569),
                        size: 24,
                      ),
                    )
                  : Text(
                      key,
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        color: isDark ? Colors.white : const Color(0xFF0F172A),
                      ),
                    ),
            ),
          );
        },
      ),
    ).animate().fadeIn(duration: 400.ms, delay: 400.ms);
  }

  Widget _buildNoteField(bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.grey.withValues(alpha: 0.2)),
          ),
        ),
        child: Row(
          children: [
            const Icon(Icons.notes_rounded, color: Colors.grey, size: 20),
            const SizedBox(width: 16),
            Expanded(
              child: TextField(
                onChanged: (v) => _note = v,
                decoration: InputDecoration(
                  hintText: 'Add a note or merchant name...',
                  hintStyle: TextStyle(
                    color: Colors.grey.withValues(alpha: 0.6),
                    fontSize: 16,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 400.ms, delay: 500.ms);
  }

  void _handleSave() {
    HapticFeedback.heavyImpact();
    final amount = double.tryParse(_amount) ?? 0.0;

    if (amount > 0) {
      final tx = Transaction(
        id: DateTime.now().toString(),
        title: _note.isEmpty ? 'New Expense' : _note,
        amount: amount,
        date: DateTime.now(),
        category: _activeCategory,
      );

      ref.read(asyncTransactionsProvider.notifier).addTransaction(tx);
      Navigator.pop(context);
    } else {
      // Show feedback that amount must be > 0
    }
  }
}
