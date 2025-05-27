import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Art Creator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: const ArtCreatorPage(),
    );
  }
}

class Shape {
  final ShapeType type;
  double size;
  int red;
  int green;
  int blue;
  double opacity;
  double rotation;
  Offset position;

  Shape({
    required this.type,
    this.size = 100,
    this.red = 0,
    this.green = 0,
    this.blue = 0,
    this.opacity = 1.0,
    this.rotation = 0,
    required this.position,
  });

  Color get color => Color.fromRGBO(red, green, blue, opacity);

  Shape copyWith({
    ShapeType? type,
    double? size,
    int? red,
    int? green,
    int? blue,
    double? opacity,
    double? rotation,
    Offset? position,
  }) {
    return Shape(
      type: type ?? this.type,
      size: size ?? this.size,
      red: red ?? this.red,
      green: green ?? this.green,
      blue: blue ?? this.blue,
      opacity: opacity ?? this.opacity,
      rotation: rotation ?? this.rotation,
      position: position ?? this.position,
    );
  }
}

enum ShapeType { circle, square, triangle, star }

class ArtCreatorPage extends StatefulWidget {
  const ArtCreatorPage({super.key});

  @override
  State<ArtCreatorPage> createState() => _ArtCreatorPageState();
}

class _ArtCreatorPageState extends State<ArtCreatorPage> {
  final List<Shape> _shapes = [];
  Shape? _selectedShape;
  int _selectedIndex = -1;
  
