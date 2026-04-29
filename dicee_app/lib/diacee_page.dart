// import 'package:flutter/material.dart';

// class DiaceePage extends StatefulWidget {
//   const DiaceePage({super.key});

//   @override
//   State<DiaceePage> createState() => _DiaceePageState();
// }

// class _DiaceePageState extends State<DiaceePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Row(
//         children: [
//           Expanded(
//             child: TextButton(
//               onPressed: () {
//                 debugPrint('left button got pressed');
//               },
//               child: Image.asset('images/dice1.png'),
//             ),
//           ),

//           Expanded(
//             child: TextButton(
//               onPressed: () {
//                 debugPrint('right button got pressed');
//               },
//               child: Image.asset('images/dice1.png'),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'dart:math';
import 'package:flutter/material.dart';

class DicePage extends StatefulWidget {
  const DicePage({super.key});

  @override
  State<DicePage> createState() => _DicePageState();
}

class _DicePageState extends State<DicePage> with TickerProviderStateMixin {
  static const int winningScore = 50;

  int player1Dice = 1;
  int player2Dice = 1;
  int player1Score = 0;
  int player2Score = 0;
  int currentPlayer = 1;
  String? winner;
  int roundCount = 0;

  late AnimationController _pulseController;
  late AnimationController _shakeController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _shakeAnimation;

  @override
  void initState() {
    super.initState();

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.07).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _shakeAnimation = Tween<double>(begin: -6, end: 6).animate(
      CurvedAnimation(parent: _shakeController, curve: Curves.elasticIn),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _shakeController.dispose();
    super.dispose();
  }

  void rollDice() {
    if (winner != null) return;

    _shakeController.forward(from: 0);

    setState(() {
      roundCount++;
      final dice = Random().nextInt(6) + 1;
      if (currentPlayer == 1) {
        player1Dice = dice;
        player1Score += dice;
        currentPlayer = 2;
      } else {
        player2Dice = dice;
        player2Score += dice;
        currentPlayer = 1;
      }

      if (player1Score >= winningScore) winner = 'Player 1';
      if (player2Score >= winningScore) winner = 'Player 2';
    });

    if (winner != null) {
      Future.delayed(const Duration(milliseconds: 300), () {
        _showWinnerDialog(winner!);
      });
    }
  }

  void _resetGame() {
    setState(() {
      player1Score = 0;
      player2Score = 0;
      player1Dice = 1;
      player2Dice = 1;
      currentPlayer = 1;
      winner = null;
      roundCount = 0;
    });
  }

