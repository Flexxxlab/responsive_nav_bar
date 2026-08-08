import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Extension on BuildContext to get the media size.
extension CustomContext on BuildContext {
  Size get mediaSize => MediaQuery.of(this).size;
}

/// A class representing an item in the navigation bar.
class BarItem {
  final Widget icon;
  final String label;
  final bool showNotificationDot;

  /// Creates a [BarItem] with the given [icon] and [label].
  BarItem({
    required this.icon,
    required this.label,
    this.showNotificationDot = false,
  });
}

/// A responsive navigation bar that adapts to different screen sizes.
class ResponsiveNavigationBar extends StatefulWidget {
  final StatefulNavigationShell navigationShell;
  final List<NavigationRailDestination> tabletBarButtons;
  final List<Widget> webBarButtons;
  final List<BottomNavigationBarItem> phoneBarButtons;

  /// Creates a [ResponsiveNavigationBar] with the given [navigationShell] and [barButtons].
  ResponsiveNavigationBar({
    super.key,
    required this.navigationShell,
    required List<BarItem> barButtons,
  }) : tabletBarButtons = barButtons
           .map(
             (item) => NavigationRailDestination(
               icon: _NotificationDotIcon(item: item),
               label: Text(item.label),
             ),
           )
           .toList(),
       webBarButtons = barButtons
           .map(
             (item) => Tab(
               icon: _NotificationDotIcon(item: item),
               text: item.label,
             ),
           )
           .toList(),
       phoneBarButtons = barButtons
           .map(
             (item) => BottomNavigationBarItem(
               icon: _NotificationDotIcon(item: item),
               label: item.label,
             ),
           )
           .toList();

  @override
  State<ResponsiveNavigationBar> createState() =>
      _ResponsiveNavigationBarState();
}

/// The state for the [ResponsiveNavigationBar] widget.
class _ResponsiveNavigationBarState extends State<ResponsiveNavigationBar>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      initialIndex: widget.navigationShell.currentIndex,
      length: widget.webBarButtons.length,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (context.mediaSize.width < 500) {
      // Use BottomNavigationBar for mobile devices
      return Scaffold(
        body: widget.navigationShell,
        bottomNavigationBar: BottomNavigationBar(
          items: widget.phoneBarButtons,
          onTap: (int index) => widget.navigationShell.goBranch(index),
          currentIndex: widget.navigationShell.currentIndex,
        ),
      );
    } else if (context.mediaSize.width > 1024) {
      // Use TabBar for web
      _tabController.index = widget.navigationShell.currentIndex;

      return Scaffold(
        body: Column(
          children: [
            TabBar(
              tabs: widget.webBarButtons,
              onTap: (int index) => widget.navigationShell.goBranch(index),
              controller: _tabController,
              tabAlignment: TabAlignment.center,
            ),
            Expanded(child: widget.navigationShell),
          ],
        ),
      );
    } else {
      // Use NavigationRail for tablets
      return Scaffold(
        body: Row(
          children: [
            NavigationRail(
              destinations: widget.tabletBarButtons,
              onDestinationSelected: (int index) =>
                  widget.navigationShell.goBranch(index),
              labelType: NavigationRailLabelType.all,
              selectedIndex: widget.navigationShell.currentIndex,
            ),
            Expanded(child: widget.navigationShell),
          ],
        ),
      );
    }
  }
}

class _NotificationDotIcon extends StatelessWidget {
  const _NotificationDotIcon({required this.item});

  final BarItem item;

  @override
  Widget build(BuildContext context) {
    if (!item.showNotificationDot) return item.icon;

    final colorScheme = Theme.of(context).colorScheme;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        item.icon,
        Positioned(
          top: -2,
          right: -4,
          child: DecoratedBox(
            key: const ValueKey('responsive_nav_bar_notification_dot'),
            decoration: BoxDecoration(
              color: colorScheme.error,
              shape: BoxShape.circle,
              border: Border.all(color: colorScheme.surface, width: 1.5),
            ),
            child: const SizedBox.square(dimension: 10),
          ),
        ),
      ],
    );
  }
}
