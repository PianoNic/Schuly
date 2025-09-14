import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/homepage_config_provider.dart';
import '../l10n/app_localizations.dart';

class HomepageConfigModal extends StatelessWidget {
  const HomepageConfigModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomepageConfigProvider>(
      builder: (context, config, _) {
        final sections = config.sections;
        return Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.8,
            minHeight: 300,
          ),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Padding(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: 8,
              bottom: MediaQuery.of(context).viewInsets.bottom + MediaQuery.of(context).padding.bottom + 20,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Handle indicator
                Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onSurfaceVariant.withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),

                // Header (no icon)
                Row(
                  children: [
                    // Removed the icon next to the title
                    Expanded(
                      child: Text(
                        AppLocalizations.of(context)!.customizeHomepage,
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Draggable section cards (reordering enabled)
                Flexible(
                  child: ReorderableListView.builder(
                    shrinkWrap: true,
                    itemCount: sections.length,
                    onReorder: (oldIndex, newIndex) {
                      config.reorder(oldIndex, newIndex);
                    },
                    itemBuilder: (context, index) {
                      final section = sections[index];
                      return _buildSectionCard(context, section, config);
                    },
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSectionCard(BuildContext context, SectionConfig section, HomepageConfigProvider config) {
    final seedColor = Theme.of(context).colorScheme.primary;
    return Container(
      key: ValueKey(section.id),
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Card(
        elevation: section.isVisible ? 2 : 1,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: section.isVisible
                ? Border.all(color: seedColor.withValues(alpha: 0.3), width: 2)
                : Border.all(color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2)),
            color: section.isVisible
                ? seedColor.withValues(alpha: 0.05)
                : Theme.of(context).colorScheme.surface.withValues(alpha: 0.5),
          ),
          child: Row(
            children: [
              // Drag handle
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                child: Icon(
                  Icons.drag_indicator,
                  color: section.isVisible
                      ? Theme.of(context).colorScheme.onSurface
                      : Theme.of(context).colorScheme.onSurfaceVariant,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              // Section title and status (no icon)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      section.title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: section.isVisible ? FontWeight.w600 : FontWeight.w400,
                        color: section.isVisible
                            ? Theme.of(context).colorScheme.onSurface
                            : Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      section.isVisible ? AppLocalizations.of(context)!.visible : AppLocalizations.of(context)!.hidden,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: section.isVisible
                            ? seedColor
                            : Theme.of(context).colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              // Visibility indicator (eye icon as IconButton)
              IconButton(
                icon: section.isVisible
                    ? Icon(Icons.visibility, color: seedColor, size: 20)
                    : Icon(Icons.visibility_off, color: Theme.of(context).colorScheme.onSurfaceVariant, size: 20),
                onPressed: () {
                  config.toggleVisibility(section.id);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}