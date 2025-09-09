import 'package:flutter/material.dart';
import '../providers/theme_provider.dart';

class ThemeSettings extends StatelessWidget {
  final ThemeProvider themeProvider;

  const ThemeSettings({
    super.key,
    required this.themeProvider,
  });

  // 9 predefined colors for 3x3 grid
  final List<ColorOption> _predefinedColors = const [
    ColorOption(color: Colors.red, name: 'Rot'),
    ColorOption(color: Colors.blue, name: 'Blau'),
    ColorOption(color: Colors.green, name: 'Grün'),
    ColorOption(color: Colors.purple, name: 'Lila'),
    ColorOption(color: Colors.orange, name: 'Orange'),
    ColorOption(color: Colors.teal, name: 'Türkis'),
    ColorOption(color: Colors.indigo, name: 'Indigo'),
    ColorOption(color: Colors.pink, name: 'Pink'),
    ColorOption(color: Colors.amber, name: 'Gelb'),
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Design Einstellungen',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            
            // Theme Mode Selection
            Text(
              'Darstellung',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            _buildThemeModeOption(context, ThemeMode.system, 'Automatisch', Icons.brightness_auto),
            _buildThemeModeOption(context, ThemeMode.light, 'Hell', Icons.light_mode),
            _buildThemeModeOption(context, ThemeMode.dark, 'Dunkel', Icons.dark_mode),
            
            const SizedBox(height: 24),
            
            // Color Selection
            Text(
              'Akzentfarbe',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            
            // 3x3 Grid for colors
            LayoutBuilder(
              builder: (context, constraints) {
                final availableWidth = constraints.maxWidth;
                final itemWidth = (availableWidth - 16) / 3; // 3 columns with 8px spacing each
                
                return Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _predefinedColors.map((colorOption) => 
                    SizedBox(
                      width: itemWidth,
                      child: _buildColorOption(
                        context, 
                        colorOption.color, 
                        colorOption.name,
                      ),
                    ),
                  ).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeModeOption(BuildContext context, ThemeMode mode, String label, IconData icon) {
    final isSelected = themeProvider.themeMode == mode;
    
    return InkWell(
      onTap: () => themeProvider.setThemeMode(mode),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected 
              ? Theme.of(context).colorScheme.primaryContainer
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected 
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.outline.withOpacity(0.2),
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected 
                  ? Theme.of(context).colorScheme.onPrimaryContainer
                  : Theme.of(context).colorScheme.onSurface,
            ),
            const SizedBox(width: 12),
            Text(
              label,
              style: TextStyle(
                color: isSelected 
                    ? Theme.of(context).colorScheme.onPrimaryContainer
                    : Theme.of(context).colorScheme.onSurface,
                fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
              ),
            ),
            const Spacer(),
            if (isSelected)
              Icon(
                Icons.check,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildColorOption(BuildContext context, Color color, String label) {
    final isSelected = themeProvider.seedColor == color;
    
    return InkWell(
      onTap: () => themeProvider.setSeedColor(color),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected 
                ? color
                : Theme.of(context).colorScheme.outline.withOpacity(0.2),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
              child: isSelected
                  ? const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 20,
                    )
                  : null,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: isSelected 
                    ? color
                    : Theme.of(context).colorScheme.onSurface,
                fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class ColorOption {
  final Color color;
  final String name;

  const ColorOption({required this.color, required this.name});
}