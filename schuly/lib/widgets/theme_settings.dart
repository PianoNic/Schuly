import 'package:flutter/material.dart';
import '../providers/theme_provider.dart';

class ThemeSettings extends StatelessWidget {
  final ThemeProvider themeProvider;

  const ThemeSettings({
    super.key,
    required this.themeProvider,
  });

  // Dynamic color lists based on neon mode
  List<ColorOption> get _predefinedColors => themeProvider.isNeonMode 
    ? _neonColors 
    : _classicColors;

  // 9 neon accent colors for 3x3 grid
  final List<ColorOption> _neonColors = const [
    ColorOption(color: Color(0xFF8A2BE2), name: 'Neon Violett'),  // Neon Violet
    ColorOption(color: Color(0xFF00FFFF), name: 'Neon Cyan'),     // Neon Cyan
    ColorOption(color: Color(0xFF39FF14), name: 'Neon Grün'),     // Neon Green
    ColorOption(color: Color(0xFFFF69B4), name: 'Neon Pink'),     // Neon Pink (lighter)
    ColorOption(color: Color(0xFFFF6600), name: 'Neon Orange'),   // Neon Orange
    ColorOption(color: Color(0xFF0080FF), name: 'Neon Blau'),     // Neon Blue
    ColorOption(color: Color(0xFFFF0040), name: 'Neon Rot'),      // Neon Red
    ColorOption(color: Color(0xFFFFFF00), name: 'Neon Gelb'),     // Neon Yellow
    ColorOption(color: Color(0xFF00FF80), name: 'Neon Mint'),     // Neon Mint (replaced lila)
  ];

  // 9 classic colors for 3x3 grid
  final List<ColorOption> _classicColors = const [
    ColorOption(color: Colors.blue, name: 'Blau'),
    ColorOption(color: Colors.teal, name: 'Türkis'),
    ColorOption(color: Colors.green, name: 'Grün'),
    ColorOption(color: Colors.pink, name: 'Pink'),
    ColorOption(color: Colors.orange, name: 'Orange'),
    ColorOption(color: Colors.indigo, name: 'Indigo'),
    ColorOption(color: Colors.red, name: 'Rot'),
    ColorOption(color: Colors.amber, name: 'Gelb'),
    ColorOption(color: Colors.purple, name: 'Lila'),
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
            
            // Color Mode Toggle
            Text(
              'Farbstil',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            _buildColorModeToggle(context),
            
            const SizedBox(height: 24),
            
            // Color Selection
            Text(
              themeProvider.isNeonMode ? 'Neon Akzentfarbe' : 'Klassische Akzentfarbe',
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
    final appColors = Theme.of(context).extension<AppColors>();
    final seedColor = appColors?.seedColor ?? Theme.of(context).colorScheme.primary;
    final lightBackground = appColors?.lightBackground ?? seedColor.withOpacity(0.1);
    
    return InkWell(
      onTap: () => themeProvider.setThemeMode(mode),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected 
              ? lightBackground
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected 
                ? seedColor
                : Theme.of(context).colorScheme.outline.withOpacity(0.2),
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected 
                  ? seedColor
                  : Theme.of(context).colorScheme.onSurface,
            ),
            const SizedBox(width: 12),
            Text(
              label,
              style: TextStyle(
                color: isSelected 
                    ? seedColor
                    : Theme.of(context).colorScheme.onSurface,
                fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
              ),
            ),
            const Spacer(),
            if (isSelected)
              Icon(
                Icons.check,
                color: seedColor,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildColorModeToggle(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildColorModeOption(
            context, 
            false, 
            'Klassisch', 
            Icons.palette_outlined,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildColorModeOption(
            context, 
            true, 
            'Neon', 
            Icons.auto_awesome,
          ),
        ),
      ],
    );
  }

  Widget _buildColorModeOption(BuildContext context, bool isNeon, String label, IconData icon) {
    final isSelected = themeProvider.isNeonMode == isNeon;
    final appColors = Theme.of(context).extension<AppColors>();
    final seedColor = appColors?.seedColor ?? Theme.of(context).colorScheme.primary;
    final lightBackground = appColors?.lightBackground ?? seedColor.withOpacity(0.1);
    
    return InkWell(
      onTap: () => themeProvider.setNeonMode(isNeon),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected 
              ? lightBackground
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected 
                ? seedColor
                : Theme.of(context).colorScheme.outline.withOpacity(0.2),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected 
                  ? seedColor
                  : Theme.of(context).colorScheme.onSurface,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: isSelected 
                    ? seedColor
                    : Theme.of(context).colorScheme.onSurface,
                fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildColorOption(BuildContext context, Color color, String label) {
    final isSelected = themeProvider.seedColor == color;
    final shouldShowNeonEffect = themeProvider.isNeonMode;
    final lightBackground = isSelected 
        ? color.withOpacity(shouldShowNeonEffect ? 0.08 : 0.1)
        : Colors.transparent;
    
    return InkWell(
      onTap: () => themeProvider.setSeedColor(color),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: lightBackground,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected 
                ? color
                : Theme.of(context).colorScheme.outline.withOpacity(0.2),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected && shouldShowNeonEffect ? [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 8,
              spreadRadius: 0,
            ),
          ] : null,
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
                boxShadow: shouldShowNeonEffect ? [
                  BoxShadow(
                    color: color.withOpacity(0.4),
                    blurRadius: 6,
                    spreadRadius: 0,
                  ),
                ] : null,
              ),
              child: isSelected
                  ? Icon(
                      Icons.check,
                      color: _getContrastColor(color),
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
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
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


  Color _getContrastColor(Color color) {
    // Calculate luminance to determine if we need light or dark text
    final luminance = (0.299 * color.red + 0.587 * color.green + 0.114 * color.blue) / 255;
    return luminance > 0.5 ? Colors.black : Colors.white;
  }
}

class ColorOption {
  final Color color;
  final String name;

  const ColorOption({required this.color, required this.name});
}