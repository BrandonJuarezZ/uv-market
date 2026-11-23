import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

import 'admin/admin_app.dart';
import 'mobile/mobile_app.dart';

/// Permite forzar una interfaz al ejecutar:
///   flutter run -d chrome --dart-define=APP=mobile   (ver la app móvil en el navegador)
///   flutter run -d chrome --dart-define=APP=admin    (panel web)
const String _target = String.fromEnvironment('APP');

void main() {
  // Por defecto: en web se abre el panel de administración; en Android/iOS, la app de usuario.
  final bool admin = _target == 'admin' || (_target.isEmpty && kIsWeb);
  runApp(admin ? const AdminApp() : const MobileApp());
}
