import 'package:flutter/material.dart';

void main() {
  runApp(const FinanceApp());
}

class FinanceApp extends StatelessWidget {
  const FinanceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Finance App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF1A1A1A),
        fontFamily: 'SF Pro Display',
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static const Color _yellow = Color(0xFFFFD233);
  static const Color _cardBg = Color(0xFF252525);
  static const Color _darkBg = Color(0xFF1A1A1A);
  static const Color _white = Colors.white;
  static const Color _grey = Color(0xFF888888);
  static const Color _incomeGreen = Color(0xFFB8F0A0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _darkBg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 20),
              _buildBalanceCard(),
              const SizedBox(height: 16),
              _buildExpensesCard(),
              const SizedBox(height: 16),
              _buildBottomCards(),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        // Avatar
        Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFF8B6914),
            border: Border.all(color: _yellow, width: 2),
          ),
          child: ClipOval(
            child: Container(
              color: const Color(0xFFD4A843),
              child: const Icon(Icons.person, color: Colors.white, size: 28),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Morning, Mudaser',
              style: TextStyle(
                color: _white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.2,
              ),
            ),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              decoration: BoxDecoration(
                color: _yellow,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'Premium',
                style: TextStyle(
                  color: Color(0xFF1A1A1A),
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBalanceCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'Active Balance',
                style: TextStyle(color: _grey, fontSize: 13),
              ),
              const SizedBox(width: 6),
              const Icon(Icons.remove_red_eye_outlined, color: _grey, size: 16),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            '\$56,890.00',
            style: TextStyle(
              color: _yellow,
              fontSize: 36,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              _buildActionButton('Top Up', filled: true),
              const SizedBox(width: 10),
              _buildActionButton('Send Money', filled: false),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(color: Color(0xFF333333), height: 1),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.keyboard_arrow_down, color: _grey, size: 18),
              const SizedBox(width: 4),
              const Text(
                'View In & Out',
                style: TextStyle(color: _grey, fontSize: 13),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(String label, {required bool filled}) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: filled ? _yellow : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
          border: filled
              ? null
              : Border.all(color: const Color(0xFF444444), width: 1.5),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: filled ? const Color(0xFF1A1A1A) : _white,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildExpensesCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Expenses',
            style: TextStyle(
              color: _white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          _buildExpenseRow('Salary', 'Income', '\$4,000.00', isIncome: true),
          const SizedBox(height: 12),
          _buildExpenseRow(
            'Stock Dividents',
            'Income',
            '\$1,000.00',
            isIncome: true,
          ),
          const SizedBox(height: 12),
          _buildExpenseRow(
            'App Subscriptions',
            'Outcome',
            '\$300.00',
            isIncome: false,
          ),
          const SizedBox(height: 12),
          _buildExpenseRow(
            'Food & Dining',
            'Outcome',
            '\$1,500.00',
            isIncome: false,
          ),
        ],
      ),
    );
  }

  Widget _buildExpenseRow(
    String title,
    String type,
    String amount, {
    required bool isIncome,
  }) {
    return Row(
      children: [
        // Category chip
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
          decoration: BoxDecoration(
            color: const Color(0xFF333333),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            title,
            style: const TextStyle(
              color: _white,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(width: 8),
        // Type badge
        Text(
          type,
          style: TextStyle(
            color: isIncome ? _incomeGreen : _grey,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        const Spacer(),
        Text(
          amount,
          style: const TextStyle(
            color: _white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildBottomCards() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: _cardBg,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Spendings',
                  style: TextStyle(
                    color: _white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  '\$2,890.00',
                  style: TextStyle(
                    color: _yellow,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Spent this month',
                  style: TextStyle(color: _grey, fontSize: 11),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: _yellow,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Cashback',
                  style: TextStyle(
                    color: Color(0xFF1A1A1A),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  '\$1,067.00',
                  style: TextStyle(
                    color: Color(0xFF1A1A1A),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Get this month',
                  style: TextStyle(color: Color(0xFF5A4A00), fontSize: 11),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNav() {
    const Color activeColor = Color(0xFFFFD233);
    const Color inactiveColor = Color(0xFF666666);

    final List<IconData> icons = [
      Icons.home_rounded,
      Icons.account_balance_wallet_outlined,
      Icons.edit_square,
      Icons.person_outline_rounded,
    ];

    return Container(
      height: 70,
      decoration: const BoxDecoration(
        color: Color(0xFF222222),
        border: Border(top: BorderSide(color: Color(0xFF333333), width: 1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(icons.length, (i) {
          final bool isSelected = i == _selectedIndex;
          return GestureDetector(
            onTap: () => setState(() => _selectedIndex = i),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Icon(
                icons[i],
                color: isSelected ? activeColor : inactiveColor,
                size: 26,
              ),
            ),
          );
        }),
      ),
    );
  }
}
