import 'package:flutter/material.dart';
import 'package:whale_stock/ui/widgets/sidebar_item.dart';

class MainLayout extends StatefulWidget {
  final Widget child;
  final String title;
  final int selectedIndex;
  final Function(int) onItemSelected;
  final Function(String)? onSearch;

  const MainLayout({
    super.key,
    required this.child,
    required this.title,
    required this.selectedIndex,
    required this.onItemSelected,
    this.onSearch,
  });

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width >= 1000;

    Widget sidebarContent = SidebarContent(
      selectedIndex: widget.selectedIndex,
      onItemSelected: widget.onItemSelected,
    );

    return Scaffold(
      drawer: isDesktop ? null : Drawer(child: sidebarContent),
      body: Row(
        children: [
          // Sidebar (Desktop)
          if (isDesktop)
            Container(
              width: 250,
              color: theme.cardTheme.color,
              child: sidebarContent,
            ),

          // Main Content Area
          Expanded(
            child: Column(
              children: [
                // Top Header
                Container(
                  height: 80,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      if (!isDesktop) ...[
                        Builder(
                          builder: (context) => IconButton(
                            icon: const Icon(Icons.menu),
                            onPressed: () => Scaffold.of(context).openDrawer(),
                          ),
                        ),
                        const SizedBox(width: 8),
                      ],
                      Expanded(
                        child: Text(
                          widget.title,
                          style: theme.textTheme.headlineMedium?.copyWith(
                            fontSize: size.width < 600 ? 20 : null,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Search Field
                      Flexible(
                        child: Container(
                          constraints: const BoxConstraints(maxWidth: 300),
                          height: 45,
                          decoration: BoxDecoration(
                            color: theme.scaffoldBackgroundColor,
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                                color:
                                    theme.dividerColor.withValues(alpha: 0.5)),
                          ),
                          child: TextField(
                            onChanged: widget.onSearch,
                            decoration: const InputDecoration(
                              hintText: 'Search...',
                              prefixIcon: Icon(Icons.search),
                              border: InputBorder.none,
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 10),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      IconButton(
                        onPressed: () {},
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        icon: const Icon(Icons.notifications_outlined),
                      ),
                      const SizedBox(width: 10),
                      CircleAvatar(
                        radius: size.width < 600 ? 15 : 20,
                        backgroundColor:
                            theme.primaryColor.withValues(alpha: 0.1),
                        child: Icon(
                          Icons.person,
                          color: theme.primaryColor,
                          size: size.width < 600 ? 18 : 24,
                        ),
                      ),
                    ],
                  ),
                ),

                // Actual Screen Content
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(30),
                    child: widget.child,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SidebarContent extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  const SidebarContent({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        const SizedBox(height: 40),
        Text(
          'WHALE STOCK',
          style: theme.textTheme.headlineMedium?.copyWith(
            color: theme.primaryColor,
            letterSpacing: 2,
            fontSize: 24,
          ),
        ),
        const SizedBox(height: 40),
        SidebarItem(
          title: 'Dashboard',
          icon: Icons.dashboard_outlined,
          isSelected: selectedIndex == 0,
          onTap: () => onItemSelected(0),
        ),
        SidebarItem(
          title: 'Inventory',
          icon: Icons.inventory_2_outlined,
          isSelected: selectedIndex == 1,
          onTap: () => onItemSelected(1),
        ),
        SidebarItem(
          title: 'Reports',
          icon: Icons.bar_chart_outlined,
          isSelected: selectedIndex == 2,
          onTap: () => onItemSelected(2),
        ),
        SidebarItem(
          title: 'Settings',
          icon: Icons.settings_outlined,
          isSelected: selectedIndex == 3,
          onTap: () => onItemSelected(3),
        ),
        const Spacer(),
        const Divider(),
        SidebarItem(
          title: 'Logout',
          icon: Icons.logout,
          isSelected: false,
          onTap: () {},
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
