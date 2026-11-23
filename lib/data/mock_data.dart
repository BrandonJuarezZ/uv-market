import 'package:flutter/material.dart';

class Product {
  final String id;
  final String title;
  final String description;
  final String category;
  final String condition;
  final String seller;
  final String faculty;
  final String date;
  final double price;
  final IconData icon;
  final Color color;

  const Product({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.condition,
    required this.seller,
    required this.faculty,
    required this.date,
    required this.price,
    required this.icon,
    required this.color,
  });
}

class ChatPreview {
  final String name;
  final String lastMessage;
  final String time;
  final int unread;
  const ChatPreview(this.name, this.lastMessage, this.time, this.unread);
}

class ReportItem {
  final String target;
  final String reason;
  final String reporter;
  final String date;
  const ReportItem(this.target, this.reason, this.reporter, this.date);
}

class UserItem {
  final String name;
  final String email;
  final String faculty;
  final int posts;
  bool active;
  UserItem(this.name, this.email, this.faculty, this.posts, this.active);
}

const categories = [
  'Libros',
  'Apuntes',
  'Electrónica',
  'Calculadoras',
  'Ropa',
  'Laboratorio',
  'Otros',
];

const conditions = ['Nuevo', 'Como nuevo', 'Buen estado', 'Usado'];

const meetingPoints = [
  'Biblioteca',
  'Cafetería',
  'Explanada principal',
  'Entrada principal',
  'Edificio de Ingeniería',
];

const faculties = [
  'Facultad de Ingeniería',
  'Facultad de Ciencias Químicas',
  'Facultad de Contaduría',
  'Facultad de Arquitectura',
  'Facultad de Medicina',
];

const products = <Product>[
  Product(
    id: '1',
    title: 'Cálculo de Thomas, 12ª edición',
    description:
        'Libro en buen estado, sin hojas rotas. Tiene algunos subrayados a lápiz en los primeros capítulos.',
    category: 'Libros',
    condition: 'Buen estado',
    seller: 'Ana Torres',
    faculty: 'Facultad de Ingeniería',
    date: '15 nov',
    price: 350,
    icon: Icons.menu_book,
    color: Color(0xFFC5CAE9),
  ),
  Product(
    id: '2',
    title: 'Calculadora científica Casio fx-991',
    description:
        'Funciona perfecto, incluye tapa y pilas nuevas. La uso poco porque ya compré otra.',
    category: 'Calculadoras',
    condition: 'Como nuevo',
    seller: 'Luis Pérez',
    faculty: 'Facultad de Ciencias Químicas',
    date: '14 nov',
    price: 280,
    icon: Icons.calculate,
    color: Color(0xFFFFE0B2),
  ),
  Product(
    id: '3',
    title: 'Apuntes de Estructuras de Datos',
    description:
        'Apuntes completos del semestre, impresos y engargolados. Incluye ejercicios resueltos.',
    category: 'Apuntes',
    condition: 'Usado',
    seller: 'María Gómez',
    faculty: 'Facultad de Ingeniería',
    date: '14 nov',
    price: 60,
    icon: Icons.description,
    color: Color(0xFFC8E6C9),
  ),
  Product(
    id: '4',
    title: 'Bata de laboratorio talla M',
    description: 'Bata blanca de algodón, usada un semestre. Lavada y lista para usar.',
    category: 'Laboratorio',
    condition: 'Buen estado',
    seller: 'Carlos Ruiz',
    faculty: 'Facultad de Ciencias Químicas',
    date: '13 nov',
    price: 120,
    icon: Icons.science,
    color: Color(0xFFB3E5FC),
  ),
  Product(
    id: '5',
    title: 'Audífonos inalámbricos',
    description: 'Bluetooth, con estuche de carga. La batería dura todo el día.',
    category: 'Electrónica',
    condition: 'Como nuevo',
    seller: 'Daniela Cruz',
    faculty: 'Facultad de Contaduría',
    date: '12 nov',
    price: 450,
    icon: Icons.headphones,
    color: Color(0xFFF8BBD0),
  ),
  Product(
    id: '6',
    title: 'Juego de escuadras y compás',
    description: 'Material de dibujo técnico completo, en estuche rígido.',
    category: 'Otros',
    condition: 'Buen estado',
    seller: 'Jorge Ramírez',
    faculty: 'Facultad de Arquitectura',
    date: '12 nov',
    price: 90,
    icon: Icons.architecture,
    color: Color(0xFFD1C4E9),
  ),
  Product(
    id: '7',
    title: 'Sudadera UV talla L',
    description: 'Sudadera oficial, color azul marino. Solo se usó un par de veces.',
    category: 'Ropa',
    condition: 'Como nuevo',
    seller: 'Paola Hernández',
    faculty: 'Facultad de Medicina',
    date: '11 nov',
    price: 200,
    icon: Icons.checkroom,
    color: Color(0xFFFFCCBC),
  ),
  Product(
    id: '8',
    title: 'Arduino UNO con kit de sensores',
    description:
        'Incluye placa, protoboard, cables y sensores básicos. Ideal para proyectos de la materia.',
    category: 'Electrónica',
    condition: 'Buen estado',
    seller: 'Iván Morales',
    faculty: 'Facultad de Ingeniería',
    date: '10 nov',
    price: 380,
    icon: Icons.memory,
    color: Color(0xFFB2DFDB),
  ),
];

const chats = <ChatPreview>[
  ChatPreview('Ana Torres', '¿Sigue disponible el libro?', '10:24', 2),
  ChatPreview('Luis Pérez', 'Va, nos vemos en la biblioteca', 'Ayer', 0),
  ChatPreview('María Gómez', 'Te paso los apuntes mañana', 'Ayer', 0),
  ChatPreview('Carlos Ruiz', 'Gracias, ya la recibí', 'Lun', 0),
];

const reports = <ReportItem>[
  ReportItem('Audífonos inalámbricos', 'Posible fraude (precio sospechoso)', 'Luis Pérez', '16 nov'),
  ReportItem('Apuntes de Estructuras de Datos', 'Contenido con derechos de autor', 'Ana Torres', '15 nov'),
  ReportItem('Usuario: Iván Morales', 'Comportamiento inapropiado en el chat', 'María Gómez', '14 nov'),
];

final users = <UserItem>[
  UserItem('Ana Torres', 'ana.torres@estudiantes.uv.mx', 'Facultad de Ingeniería', 5, true),
  UserItem('Luis Pérez', 'luis.perez@estudiantes.uv.mx', 'Facultad de Ciencias Químicas', 3, true),
  UserItem('María Gómez', 'maria.gomez@estudiantes.uv.mx', 'Facultad de Ingeniería', 8, true),
  UserItem('Carlos Ruiz', 'carlos.ruiz@estudiantes.uv.mx', 'Facultad de Ciencias Químicas', 2, true),
  UserItem('Iván Morales', 'ivan.morales@estudiantes.uv.mx', 'Facultad de Ingeniería', 1, false),
  UserItem('Paola Hernández', 'paola.hernandez@estudiantes.uv.mx', 'Facultad de Medicina', 4, true),
];
