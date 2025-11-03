import 'package:flutter/material.dart';
import '../providers/theme_provider.dart';
import '../l10n/app_localizations.dart';

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
    ColorOption(color: Color(0xFF8A2BE2), name: 'neonViolet'),  // Neon Violet
    ColorOption(color: Color(0xFF00FFFF), name: 'neonCyan'),     // Neon Cyan
    ColorOption(color: Color(0xFF39FF14), name: 'neonGreen'),     // Neon Green
    ColorOption(color: Color(0xFFFF69B4), name: 'neonPink'),     // Neon Pink (lighter)
    ColorOption(color: Color(0xFFFF6600), name: 'neonOrange'),   // Neon Orange
    ColorOption(color: Color(0xFF0080FF), name: 'neonBlue'),     // Neon Blue
    ColorOption(color: Color(0xFFFF0040), name: 'neonRed'),      // Neon Red
    ColorOption(color: Color(0xFFFFFF00), name: 'neonYellow'),     // Neon Yellow
    ColorOption(color: Color(0xFF00FF80), name: 'neonMint'),     // Neon Mint (replaced lila)
  ];

  // 9 classic colors for 3x3 grid
  final List<ColorOption> _classicColors = const [
    ColorOption(color: Colors.blue, name: 'blue'),
    ColorOption(color: Colors.teal, name: 'teal'),
    ColorOption(color: Colors.green, name: 'green'),
    ColorOption(color: Colors.pink, name: 'pink'),
    ColorOption(color: Colors.orange, name: 'orange'),
    ColorOption(color: Colors.indigo, name: 'indigo'),
    ColorOption(color: Colors.red, name: 'red'),
    ColorOption(color: Colors.amber, name: 'yellow'),
    ColorOption(color: Colors.purple, name: 'purple'),
  ];

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              localizations.designSettings,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),

            // Theme Mode Selection
            Text(
              localizations.appearance,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(child: _buildThemeModeOption(context, ThemeMode.system, localizations.automatic, Icons.brightness_auto, enabled: true)),
                const SizedBox(width: 8),
                Expanded(child: _buildThemeModeOption(context, ThemeMode.light, localizations.light, Icons.light_mode, enabled: !themeProvider.useMaterialYou)),
                const SizedBox(width: 8),
                Expanded(child: _buildThemeModeOption(context, ThemeMode.dark, localizations.dark, Icons.dark_mode, enabled: !themeProvider.useMaterialYou)),
              ],
            ),

            const SizedBox(height: 16),

            // Color Mode Toggle
            Text(
              localizations.colorStyle,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            // Color mode selection (mutually exclusive)
            Row(
              children: [
                Expanded(child: _buildColorStyleOption(context, 'material_you', localizations.materialYou, Icons.color_lens)),
                const SizedBox(width: 8),
                Expanded(child: _buildColorStyleOption(context, 'classic', localizations.classic, Icons.palette_outlined)),
                const SizedBox(width: 8),
                Expanded(child: _buildColorStyleOption(context, 'neon', localizations.neon, Icons.auto_awesome)),
              ],
            ),

            const SizedBox(height: 16),

            // Color Selection (only shown when not using Material You)
            if (!themeProvider.useMaterialYou) ...[
              Text(
                themeProvider.isNeonMode ? localizations.neonAccentColor : localizations.classicAccentColor,
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
            ] else
              // Material You info when enabled
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainer,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.palette,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            localizations.materialYouActive,
                            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            localizations.materialYouInfo,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeModeOption(BuildContext context, ThemeMode mode, String label, IconData icon, {bool enabled = true}) {
    final isSelected = themeProvider.themeMode == mode;
    final appColors = Theme.of(context).extension<AppColors>();
    final seedColor = appColors?.seedColor ?? Theme.of(context).colorScheme.primary;
    final lightBackground = appColors?.lightBackground ?? seedColor.withValues(alpha: 0.1);
    
    return InkWell(
      onTap: enabled ? () => themeProvider.setThemeMode(mode) : null,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        height: 72, // Fixed height for consistency (increased for 2-line text)
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected 
              ? lightBackground
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected 
                ? seedColor
                : Theme.of(context).colorScheme.outline.withValues(alpha: enabled ? 0.2 : 0.1),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: enabled
                  ? (isSelected 
                      ? seedColor
                      : Theme.of(context).colorScheme.onSurface)
                  : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.4),
              size: 20,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                color: enabled
                    ? (isSelected 
                        ? seedColor
                        : Theme.of(context).colorScheme.onSurface)
                    : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.4),
                fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
                fontSize: 12,
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

  Widget _buildColorStyleOption(BuildContext context, String style, String label, IconData icon) {
    final isSelected = _getSelectedColorStyle() == style;
    final appColors = Theme.of(context).extension<AppColors>();
    final seedColor = appColors?.seedColor ?? Theme.of(context).colorScheme.primary;
    final lightBackground = appColors?.lightBackground ?? seedColor.withValues(alpha: 0.1);
    
    return InkWell(
      onTap: () => _setColorStyle(style),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        height: 72, // Fixed height for consistency (increased for 2-line text)
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected 
              ? lightBackground
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected 
                ? seedColor
                : Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected 
                  ? seedColor
                  : Theme.of(context).colorScheme.onSurface,
              size: 20,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                color: isSelected 
                    ? seedColor
                    : Theme.of(context).colorScheme.onSurface,
                fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  String _getSelectedColorStyle() {
    if (themeProvider.useMaterialYou) return 'material_you';
    if (themeProvider.isNeonMode) return 'neon';
    return 'classic';
  }

  void _setColorStyle(String style) {
    switch (style) {
      case 'classic':
        themeProvider.setNeonMode(false);
        themeProvider.setMaterialYou(false);
        break;
      case 'neon':
        themeProvider.setNeonMode(true);
        themeProvider.setMaterialYou(false);
        break;
      case 'material_you':
        themeProvider.setMaterialYou(true);
        // setMaterialYou already disables neon mode in the provider
        // Switch to system/automatic theme since Material You handles light/dark automatically
        themeProvider.setThemeMode(ThemeMode.system);
        break;
    }
  }

  String _getColorName(AppLocalizations localizations, String key) {
    switch (key) {
      case 'blue': return localizations.blue;
      case 'teal': return localizations.teal;
      case 'green': return localizations.green;
      case 'pink': return localizations.pink;
      case 'orange': return localizations.orange;
      case 'indigo': return localizations.indigo;
      case 'red': return localizations.red;
      case 'yellow': return localizations.yellow;
      case 'purple': return localizations.purple;
      case 'neonViolet': return localizations.neonViolet;
      case 'neonCyan': return localizations.neonCyan;
      case 'neonGreen': return localizations.neonGreen;
      case 'neonPink': return localizations.neonPink;
      case 'neonOrange': return localizations.neonOrange;
      case 'neonBlue': return localizations.neonBlue;
      case 'neonRed': return localizations.neonRed;
      case 'neonYellow': return localizations.neonYellow;
      case 'neonMint': return localizations.neonMint;
      default: return key;
    }
  }

  Widget _buildColorOption(BuildContext context, Color color, String labelKey) {
    final localizations = AppLocalizations.of(context)!;
    final isSelected = themeProvider.seedColor == color;
    final shouldShowNeonEffect = themeProvider.isNeonMode;
    final lightBackground = isSelected 
        ? color.withValues(alpha: shouldShowNeonEffect ? 0.08 : 0.1)
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
                : Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected && shouldShowNeonEffect ? [
            BoxShadow(
              color: color.withValues(alpha: 0.3),
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
                    color: color.withValues(alpha: 0.4),
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
              _getColorName(localizations, labelKey),
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
    final luminance = (0.299 * (color.r * 255.0).round() + 0.587 * (color.g * 255.0).round() + 0.114 * (color.b * 255.0).round()) / 255;
    return luminance > 0.5 ? Colors.black : Colors.white;
  }
}

class ColorOption {
  final Color color;
  final String name;

  const ColorOption({required this.color, required this.name});
}