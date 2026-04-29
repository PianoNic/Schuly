import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import '../utils/markus_ruehl_checker.dart';

class MaggusCheckerPage extends StatefulWidget {
  const MaggusCheckerPage({super.key});

  @override
  State<MaggusCheckerPage> createState() => _MaggusCheckerPageState();
}

class _MaggusCheckerPageState extends State<MaggusCheckerPage> {
  final TextEditingController _textController = TextEditingController();
  MarkusRuehlResult? _result;
  bool _isTransformed = false;
  String _originalText = '';

  void _checkText() {
    if (_textController.text.isEmpty) return;

    setState(() {
      _result = MarkusRuehlChecker.checkText(_textController.text);
      _isTransformed = false;
      _originalText = _textController.text;
    });
  }

  void _transformText() {
    if (_textController.text.isEmpty) return;

    setState(() {
      if (!_isTransformed) {
        _originalText = _textController.text;
        _textController.text = MarkusRuehlChecker.transformToMaggus(_textController.text);
        _isTransformed = true;
      } else {
        _textController.text = _originalText;
        _isTransformed = false;
      }
    });
  }

  void _insertExample() {
    _textController.text = '''
Das ist nicht gut genug!
Das Training muss brutal sein.
Schwere Gewichte und hohes Volumen - das ist es!
Nicht immer lecker, aber das wirkt!
''';
    _checkText();
  }

  void _shareResult() {
    if (_result == null) return;

    String shareText = '🏋 Mein Maggus-Score: ${_result!.score} Punkte!\n';
    shareText += '${_result!.level.emoji} Level: ${_result!.level.label}\n';
    shareText += '\n';
    shareText += '💪 ${_result!.motivationalQuote}\n';
    shareText += '\n';
    shareText += 'Teste deinen eigenen Maggus-Level in der Schuly App!';

    Share.share(shareText);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Maggus Rühl Language Checker'),
        backgroundColor: theme.colorScheme.primaryContainer,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.fitness_center,
                            color: theme.colorScheme.primary,
                            size: 28,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Des bedarfs! 💪',
                            style: theme.textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Überprüfe deinen Text auf Markus "Maggus" Rühl Style!',
                        style: theme.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _textController,
                maxLines: 6,
                decoration: InputDecoration(
                  hintText: 'Gib hier deinen Text ein...\n\nBeispiel: "Des bedarfs für schwere Gewichte!"',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: theme.colorScheme.surface,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _checkText,
                      icon: const Icon(Icons.check),
                      label: const Text('Check Maggus-Level'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        backgroundColor: theme.colorScheme.primary,
                        foregroundColor: theme.colorScheme.onPrimary,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _transformText,
                      icon: Icon(_isTransformed ? Icons.undo : Icons.transform),
                      label: Text(_isTransformed ? 'Original' : 'Maggusify'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        backgroundColor: theme.colorScheme.secondary,
                        foregroundColor: theme.colorScheme.onSecondary,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              TextButton.icon(
                onPressed: _insertExample,
                icon: const Icon(Icons.lightbulb_outline),
                label: const Text('Beispieltext einfügen'),
              ),
              if (_result != null) ...[
                const SizedBox(height: 24),
                Card(
                  color: _getScoreColor(theme, _result!.level),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Ergebnis',
                              style: theme.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              '${_result!.level.emoji} ${_result!.score} Punkte',
                              style: theme.textTheme.titleMedium?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            _result!.level.label,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        if (_result!.foundPhrases.isNotEmpty) ...[
                          Text(
                            'Gefundene Maggus-Phrasen:',
                            style: theme.textTheme.titleSmall?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          ...(_result!.foundPhrases.map((phrase) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2.0),
                            child: Row(
                              children: [
                                const Icon(Icons.check_circle,
                                  color: Colors.white,
                                  size: 16,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  phrase,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ))),
                          const SizedBox(height: 12),
                        ],
                        if (_result!.foundHessian.isNotEmpty) ...[
                          Text(
                            'Hessischer Dialekt:',
                            style: theme.textTheme.titleSmall?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Wrap(
                            spacing: 8,
                            runSpacing: 4,
                            children: _result!.foundHessian.map((word) => Chip(
                              label: Text(
                                word,
                                style: TextStyle(
                                  color: theme.colorScheme.primary,
                                  fontSize: 12,
                                ),
                              ),
                              backgroundColor: Colors.white,
                              visualDensity: VisualDensity.compact,
                            )).toList(),
                          ),
                          const SizedBox(height: 12),
                        ],
                        Divider(color: Colors.white.withValues(alpha: 0.3)),
                        const SizedBox(height: 8),
                        Text(
                          _result!.motivationalQuote,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: _shareResult,
                  icon: const Icon(Icons.share),
                  label: const Text('Teile dein Maggus-Level'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                    backgroundColor: theme.colorScheme.tertiary,
                    foregroundColor: theme.colorScheme.onTertiary,
                  ),
                ),
              ],
              const SizedBox(height: 24),
              Card(
                color: theme.colorScheme.tertiaryContainer,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Über Markus "Maggus" Rühl',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Geboren 1972 in Darmstadt, ist Markus Rühl eine deutsche Bodybuilding-Legende. '
                        'Bekannt für seinen hessischen Dialekt und legendäre Sprüche wie "Des bedarfs!" und '
                        '"Muss net schmegge, muss wirge!" hat er sich als Kultfigur etabliert.',
                        style: TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Typische Merkmale:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      const Text('• Hessischer Dialekt (net, des, isses)'),
                      const Text('• Direkte, ungeschönte Ausdrucksweise'),
                      const Text('• Training und Ernährungs-Philosophie'),
                      const Text('• Motivational Quotes mit Humor'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getScoreColor(ThemeData theme, MaggusLevel level) {
    switch (level) {
      case MaggusLevel.legend:
        return Colors.amber.shade700;
      case MaggusLevel.bruddal:
        return Colors.red.shade700;
      case MaggusLevel.solid:
        return Colors.blue.shade700;
      case MaggusLevel.beginner:
        return Colors.green.shade700;
      case MaggusLevel.none:
        return Colors.grey.shade600;
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}