  void _showWinnerDialog(String winnerName) {
    final isP1 = winnerName == 'Player 1';
    final color = isP1 ? const Color(0xFF00C9FF) : const Color(0xFFFF6B6B);

    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.8),
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color(0xFF1A1A2E),
                color.withOpacity(0.15),
                const Color(0xFF1A1A2E),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(28),
            border: Border.all(color: color.withOpacity(0.7), width: 2),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.4),
                blurRadius: 40,
                spreadRadius: 6,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color.withOpacity(0.15),
                  border: Border.all(color: color.withOpacity(0.5), width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: color.withOpacity(0.4),
                      blurRadius: 24,
                      spreadRadius: 4,
                    ),
                  ],
                ),
                child: const Center(
                  child: Text('🏆', style: TextStyle(fontSize: 38)),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'VICTORY!',
                style: TextStyle(
                  color: color,
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 6,
                  shadows: [
                    Shadow(color: color.withOpacity(0.8), blurRadius: 16),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                winnerName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'reached $winningScore points in $roundCount rolls!',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white38, fontSize: 13),
              ),
              const SizedBox(height: 22),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStatChip(
                    label: 'P1 Score',
                    value: '$player1Score',
                    color: const Color(0xFF00C9FF),
                  ),
                  _buildStatChip(
                    label: 'Rounds',
                    value: '$roundCount',
                    color: const Color(0xFFFFD700),
                  ),
                  _buildStatChip(
                    label: 'P2 Score',
                    value: '$player2Score',
                    color: const Color(0xFFFF6B6B),
                  ),
                ],
              ),
              const SizedBox(height: 22),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                  _resetGame();
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [color, color.withOpacity(0.6)],
                    ),
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: color.withOpacity(0.5),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Text(
                      '🎲  PLAY AGAIN',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 15,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatChip({
    required String label,
    required String value,
    required Color color,
  }) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            color: color,
            fontSize: 20,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white38,
            fontSize: 11,
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }

  Widget _buildPlayerCard({
    required String label,
    required int diceValue,
    required int score,
    required bool isActive,
    required Color accentColor,
  }) {
    final progress = (score / winningScore).clamp(0.0, 1.0);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 350),
      margin: const EdgeInsets.symmetric(horizontal: 6),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isActive
              ? [accentColor.withOpacity(0.22), const Color(0xFF12122A)]
              : [const Color(0xFF12122A), const Color(0xFF0A0A18)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isActive
              ? accentColor.withOpacity(0.85)
              : Colors.white.withOpacity(0.07),
          width: isActive ? 2 : 1,
        ),
        boxShadow: isActive
            ? [
                BoxShadow(
                  color: accentColor.withOpacity(0.35),
                  blurRadius: 24,
                  spreadRadius: 2,
                ),
              ]
            : [],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Player label badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: isActive
                  ? accentColor.withOpacity(0.18)
                  : Colors.white.withOpacity(0.04),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isActive
                    ? accentColor.withOpacity(0.5)
                    : Colors.transparent,
              ),
            ),
            child: Text(
              label,
              style: TextStyle(
                color: isActive ? accentColor : Colors.white38,
                fontSize: 12,
                fontWeight: FontWeight.w800,
                letterSpacing: 2,
              ),
            ),
          ),

          const SizedBox(height: 10),

          // Big score
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            transitionBuilder: (child, anim) =>
                ScaleTransition(scale: anim, child: child),
            child: Text(
              '$score',
              key: ValueKey(score),
              style: TextStyle(
                color: isActive ? Colors.white : Colors.white30,
                fontSize: 42,
                fontWeight: FontWeight.w900,
                height: 1,
                shadows: isActive
                    ? [
                        Shadow(
                          color: accentColor.withOpacity(0.6),
                          blurRadius: 20,
                        ),
                      ]
                    : [],
              ),
            ),
          ),

          Text(
            '/ $winningScore pts',
            style: TextStyle(
              color: isActive
                  ? accentColor.withOpacity(0.6)
                  : Colors.white.withOpacity(0.18),
              fontSize: 10,
              letterSpacing: 1.5,
            ),
          ),

          const SizedBox(height: 12),

          // Dice with shake + pulse
          AnimatedBuilder(
            animation: _shakeAnimation,
            builder: (context, child) {
              return Transform.translate(
                offset: isActive
                    ? Offset(_shakeAnimation.value, 0)
                    : Offset.zero,
                child: child,
              );
            },
            child: ScaleTransition(
              scale: isActive
                  ? _pulseAnimation
                  : const AlwaysStoppedAnimation(1.0),
              child: GestureDetector(
                onTap: isActive && winner == null ? rollDice : null,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  opacity: isActive ? 1.0 : 0.25,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: accentColor.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isActive
                            ? accentColor.withOpacity(0.4)
                            : Colors.transparent,
                        width: 1.5,
                      ),
                      boxShadow: isActive
                          ? [
                              BoxShadow(
                                color: accentColor.withOpacity(0.2),
                                blurRadius: 14,
                              ),
                            ]
                          : [],
                    ),
                    child: Image.asset(
                      'images/dice$diceValue.png',
                      width: 70, // ← reduced from 80
                    ),
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 12),

          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.white.withOpacity(0.07),
              valueColor: AlwaysStoppedAnimation<Color>(
                isActive ? accentColor : accentColor.withOpacity(0.3),
              ),
              minHeight: 7,
            ),
          ),

          const SizedBox(height: 4),

          // Milestone markers
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '0',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.18),
                  fontSize: 9,
                ),
              ),
              Text(
                '25',
                style: TextStyle(
                  color: progress >= 0.5
                      ? accentColor.withOpacity(0.5)
                      : Colors.white.withOpacity(0.18),
                  fontSize: 9,
                ),
              ),
              Text(
                '50',
                style: TextStyle(
                  color: progress >= 1.0
                      ? accentColor
                      : Colors.white.withOpacity(0.18),
                  fontSize: 9,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF07071A), Color(0xFF0F0F28), Color(0xFF07071A)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            // ← key fix: prevents overflow
            physics: const ClampingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // ── Header ─────────────────────────────
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          '🎲 DICE DUEL',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 3,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.1),
                            ),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.loop_rounded,
                                size: 13,
                                color: Colors.white38,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                'Round $roundCount',
                                style: const TextStyle(
                                  color: Colors.white38,
                                  fontSize: 12,
                                  letterSpacing: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  // ── Win target banner ───────────────────
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.symmetric(
                      vertical: 7,
                      horizontal: 20,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFFFFD700).withOpacity(0.12),
                          const Color(0xFFFF8C00).withOpacity(0.08),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: const Color(0xFFFFD700).withOpacity(0.35),
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('🏆', style: TextStyle(fontSize: 13)),
                        SizedBox(width: 8),
                        Text(
                          'FIRST TO 50 POINTS WINS',
                          style: TextStyle(
                            color: Color(0xFFFFD700),
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 2,
                          ),
                        ),
                        SizedBox(width: 8),
                        Text('🏆', style: TextStyle(fontSize: 13)),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),

                  // ── Turn indicator ──────────────────────
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    margin: const EdgeInsets.symmetric(horizontal: 40),
                    padding: const EdgeInsets.symmetric(
                      vertical: 9,
                      horizontal: 20,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: currentPlayer == 1
                            ? [
                                const Color(0xFF00C9FF).withOpacity(0.15),
                                const Color(0xFF00C9FF).withOpacity(0.05),
                              ]
                            : [
                                const Color(0xFFFF6B6B).withOpacity(0.15),
                                const Color(0xFFFF6B6B).withOpacity(0.05),
                              ],
                      ),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: currentPlayer == 1
                            ? const Color(0xFF00C9FF).withOpacity(0.5)
                            : const Color(0xFFFF6B6B).withOpacity(0.5),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.touch_app_rounded,
                          size: 14,
                          color: currentPlayer == 1
                              ? const Color(0xFF00C9FF)
                              : const Color(0xFFFF6B6B),
                        ),
                        const SizedBox(width: 7),
                        Text(
                          'Player $currentPlayer — Tap your dice to roll!',
                          style: TextStyle(
                            color: currentPlayer == 1
                                ? const Color(0xFF00C9FF)
                                : const Color(0xFFFF6B6B),
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 14),

                  // ── Player cards ────────────────────────
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: _buildPlayerCard(
                              label: 'PLAYER 1',
                              diceValue: player1Dice,
                              score: player1Score,
                              isActive: currentPlayer == 1,
                              accentColor: const Color(0xFF00C9FF),
                            ),
                          ),
                          Expanded(
                            child: _buildPlayerCard(
                              label: 'PLAYER 2',
                              diceValue: player2Dice,
                              score: player2Score,
                              isActive: currentPlayer == 2,
                              accentColor: const Color(0xFFFF6B6B),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // ── Roll button ─────────────────────────
                  GestureDetector(
                    onTap: winner == null ? rollDice : null,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 28),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                        gradient: winner == null
                            ? LinearGradient(
                                colors: currentPlayer == 1
                                    ? [
                                        const Color(0xFF00C9FF),
                                        const Color(0xFF0072FF),
                                      ]
                                    : [
                                        const Color(0xFFFF6B6B),
                                        const Color(0xFFFF4500),
                                      ],
                              )
                            : const LinearGradient(
                                colors: [Color(0xFF252540), Color(0xFF252540)],
                              ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: winner == null
                            ? [
                                BoxShadow(
                                  color:
                                      (currentPlayer == 1
                                              ? const Color(0xFF00C9FF)
                                              : const Color(0xFFFF6B6B))
                                          .withOpacity(0.45),
                                  blurRadius: 20,
                                  offset: const Offset(0, 6),
                                ),
                              ]
                            : [],
                      ),
                      child: Center(
                        child: Text(
                          winner == null ? '🎲   ROLL DICE' : '— GAME OVER —',
                          style: TextStyle(
                            color: winner == null
                                ? Colors.white
                                : Colors.white24,
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 3,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  // ── Reset ───────────────────────────────
                  TextButton.icon(
                    onPressed: _resetGame,
                    icon: const Icon(
                      Icons.refresh_rounded,
                      size: 14,
                      color: Colors.white30,
                    ),
                    label: const Text(
                      'Reset Game',
                      style: TextStyle(
                        color: Colors.white30,
                        fontSize: 12,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
