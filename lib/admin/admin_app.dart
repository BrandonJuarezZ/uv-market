import 'package:flutter/material.dart';

import '../theme.dart';
import 'admin_pages.dart';

class AdminApp extends StatelessWidget {
  const AdminApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UV Market · Administración',
      debugShowCheckedModeBanner: false,
      theme: buildTheme(),
      home: const AdminLoginScreen(),
    );
  }
}

class AdminLoginScreen extends StatelessWidget {
  const AdminLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Container(
            margin: const EdgeInsets.all(24),
            padding: const EdgeInsets.all(32),
            decoration: cardBox(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.admin_panel_settings, size: 64, color: primary),
                const SizedBox(height: 12),
                Text('UV Market',
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(fontWeight: FontWeight.bold)),
                const Text('Panel de administración'),
                const SizedBox(height: 28),
                const TextField(
                  decoration: InputDecoration(
                    labelText: 'Correo de administrador',
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                ),
                const SizedBox(height: 16),
                const TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    prefixIcon: Icon(Icons.lock_outline),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const AdminShell()),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 14),
                      child: Text('Entrar'),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text('Acceso exclusivo para moderadores y administradores',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AdminShell extends StatefulWidget {
  const AdminShell({super.key});

  @override
  State<AdminShell> createState() => _AdminShellState();
}

class _AdminShellState extends State<AdminShell> {
  int _index = 0;
  static const _titles = [
    'Dashboard',
    'Moderación de publicaciones',
    'Reportes',
    'Usuarios',
    'Catálogos',
  ];

  @override
  Widget build(BuildContext context) {
    const pages = <Widget>[
      DashboardPage(),
      ModerationPage(),
      ReportsPage(),
      UsersPage(),
      CatalogsPage(),
    ];
    final primary = Theme.of(context).colorScheme.primary;

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final wide = constraints.maxWidth >= 1000;
          return Row(
            children: [
              NavigationRail(
                extended: wide,
                labelType: wide ? null : NavigationRailLabelType.all,
                selectedIndex: _index,
                onDestinationSelected: (i) => setState(() => _index = i),
                leading: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.storefront, size: 28, color: primary),
                      if (wide) ...[
                        const SizedBox(width: 8),
                        const Text('UV Market',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                      ],
                    ],
                  ),
                ),
                destinations: const [
                  NavigationRailDestination(
                      icon: Icon(Icons.dashboard_outlined),
                      selectedIcon: Icon(Icons.dashboard),
                      label: Text('Dashboard')),
                  NavigationRailDestination(
                      icon: Icon(Icons.fact_check_outlined),
                      selectedIcon: Icon(Icons.fact_check),
                      label: Text('Moderación')),
                  NavigationRailDestination(
                      icon: Icon(Icons.flag_outlined),
                      selectedIcon: Icon(Icons.flag),
                      label: Text('Reportes')),
                  NavigationRailDestination(
                      icon: Icon(Icons.people_outline),
                      selectedIcon: Icon(Icons.people),
                      label: Text('Usuarios')),
                  NavigationRailDestination(
                      icon: Icon(Icons.category_outlined),
                      selectedIcon: Icon(Icons.category),
                      label: Text('Catálogos')),
                ],
                trailing: Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: IconButton(
                        tooltip: 'Cerrar sesión',
                        icon: const Icon(Icons.logout),
                        onPressed: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const AdminLoginScreen()),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const VerticalDivider(width: 1),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      height: 64,
                      color: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Row(
                        children: [
                          Text(_titles[_index],
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(fontWeight: FontWeight.w600)),
                          const Spacer(),
                          const Text('Administrador'),
                          const SizedBox(width: 12),
                          const CircleAvatar(child: Icon(Icons.person)),
                        ],
                      ),
                    ),
                    const Divider(height: 1),
                    Expanded(child: pages[_index]),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
