import 'package:flutter/material.dart';
import 'package:ptit_quiz_frontend/presentation/screens/widgets/ptit_logo.dart';

class AppSideNavigation extends StatefulWidget {
  final Widget child;

  const AppSideNavigation({super.key, required this.child});

  @override
  State<AppSideNavigation> createState() => _AppSideNavigationState();
}

class _AppSideNavigationState extends State<AppSideNavigation> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Row(
          children: [
            NavigationRail(
              extended: true,
              selectedIndex: _selectedIndex,
              groupAlignment: -1.0,
              onDestinationSelected: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              selectedLabelTextStyle: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 16,
                fontWeight: FontWeight.w900,
              ),
              labelType: NavigationRailLabelType.none,
              leading: const Padding(
                padding: EdgeInsets.all(16.0),
                child: PtitLogo(size: 120),
              ),
              trailing:IconButton(
                onPressed: () {
                  // Add your onPressed code here!
                },
                icon: const Icon(Icons.more_horiz_rounded),
              ),
              destinations: const <NavigationRailDestination>[
                NavigationRailDestination(
                  icon: Icon(Icons.favorite_border),
                  selectedIcon: Icon(Icons.favorite),
                  label: Text('First'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.bookmark_border),
                  selectedIcon: Icon(Icons.book),
                  label: Text('Second'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.star_border),
                  selectedIcon: Icon(Icons.star),
                  label: Text('Third'),
                ),
              ],
            ),
            const VerticalDivider(thickness: 1, width: 1),
            Expanded(
              child: Scaffold(
                appBar: AppBar(
                  title: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'PTIT Quiz',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                  actions: [
                    IconButton(
                      onPressed: () {
                        // Add your onPressed code here!
                      },
                      icon: const Icon(Icons.search),
                    ),
                    IconButton(
                      onPressed: () {
                        // Add your onPressed code here!
                      },
                      icon: const Icon(Icons.more_vert),
                    ),
                  ],
                ),
                body: widget.child,
              )
            ),
          ],
        ),
      ),
    );
  }
}