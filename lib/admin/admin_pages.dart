import 'package:flutter/material.dart';

import '../data/mock_data.dart';
import '../theme.dart';

// ------------------------------------------------------------ Widgets comunes
class PageHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  const PageHeader({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(subtitle, style: TextStyle(color: Colors.grey.shade700)),
        ],
      ),
    );
  }
}

class AdminPanel extends StatelessWidget {
  final double width;
  final String title;
  final Widget child;
  const AdminPanel(
      {super.key, required this.width, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(20),
      decoration: cardBox(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;
  const _StatCard(this.label, this.value, this.icon, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      padding: const EdgeInsets.all(20),
      decoration: cardBox(),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withAlpha(30),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(value,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                Text(label, style: TextStyle(color: Colors.grey.shade700)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BarRow extends StatelessWidget {
  final String label;
  final int value;
  final int max;
  const _BarRow(this.label, this.value, this.max);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          SizedBox(width: 130, child: Text(label, overflow: TextOverflow.ellipsis)),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: LinearProgressIndicator(value: value / max, minHeight: 12),
            ),
          ),
          SizedBox(
            width: 36,
            child: Text('$value', textAlign: TextAlign.right),
          ),
        ],
      ),
    );
  }
}

// ------------------------------------------------------------ Dashboard
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    const byCategory = {
      'Libros': 48,
      'Apuntes': 36,
      'Electrónica': 29,
      'Calculadoras': 22,
      'Ropa': 17,
      'Laboratorio': 14,
      'Otros': 9,
    };
    const byFaculty = {
      'Ingeniería': 92,
      'Ciencias Químicas': 61,
      'Contaduría': 40,
      'Arquitectura': 27,
      'Medicina': 18,
    };

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PageHeader(
            title: 'Resumen general',
            subtitle: 'Actividad reciente de la plataforma',
          ),
          const Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              _StatCard('Usuarios activos', '1,284', Icons.people, Color(0xFF0B5C8E)),
              _StatCard('Publicaciones activas', '175', Icons.inventory_2, Color(0xFF2E7D32)),
              _StatCard('Pendientes de moderación', '5', Icons.pending_actions, Color(0xFFEF6C00)),
              _StatCard('Reportes abiertos', '3', Icons.flag, Color(0xFFC62828)),
            ],
          ),
          const SizedBox(height: 24),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              AdminPanel(
                width: 520,
                title: 'Publicaciones por categoría',
                child: Column(
                  children: byCategory.entries
                      .map((e) => _BarRow(e.key, e.value, 48))
                      .toList(),
                ),
              ),
              AdminPanel(
                width: 460,
                title: 'Usuarios activos por facultad',
                child: Column(
                  children: byFaculty.entries
                      .map((e) => _BarRow(e.key, e.value, 92))
                      .toList(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ------------------------------------------------------------ Moderación
class ModerationPage extends StatefulWidget {
  const ModerationPage({super.key});

  @override
  State<ModerationPage> createState() => _ModerationPageState();
}

class _ModerationPageState extends State<ModerationPage> {
  late List<Product> _pending;

  @override
  void initState() {
    super.initState();
    _pending = products.take(5).toList();
  }

  void _resolve(Product p, String action) {
    setState(() => _pending.remove(p));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Publicación "${p.title}" $action')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PageHeader(
            title: 'Publicaciones pendientes',
            subtitle: 'Revisa y aprueba o rechaza las publicaciones nuevas',
          ),
          Container(
            width: double.infinity,
            decoration: cardBox(),
            child: _pending.isEmpty
                ? const Padding(
                    padding: EdgeInsets.all(32),
                    child: Center(child: Text('No hay publicaciones pendientes')),
                  )
                : SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columns: const [
                        DataColumn(label: Text('Publicación')),
                        DataColumn(label: Text('Vendedor')),
                        DataColumn(label: Text('Categoría')),
                        DataColumn(label: Text('Precio')),
                        DataColumn(label: Text('Fecha')),
                        DataColumn(label: Text('Acciones')),
                      ],
                      rows: _pending
                          .map(
                            (p) => DataRow(cells: [
                              DataCell(Text(p.title)),
                              DataCell(Text(p.seller)),
                              DataCell(Text(p.category)),
                              DataCell(Text('\$${p.price.toStringAsFixed(0)}')),
                              DataCell(Text(p.date)),
                              DataCell(Row(
                                children: [
                                  IconButton(
                                    tooltip: 'Aprobar',
                                    icon: const Icon(Icons.check_circle_outline,
                                        color: Colors.green),
                                    onPressed: () => _resolve(p, 'aprobada'),
                                  ),
                                  IconButton(
                                    tooltip: 'Rechazar',
                                    icon: const Icon(Icons.cancel_outlined,
                                        color: Colors.red),
                                    onPressed: () => _resolve(p, 'rechazada'),
                                  ),
                                ],
                              )),
                            ]),
                          )
                          .toList(),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

// ------------------------------------------------------------ Reportes
class ReportsPage extends StatefulWidget {
  const ReportsPage({super.key});

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  late List<ReportItem> _items;

  @override
  void initState() {
    super.initState();
    _items = List.of(reports);
  }

  void _resolve(ReportItem r, String msg) {
    setState(() => _items.remove(r));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PageHeader(
            title: 'Reportes de usuarios',
            subtitle: 'Publicaciones y usuarios reportados por la comunidad',
          ),
          if (_items.isEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(32),
              decoration: cardBox(),
              child: const Center(child: Text('No hay reportes abiertos')),
            ),
          ..._items.map(
            (r) => Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: cardBox(),
              child: Row(
                children: [
                  const Icon(Icons.flag, color: Colors.red),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(r.target,
                            style: const TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text('Motivo: ${r.reason}'),
                        Text('Reportado por ${r.reporter} · ${r.date}',
                            style: TextStyle(color: Colors.grey.shade600)),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      TextButton(
                        onPressed: () => _resolve(r, 'Reporte descartado'),
                        child: const Text('Descartar'),
                      ),
                      OutlinedButton(
                        onPressed: () => _resolve(r, 'Publicación eliminada'),
                        child: const Text('Eliminar publicación'),
                      ),
                      FilledButton(
                        onPressed: () => _resolve(r, 'Usuario suspendido'),
                        child: const Text('Suspender usuario'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ------------------------------------------------------------ Usuarios
class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final list = users
        .where((u) =>
            u.name.toLowerCase().contains(_query.toLowerCase()) ||
            u.email.toLowerCase().contains(_query.toLowerCase()))
        .toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PageHeader(
            title: 'Gestión de usuarios',
            subtitle: 'Consulta, suspende o reactiva cuentas',
          ),
          SizedBox(
            width: 360,
            child: TextField(
              onChanged: (v) => setState(() => _query = v),
              decoration: const InputDecoration(
                hintText: 'Buscar por nombre o correo',
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            decoration: cardBox(),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Nombre')),
                  DataColumn(label: Text('Correo')),
                  DataColumn(label: Text('Facultad')),
                  DataColumn(label: Text('Publicaciones'), numeric: true),
                  DataColumn(label: Text('Estado')),
                  DataColumn(label: Text('Acción')),
                ],
                rows: list
                    .map(
                      (u) => DataRow(cells: [
                        DataCell(Text(u.name)),
                        DataCell(Text(u.email)),
                        DataCell(Text(u.faculty)),
                        DataCell(Text('${u.posts}')),
                        DataCell(Chip(
                          label: Text(u.active ? 'Activo' : 'Suspendido'),
                          backgroundColor: u.active
                              ? Colors.green.shade100
                              : Colors.red.shade100,
                        )),
                        DataCell(TextButton(
                          onPressed: () => setState(() => u.active = !u.active),
                          child: Text(u.active ? 'Suspender' : 'Reactivar'),
                        )),
                      ]),
                    )
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ------------------------------------------------------------ Catálogos
class CatalogsPage extends StatefulWidget {
  const CatalogsPage({super.key});

  @override
  State<CatalogsPage> createState() => _CatalogsPageState();
}

class _CatalogsPageState extends State<CatalogsPage> {
  final List<String> _cats = List.of(categories);
  final List<String> _points = List.of(meetingPoints);

  Future<String?> _ask(String title) {
    final controller = TextEditingController();
    return showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: TextField(controller: controller, autofocus: true),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, controller.text.trim()),
            child: const Text('Agregar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PageHeader(
            title: 'Catálogos',
            subtitle: 'Administra las categorías y los puntos de encuentro seguros',
          ),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            crossAxisAlignment: WrapCrossAlignment.start,
            children: [
              AdminPanel(
                width: 480,
                title: 'Categorías',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _cats
                          .map((c) => InputChip(
                                label: Text(c),
                                onDeleted: () => setState(() => _cats.remove(c)),
                              ))
                          .toList(),
                    ),
                    const SizedBox(height: 16),
                    FilledButton.tonalIcon(
                      onPressed: () async {
                        final v = await _ask('Nueva categoría');
                        if (v != null && v.isNotEmpty) {
                          setState(() => _cats.add(v));
                        }
                      },
                      icon: const Icon(Icons.add),
                      label: const Text('Agregar categoría'),
                    ),
                  ],
                ),
              ),
              AdminPanel(
                width: 480,
                title: 'Puntos de encuentro seguros',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ..._points.map(
                      (p) => ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        leading: const Icon(Icons.place_outlined),
                        title: Text(p),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete_outline),
                          onPressed: () => setState(() => _points.remove(p)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    FilledButton.tonalIcon(
                      onPressed: () async {
                        final v = await _ask('Nuevo punto de encuentro');
                        if (v != null && v.isNotEmpty) {
                          setState(() => _points.add(v));
                        }
                      },
                      icon: const Icon(Icons.add_location_alt_outlined),
                      label: const Text('Agregar punto'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
