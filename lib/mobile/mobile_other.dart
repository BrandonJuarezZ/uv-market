import 'package:flutter/material.dart';

import '../data/mock_data.dart';
import '../theme.dart';
import 'mobile_app.dart';
import 'mobile_home.dart';

// ---------------------------------------------------------------- Favoritos
class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favs = products.take(3).toList();
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.78,
      ),
      itemCount: favs.length,
      itemBuilder: (context, i) => ProductCard(product: favs[i]),
    );
  }
}

// ---------------------------------------------------------------- Publicar
class PublishScreen extends StatefulWidget {
  const PublishScreen({super.key});

  @override
  State<PublishScreen> createState() => _PublishScreenState();
}

class _PublishScreenState extends State<PublishScreen> {
  String _category = categories.first;
  String _condition = conditions[2];
  String _point = meetingPoints.first;

  void _snack(String msg) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nueva publicación')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _snack('Aquí se abrirá la cámara'),
                  icon: const Icon(Icons.photo_camera_outlined),
                  label: const Text('Tomar foto'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _snack('Aquí se abrirá la galería'),
                  icon: const Icon(Icons.photo_library_outlined),
                  label: const Text('Galería'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: List.generate(
              3,
              (i) => Expanded(
                child: Container(
                  height: 90,
                  margin: EdgeInsets.only(right: i < 2 ? 8 : 0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade400),
                  ),
                  child: Icon(Icons.add_photo_alternate_outlined,
                      color: Colors.grey.shade500),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const TextField(decoration: InputDecoration(labelText: 'Título')),
          const SizedBox(height: 16),
          const TextField(
            maxLines: 4,
            decoration: InputDecoration(
              labelText: 'Descripción',
              alignLabelWithHint: true,
            ),
          ),
          const SizedBox(height: 16),
          const TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Precio', prefixText: '\$ '),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: _category,
            decoration: const InputDecoration(labelText: 'Categoría'),
            items: categories
                .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                .toList(),
            onChanged: (v) => setState(() => _category = v ?? _category),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: _condition,
            decoration: const InputDecoration(labelText: 'Estado del artículo'),
            items: conditions
                .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                .toList(),
            onChanged: (v) => setState(() => _condition = v ?? _condition),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: _point,
            decoration:
                const InputDecoration(labelText: 'Punto de encuentro sugerido'),
            items: meetingPoints
                .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                .toList(),
            onChanged: (v) => setState(() => _point = v ?? _point),
          ),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: () {
              final messenger = ScaffoldMessenger.of(context);
              Navigator.pop(context);
              messenger.showSnackBar(const SnackBar(
                  content: Text('Publicación enviada a revisión')));
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 14),
              child: Text('Publicar'),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------- Chats
class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: chats.length,
      separatorBuilder: (context, index) => const Divider(height: 1),
      itemBuilder: (context, i) {
        final c = chats[i];
        return ListTile(
          leading: CircleAvatar(child: Text(c.name[0])),
          title: Text(c.name,
              style: TextStyle(
                  fontWeight: c.unread > 0 ? FontWeight.bold : FontWeight.normal)),
          subtitle: Text(c.lastMessage, maxLines: 1, overflow: TextOverflow.ellipsis),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(c.time, style: const TextStyle(fontSize: 12)),
              if (c.unread > 0) ...[
                const SizedBox(height: 4),
                CircleAvatar(
                  radius: 10,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  child: Text('${c.unread}',
                      style: const TextStyle(fontSize: 11, color: Colors.white)),
                ),
              ],
            ],
          ),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => ConversationScreen(name: c.name)),
          ),
        );
      },
    );
  }
}

class _Msg {
  final String text;
  final bool mine;
  const _Msg(this.text, this.mine);
}

class ConversationScreen extends StatefulWidget {
  final String name;
  const ConversationScreen({super.key, required this.name});

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  final _controller = TextEditingController();
  final List<_Msg> _messages = [
    const _Msg('Hola, ¿sigue disponible?', true),
    const _Msg('¡Hola! Sí, todavía lo tengo.', false),
    const _Msg('¿Te parece si nos vemos en la biblioteca?', true),
    const _Msg('Va, mañana a las 12:00.', false),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _send() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    setState(() => _messages.add(_Msg(text, true)));
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(radius: 16, child: Text(widget.name[0])),
            const SizedBox(width: 12),
            Text(widget.name),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, i) {
                final m = _messages[i];
                return Align(
                  alignment: m.mine ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    constraints: const BoxConstraints(maxWidth: 280),
                    decoration: BoxDecoration(
                      color: m.mine ? scheme.primaryContainer : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(m.text),
                  ),
                );
              },
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      onSubmitted: (_) => _send(),
                      decoration: const InputDecoration(
                        hintText: 'Escribe un mensaje…',
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton.filled(
                    onPressed: _send,
                    icon: const Icon(Icons.send),
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

// ---------------------------------------------------------------- Perfil
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Widget _stat(String value, String label) => Expanded(
        child: Column(
          children: [
            Text(value,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text(label, style: TextStyle(color: Colors.grey.shade600)),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const SizedBox(height: 8),
        const Center(child: CircleAvatar(radius: 44, child: Icon(Icons.person, size: 44))),
        const SizedBox(height: 12),
        const Center(
          child: Text('Estudiante UV',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ),
        Center(
          child: Text('estudiante@estudiantes.uv.mx',
              style: TextStyle(color: Colors.grey.shade600)),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: cardBox(),
          child: Row(
            children: [
              _stat('5', 'Publicaciones'),
              _stat('12', 'Vendidos'),
              _stat('4.8 ★', 'Calificación'),
            ],
          ),
        ),
        const SizedBox(height: 16),
        const ListTile(
            leading: Icon(Icons.inventory_2_outlined), title: Text('Mis publicaciones')),
        const ListTile(
            leading: Icon(Icons.history), title: Text('Historial de ventas y compras')),
        const ListTile(
            leading: Icon(Icons.place_outlined), title: Text('Puntos de encuentro')),
        const ListTile(
            leading: Icon(Icons.settings_outlined), title: Text('Configuración')),
        ListTile(
          leading: const Icon(Icons.logout, color: Colors.red),
          title: const Text('Cerrar sesión', style: TextStyle(color: Colors.red)),
          onTap: () => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const LoginScreen()),
            (route) => false,
          ),
        ),
      ],
    );
  }
}