  static const double minSize = 50;
  static const double maxSize = 200;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Arte Geométrica'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Limpar tudo',
            onPressed: _clearCanvas,
          ),
          PopupMenuButton(
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'share',
                child: ListTile(
                  leading: Icon(Icons.share),
                  title: Text('Compartilhar'),
                ),
              ),
              const PopupMenuItem(
                value: 'about',
                child: ListTile(
                  leading: Icon(Icons.info),
                  title: Text('Sobre'),
                ),
              ),
            ],
            onSelected: (value) {
              if (value == 'share') {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Função de compartilhar (simulada)')),
                );
              } else if (value == 'about') {
                _showAboutDialog();
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Área de desenho
          Expanded(
            child: GestureDetector(
              onTapDown: (details) => _handleTapDown(details, context),
              child: Container(
                color: Colors.white,
                width: double.infinity,
                child: Stack(
                  children: [
                    // Fundo quadriculado (opcional)
                    CustomPaint(
                      painter: GridPainter(),
                      size: Size.infinite,
                    ),
                    
                    // Formas
                    for (int i = 0; i < _shapes.length; i++)
                      Positioned(
                        left: _shapes[i].position.dx - _shapes[i].size / 2,
                        top: _shapes[i].position.dy - _shapes[i].size / 2,
                        child: GestureDetector(
                          onTap: () => _selectShape(i),
                          child: Transform.rotate(
                            angle: _shapes[i].rotation * math.pi / 180,
                            child: _buildShapeWidget(_shapes[i]),
                          ),
                        ),
                      ),
                      
                    // Instruções iniciais
                    if (_shapes.isEmpty)
                      Center(
                        child: Text(
                          'Toque na tela para adicionar formas\nUse os controles abaixo para personalizar',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
          
          // Painel de controle
          Container(
            color: Colors.grey[200],
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                // Tipos de forma
                if (_selectedShape != null) 
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildShapeButton(ShapeType.circle, 'Círculo'),
                      _buildShapeButton(ShapeType.square, 'Quadrado'),
                      _buildShapeButton(ShapeType.triangle, 'Triângulo'),
                      _buildShapeButton(ShapeType.star, 'Estrela'),
                    ],
                  ),
                
                // Controles
                if (_selectedShape != null) ...[
                  // Tamanho
                  _buildSlider(
                    label: 'Tamanho',
                    value: _selectedShape!.size,
                    min: minSize,
                    max: maxSize,
                    color: Colors.indigo,
                    onChanged: (value) {
                      setState(() {
                        _selectedShape!.size = value;
                        _updateSelectedShape();
                      });
                    },
                  ),
                  
                  // Rotação
                  _buildSlider(
                    label: 'Rotação',
                    value: _selectedShape!.rotation,
                    min: 0,
                    max: 360,
                    color: Colors.orange,
                    onChanged: (value) {
                      setState(() {
                        _selectedShape!.rotation = value;
                        _updateSelectedShape();
                      });
                    },
                  ),
                  
                  // Opacidade
                  _buildSlider(
                    label: 'Opacidade',
                    value: _selectedShape!.opacity,
                    min: 0.1,
                    max: 1.0,
                    color: Colors.blueGrey,
                    onChanged: (value) {
                      setState(() {
                        _selectedShape!.opacity = value;
                        _updateSelectedShape();
                      });
                    },
                  ),
                  
                  // Cores RGB
                  Row(
                    children: [
                      Expanded(
                        child: _buildColorSlider('R', _selectedShape!.red.toDouble(), Colors.red, 
                          (value) {
                            setState(() {
                              _selectedShape!.red = value.toInt();
                              _updateSelectedShape();
                            });
                          }
                        ),
                      ),
                      Expanded(
                        child: _buildColorSlider('G', _selectedShape!.green.toDouble(), Colors.green, 
                          (value) {
                            setState(() {
                              _selectedShape!.green = value.toInt();
                              _updateSelectedShape();
                            });
                          }
                        ),
                      ),
                      Expanded(
                        child: _buildColorSlider('B', _selectedShape!.blue.toDouble(), Colors.blue, 
                          (value) {
                            setState(() {
                              _selectedShape!.blue = value.toInt();
                              _updateSelectedShape();
                            });
                          }
                        ),
                      ),
                    ],
                  ),
                ] else
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Selecione uma forma para editar',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: _selectedShape != null
          ? FloatingActionButton(
              backgroundColor: Colors.red,
              child: const Icon(Icons.delete),
              onPressed: _deleteSelectedShape,
            )
          : FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () => _addRandomShape(context),
            ),
    );
  }

  void _handleTapDown(TapDownDetails details, BuildContext context) {
    // Verifica se tocou em um espaço vazio
    final RenderBox box = context.findRenderObject() as RenderBox;
    final localPosition = box.globalToLocal(details.globalPosition);
    
    // Verifica se o toque foi em uma área vazia (sem formas)
    bool hitShape = false;
    for (int i = 0; i < _shapes.length; i++) {
      final shape = _shapes[i];
      final distance = (shape.position - localPosition).distance;
      if (distance <= shape.size / 2) {
        _selectShape(i);
        hitShape = true;
        break;
      }
    }
    
    if (!hitShape) {
      // Adiciona uma nova forma onde o usuário tocou
      setState(() {
        final random = math.Random();
        final newShape = Shape(
          type: ShapeType.values[random.nextInt(ShapeType.values.length)],
          red: random.nextInt(256),
          green: random.nextInt(256),
          blue: random.nextInt(256),
          size: 100,
          position: localPosition,
        );
        _shapes.add(newShape);
        _selectShape(_shapes.length - 1);
      });
    }
  }

  void _selectShape(int index) {
    setState(() {
      if (index >= 0 && index < _shapes.length) {
        _selectedIndex = index;
        _selectedShape = _shapes[index];
      }
    });
  }

  void _updateSelectedShape() {
    if (_selectedIndex >= 0 && _selectedIndex < _shapes.length) {
      _shapes[_selectedIndex] = _selectedShape!;
    }
  }

  void _deleteSelectedShape() {
    if (_selectedIndex >= 0 && _selectedIndex < _shapes.length) {
      setState(() {
        _shapes.removeAt(_selectedIndex);
        _selectedIndex = -1;
        _selectedShape = null;
      });
    }
  }

  void _clearCanvas() {
    setState(() {
      _shapes.clear();
      _selectedIndex = -1;
      _selectedShape = null;
    });
  }

  void _addRandomShape(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final random = math.Random();
    final newShape = Shape(
      type: ShapeType.values[random.nextInt(ShapeType.values.length)],
      red: random.nextInt(256),
      green: random.nextInt(256),
      blue: random.nextInt(256),
      size: random.nextDouble() * (maxSize - minSize) + minSize,
      position: Offset(
        random.nextDouble() * size.width * 0.8 + size.width * 0.1,
        random.nextDouble() * (size.height - 250) + 100,
      ),
    );
    
    setState(() {
      _shapes.add(newShape);
      _selectShape(_shapes.length - 1);
    });
  }

  void _showAboutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sobre Arte Geométrica'),
        content: const Text(
          'Este aplicativo permite criar composições de arte com formas geométricas. '
          'Toque na tela para adicionar formas e use os controles para personalizá-las.\n\n'
          'Desenvolvido como projeto para estudo do Flutter.'
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Fechar'),
          ),
        ],
      ),
    );
  }

  Widget _buildShapeButton(ShapeType type, String label) {
    bool isSelected = _selectedShape?.type == type;
    return InkWell(
      onTap: () {
        setState(() {
          _selectedShape = _selectedShape!.copyWith(type: type);
          _updateSelectedShape();
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected ? Colors.indigo : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 40,
              height: 40,
              child: _buildShapeIcon(type, isSelected ? Colors.white : Colors.black87),
            ),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black87,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShapeIcon(ShapeType type, Color color) {
    switch (type) {
      case ShapeType.circle:
        return Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.transparent,
            border: Border.all(color: color, width: 2),
          ),
        );
      case ShapeType.square:
        return Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(color: color, width: 2),
          ),
        );
      case ShapeType.triangle:
        return CustomPaint(
          painter: TrianglePainter(color: color, isFilled: false),
          size: const Size(40, 40),
        );
      case ShapeType.star:
        return CustomPaint(
          painter: StarPainter(color: color, isFilled: false),
          size: const Size(40, 40),
        );
    }
  }

  Widget _buildShapeWidget(Shape shape) {
    switch (shape.type) {
      case ShapeType.circle:
        return Container(
          width: shape.size,
          height: shape.size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: shape.color,
          ),
        );
      case ShapeType.square:
        return Container(
          width: shape.size,
          height: shape.size,
          color: shape.color,
        );
      case ShapeType.triangle:
        return CustomPaint(
          painter: TrianglePainter(color: shape.color, isFilled: true),
          size: Size(shape.size, shape.size),
        );
      case ShapeType.star:
        return CustomPaint(
          painter: StarPainter(color: shape.color, isFilled: true),
          size: Size(shape.size, shape.size),
        );
    }
  }

  Widget _buildSlider({
    required String label,
    required double value,
    required double min,
    required double max,
    required Color color,
    required ValueChanged<double> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        children: [
          SizedBox(width: 70, child: Text(label, style: TextStyle(color: color))),
          Expanded(
            child: Slider(
              value: value,
              min: min,
              max: max,
              activeColor: color,
              onChanged: onChanged,
            ),
          ),
          SizedBox(
            width: 40,
            child: Text(
              value.toStringAsFixed(1),
              style: TextStyle(color: color),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildColorSlider(String label, double value, Color color, ValueChanged<double> onChanged) {
    return Row(
      children: [
        Text(label, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
        Expanded(
          child: Slider(
            value: value,
            min: 0,
            max: 255,
            activeColor: color,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}

// Painters personalizados

class GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey[200]!
      ..strokeWidth = 1;
    
    const gridSize = 20.0;
    
    for (double i = 0; i < size.width; i += gridSize) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    }
    
    for (double i = 0; i < size.height; i += gridSize) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class TrianglePainter extends CustomPainter {
  final Color color;
  final bool isFilled;
  
  TrianglePainter({required this.color, required this.isFilled});
  
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = isFilled ? PaintingStyle.fill : PaintingStyle.stroke
      ..strokeWidth = 2;
      
    final path = Path();
    path.moveTo(size.width / 2, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => 
      oldDelegate is TrianglePainter && 
      (oldDelegate.color != color || oldDelegate.isFilled != isFilled);
}

class StarPainter extends CustomPainter {
  final Color color;
  final bool isFilled;
  
  StarPainter({required this.color, required this.isFilled});
  
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = isFilled ? PaintingStyle.fill : PaintingStyle.stroke
      ..strokeWidth = 2;
      
    final path = Path();
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final radius = size.width / 2;
    final innerRadius = radius * 0.4;
    
    for (int i = 0; i < 5; i++) {
      final outerAngle = -math.pi / 2 + 2 * math.pi * i / 5;
      final innerAngle = -math.pi / 2 + 2 * math.pi * (i + 0.5) / 5;
      
      final outerX = centerX + radius * math.cos(outerAngle);
      final outerY = centerY + radius * math.sin(outerAngle);
      final innerX = centerX + innerRadius * math.cos(innerAngle);
      final innerY = centerY + innerRadius * math.sin(innerAngle);
      
      if (i == 0) {
        path.moveTo(outerX, outerY);
      } else {
        path.lineTo(outerX, outerY);
      }
      
      path.lineTo(innerX, innerY);
    }
    
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => 
      oldDelegate is StarPainter && 
      (oldDelegate.color != color || oldDelegate.isFilled != isFilled);
}
