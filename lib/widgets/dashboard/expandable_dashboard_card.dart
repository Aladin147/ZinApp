import 'package:flutter/material.dart';
import 'package:zinapp_v2/theme/color_scheme.dart';
import 'package:zinapp_v2/widgets/containers/organic_container.dart';

/// States for the expandable dashboard card
enum DashboardCardState {
  /// Card is collapsed, showing summary information
  collapsed,
  
  /// Card is expanded, showing detailed information
  expanded
}

/// A generic expandable card for dashboard layouts
/// Can be used across the app for consistent dashboard UI
class ExpandableDashboardCard extends StatefulWidget {
  /// Title of the card
  final String title;
  
  /// Optional subtitle
  final String? subtitle;
  
  /// Icon to display in the header
  final IconData? icon;
  
  /// Accent color for the card
  final Color accentColor;
  
  /// Background color for the card (will use gradient if null)
  final Color? backgroundColor;
  
  /// Widget to display when collapsed
  final Widget collapsedChild;
  
  /// Widget to display when expanded
  final Widget expandedChild;
  
  /// Initial state of the card
  final DashboardCardState initialState;
  
  /// Whether to show the "View All" button
  final bool showViewAll;
  
  /// Callback when "View All" is tapped
  final VoidCallback? onViewAllTap;
  
  /// Text for the view all button
  final String viewAllText;
  
  /// Minimum height when collapsed
  final double collapsedHeight;
  
  /// Height when expanded (if null, will expand to fit content)
  final double? expandedHeight;
  
  /// Whether to animate the expansion/collapse
  final bool animate;
  
  /// Duration of the animation
  final Duration animationDuration;
  
  /// Curve of the animation
  final Curve animationCurve;
  
  /// Whether the card can be expanded/collapsed by tapping
  final bool expandable;

  /// Creates an expandable dashboard card
  const ExpandableDashboardCard({
    super.key,
    required this.title,
    this.subtitle,
    this.icon,
    required this.accentColor,
    this.backgroundColor,
    required this.collapsedChild,
    required this.expandedChild,
    this.initialState = DashboardCardState.collapsed,
    this.showViewAll = true,
    this.onViewAllTap,
    this.viewAllText = 'View All',
    this.collapsedHeight = 120,
    this.expandedHeight,
    this.animate = true,
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.easeInOut,
    this.expandable = true,
  });

  @override
  State<ExpandableDashboardCard> createState() => _ExpandableDashboardCardState();
}

class _ExpandableDashboardCardState extends State<ExpandableDashboardCard> with SingleTickerProviderStateMixin {
  late DashboardCardState _currentState;
  late AnimationController _controller;
  late Animation<double> _heightFactor;
  
  @override
  void initState() {
    super.initState();
    _currentState = widget.initialState;
    
    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );
    
    _heightFactor = _controller.drive(
      CurveTween(curve: widget.animationCurve),
    );
    
    if (_currentState == DashboardCardState.expanded) {
      _controller.value = 1.0;
    }
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  void _toggleExpanded() {
    if (!widget.expandable) return;
    
    setState(() {
      _currentState = _currentState == DashboardCardState.collapsed
          ? DashboardCardState.expanded
          : DashboardCardState.collapsed;
          
      if (_currentState == DashboardCardState.expanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isExpanded = _currentState == DashboardCardState.expanded;
    
    return FloatingOrganicCard(
      color: widget.backgroundColor ?? AppColors.baseDarkAlt,
      borderRadius: 24,
      elevation: isExpanded ? 8 : 4,
      enhancedShadow: true,
      padding: EdgeInsets.zero,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
      child: InkWell(
        onTap: widget.expandable ? _toggleExpanded : null,
        borderRadius: BorderRadius.circular(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Title and icon
                  Expanded(
                    child: Row(
                      children: [
                        if (widget.icon != null) ...[
                          Icon(
                            widget.icon,
                            color: widget.accentColor,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                        ],
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.title,
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              if (widget.subtitle != null)
                                Text(
                                  widget.subtitle!,
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: Colors.white.withOpacity(0.7),
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // View All button or expand/collapse indicator
                  widget.showViewAll && !isExpanded
                      ? TextButton(
                          onPressed: widget.onViewAllTap ?? _toggleExpanded,
                          style: TextButton.styleFrom(
                            foregroundColor: widget.accentColor,
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            minimumSize: const Size(60, 36),
                          ),
                          child: Text(widget.viewAllText),
                        )
                      : widget.expandable
                          ? Icon(
                              isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                              color: Colors.white.withOpacity(0.7),
                            )
                          : const SizedBox.shrink(),
                ],
              ),
            ),
            
            // Collapsed content
            if (!isExpanded || !widget.animate)
              Container(
                height: isExpanded ? 0 : widget.collapsedHeight,
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: isExpanded ? null : widget.collapsedChild,
              ),
              
            // Expanded content with animation
            if (widget.animate && widget.expandable)
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return ClipRect(
                    child: Align(
                      heightFactor: isExpanded ? _heightFactor.value : 1.0 - _heightFactor.value,
                      child: child,
                    ),
                  );
                },
                child: Container(
                  height: widget.expandedHeight,
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: widget.expandedChild,
                ),
              ),
              
            // Expanded content without animation
            if (isExpanded && (!widget.animate || !widget.expandable))
              Container(
                height: widget.expandedHeight,
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: widget.expandedChild,
              ),
          ],
        ),
      ),
    );
  }
}
