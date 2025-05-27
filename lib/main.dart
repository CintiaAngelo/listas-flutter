// import 'package:flutter/material.dart';

// void main() => runApp(const MyApp());

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Contatos App',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const ContactsScreen(),
//     );
//   }
// }

// enum ContatoCategoria { trabalho, amigos, familia, outros }

// extension ContatoCategoriaExtension on ContatoCategoria {
//   String get displayName {
//     switch (this) {
//       case ContatoCategoria.trabalho: return 'Trabalho';
//       case ContatoCategoria.amigos: return 'Amigos';
//       case ContatoCategoria.familia: return 'Família';
//       case ContatoCategoria.outros: return 'Outros';
//     }
//   }
  
//   IconData get icon {
//     switch (this) {
//       case ContatoCategoria.trabalho: return Icons.work;
//       case ContatoCategoria.amigos: return Icons.group;
//       case ContatoCategoria.familia: return Icons.family_restroom;
//       case ContatoCategoria.outros: return Icons.person;
//     }
//   }
  
//   Color get color {
//     switch (this) {
//       case ContatoCategoria.trabalho: return Colors.blue;
//       case ContatoCategoria.amigos: return Colors.green;
//       case ContatoCategoria.familia: return Colors.orange;
//       case ContatoCategoria.outros: return Colors.purple;
//     }
//   }
// }

// class Contato {
//   final String id;
//   final String nomeCompleto;
//   final String email;
//   final String telefone;
//   final String foto;
//   final ContatoCategoria categoria;
//   bool isFavorite;

//   Contato({
//     required this.nomeCompleto, 
//     required this.email, 
//     this.telefone = '',
//     this.foto = '',
//     this.categoria = ContatoCategoria.outros,
//     this.isFavorite = false,
//   }) : id = DateTime.now().millisecondsSinceEpoch.toString();
// }

// class ContactsScreen extends StatefulWidget {
//   const ContactsScreen({super.key});

//   @override
//   State<ContactsScreen> createState() => _ContactsScreenState();
// }

// class _ContactsScreenState extends State<ContactsScreen> with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   int _currentIndex = 0;
//   bool _isGridView = false;
  
//   // Lista simplificada de contatos
//   final List<Contato> _contatos = [
//     Contato(
//       nomeCompleto: 'John Doe', 
//       email: 'john_doece@gmail.com',
//       telefone: '+1 555-123-4567',
//       categoria: ContatoCategoria.trabalho,
//     ),
//     Contato(
//       nomeCompleto: 'Alice O. Austin', 
//       email: 'AliceOAustin@rhyta.com',
//       telefone: '+1 555-234-5678',
//       categoria: ContatoCategoria.amigos,
//     ),
//     Contato(
//       nomeCompleto: 'Douglas R. Broadway', 
//       email: 'DouglasRBroadway@dayrep.com',
//       telefone: '+1 555-345-6789',
//       categoria: ContatoCategoria.familia,
//     ),
//   ];

//   List<Contato> get _favoritos => 
//       _contatos.where((contato) => contato.isFavorite).toList();
  
//   int get _favoritesCount => _favoritos.length;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//     _tabController.addListener(() {
//       if (_tabController.indexIsChanging) {
//         setState(() {
//           _currentIndex = _tabController.index;
//         });
//       }
//     });
//   }
  
//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   void _toggleFavorite(Contato contato) {
//     setState(() {
//       contato.isFavorite = !contato.isFavorite;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Contatos Favoritos $_favoritesCount'),
//         actions: [
//           IconButton(
//             icon: Icon(_isGridView ? Icons.list : Icons.grid_view),
//             onPressed: () {
//               setState(() {
//                 _isGridView = !_isGridView;
//               });
//             },
//           ),
//         ],
//         bottom: TabBar(
//           controller: _tabController,
//           tabs: const [
//             Tab(text: 'Todos', icon: Icon(Icons.people)),
//             Tab(text: 'Favoritos', icon: Icon(Icons.favorite)),
//           ],
//         ),
//       ),
//       drawer: Drawer(
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: [
//             UserAccountsDrawerHeader(
//               accountName: const Text('José da Silva Vieira'),
//               accountEmail: const Text('jsilvavieira@github.com'),
//               currentAccountPicture: const CircleAvatar(
//                 backgroundImage: NetworkImage('https://randomuser.me/api/portraits/men/31.jpg'),
//               ),
//             ),
//             ListTile(
//               leading: const Icon(Icons.person),
//               title: const Text('Perfil'),
//               onTap: () => Navigator.pop(context),
//             ),
//             ListTile(
//               leading: const Icon(Icons.book),
//               title: const Text('Repositórios'),
//               onTap: () => Navigator.pop(context),
//             ),
//             ListTile(
//               leading: const Icon(Icons.star),
//               title: const Text('Favoritos'),
//               onTap: () {
//                 Navigator.pop(context);
//                 _tabController.animateTo(1);
//               },
//             ),
//           ],
//         ),
//       ),
//       body: TabBarView(
//         controller: _tabController,
//         children: [
//           // Tab de todos os contatos
//           _buildContactsList(_contatos),
//           // Tab de favoritos
//           _buildContactsList(_favoritos),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           // Simplificado: apenas mostrar uma mensagem
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Adicionar contato (não implementado)')),
//           );
//         },
//         child: const Icon(Icons.add),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _currentIndex,
//         onTap: (index) {
//           setState(() {
//             _currentIndex = index;
//             if (index < 2) {
//               _tabController.animateTo(index);
//             } else {
//               // Simplificado: apenas mostrar uma mensagem para configurações
//               ScaffoldMessenger.of(context).showSnackBar(
//                 const SnackBar(content: Text('Configurações (não implementado)')),
//               );
//             }
//           });
//         },
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.people),
//             label: 'Contatos',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.favorite),
//             label: 'Favoritos',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.settings),
//             label: 'Configurações',
//           ),
//         ],
//       ),
//     );
//   }
  
//   Widget _buildContactsList(List<Contato> contatos) {
//     if (contatos.isEmpty) {
//       return const Center(
//         child: Text('Nenhum contato encontrado'),
//       );
//     }
    
//     if (_isGridView) {
//       return GridView.builder(
//         padding: const EdgeInsets.all(8.0),
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           childAspectRatio: 0.75,
//           crossAxisSpacing: 10,
//           mainAxisSpacing: 10,
//         ),
//         itemCount: contatos.length,
//         itemBuilder: (context, index) {
//           final contato = contatos[index];
//           return Card(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Expanded(
//                   flex: 2,
//                   child: Container(
//                     color: contato.categoria.color.withOpacity(0.2),
//                     alignment: Alignment.center,
//                     child: Text(
//                       contato.nomeCompleto[0].toUpperCase(),
//                       style: TextStyle(
//                         fontSize: 40,
//                         fontWeight: FontWeight.bold,
//                         color: contato.categoria.color,
//                       ),
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     children: [
//                       Text(
//                         contato.nomeCompleto,
//                         style: const TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 14,
//                         ),
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                         textAlign: TextAlign.center,
//                       ),
//                       Text(
//                         contato.email,
//                         style: TextStyle(
//                           fontSize: 12,
//                           color: Colors.grey[600],
//                         ),
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                         textAlign: TextAlign.center,
//                       ),
//                     ],
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(
//                     contato.isFavorite ? Icons.favorite : Icons.favorite_border,
//                     color: contato.isFavorite ? Colors.red : null,
//                   ),
//                   onPressed: () => _toggleFavorite(contato),
//                 ),
//               ],
//             ),
//           );
//         },
//       );
//     } else {
//       return ListView.builder(
//         itemCount: contatos.length,
//         itemBuilder: (context, index) {
//           final contato = contatos[index];
//           return ListTile(
//             leading: CircleAvatar(
//               backgroundColor: contato.categoria.color.withOpacity(0.2),
//               child: Text(
//                 contato.nomeCompleto[0].toUpperCase(),
//                 style: TextStyle(
//                   color: contato.categoria.color,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             title: Text(contato.nomeCompleto),
//             subtitle: Text(contato.email),
//             trailing: IconButton(
//               icon: Icon(
//                 contato.isFavorite ? Icons.favorite : Icons.favorite_border,
//                 color: contato.isFavorite ? Colors.red : null,
//               ),
//               onPressed: () => _toggleFavorite(contato),
//             ),
//           );
//         },
//       );
//     }
//   }
// }

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contatos App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ContactsScreen(),
    );
  }
}

enum ContatoCategoria { trabalho, amigos, familia, outros }

extension ContatoCategoriaExtension on ContatoCategoria {
  String get displayName {
    switch (this) {
      case ContatoCategoria.trabalho: return 'Trabalho';
      case ContatoCategoria.amigos: return 'Amigos';
      case ContatoCategoria.familia: return 'Família';
      case ContatoCategoria.outros: return 'Outros';
    }
  }
  
  IconData get icon {
    switch (this) {
      case ContatoCategoria.trabalho: return Icons.work;
      case ContatoCategoria.amigos: return Icons.group;
      case ContatoCategoria.familia: return Icons.family_restroom;
      case ContatoCategoria.outros: return Icons.person;
    }
  }
  
  Color get color {
    switch (this) {
      case ContatoCategoria.trabalho: return Colors.blue;
      case ContatoCategoria.amigos: return Colors.green;
      case ContatoCategoria.familia: return Colors.orange;
      case ContatoCategoria.outros: return Colors.purple;
    }
  }
}

class Contato {
  final String id;
  final String nomeCompleto;
  final String email;
  final String telefone;
  final String foto;
  final ContatoCategoria categoria;
  bool isFavorite;

  Contato({
    required this.nomeCompleto, 
    required this.email, 
    this.telefone = '',
    this.foto = '',
    this.categoria = ContatoCategoria.outros,
    this.isFavorite = false,
  }) : id = DateTime.now().millisecondsSinceEpoch.toString();
}

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  bool _isGridView = false;
  
  // Lista simplificada de contatos
  final List<Contato> _contatos = [
    Contato(
      nomeCompleto: 'John Doe', 
      email: 'john_doece@gmail.com',
      telefone: '+1 555-123-4567',
      categoria: ContatoCategoria.trabalho,
    ),
    Contato(
      nomeCompleto: 'Alice O. Austin', 
      email: 'AliceOAustin@rhyta.com',
      telefone: '+1 555-234-5678',
      categoria: ContatoCategoria.amigos,
    ),
    Contato(
      nomeCompleto: 'Douglas R. Broadway', 
      email: 'DouglasRBroadway@dayrep.com',
      telefone: '+1 555-345-6789',
      categoria: ContatoCategoria.familia,
    ),
  ];

  int get _favoritesCount => 
      _contatos.where((contato) => contato.isFavorite).length;

  void _toggleFavorite(Contato contato) {
    setState(() {
      contato.isFavorite = !contato.isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text('Contatos'),
            if (_favoritesCount > 0) ...[
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.favorite, color: Colors.white, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      '$_favoritesCount',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(_isGridView ? Icons.list : Icons.grid_view),
            onPressed: () {
              setState(() {
                _isGridView = !_isGridView;
              });
            },
          ),
        ],
      ),
      body: _buildContactsList(_contatos),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Adicionar contato (não implementado)')),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
  
  Widget _buildContactsList(List<Contato> contatos) {
    if (contatos.isEmpty) {
      return const Center(
        child: Text('Nenhum contato encontrado'),
      );
    }
    
    if (_isGridView) {
      return GridView.builder(
        padding: const EdgeInsets.all(8.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: contatos.length,
        itemBuilder: (context, index) {
          final contato = contatos[index];
          return Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    color: contato.categoria.color.withOpacity(0.2),
                    alignment: Alignment.center,
                    child: Text(
                      contato.nomeCompleto[0].toUpperCase(),
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: contato.categoria.color,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        contato.nomeCompleto,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        contato.email,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(
                    contato.isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: contato.isFavorite ? Colors.red : null,
                  ),
                  onPressed: () => _toggleFavorite(contato),
                ),
              ],
            ),
          );
        },
      );
    } else {
      return ListView.builder(
        itemCount: contatos.length,
        itemBuilder: (context, index) {
          final contato = contatos[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: contato.categoria.color.withOpacity(0.2),
              child: Text(
                contato.nomeCompleto[0].toUpperCase(),
                style: TextStyle(
                  color: contato.categoria.color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            title: Text(contato.nomeCompleto),
            subtitle: Text(contato.email),
            trailing: IconButton(
              icon: Icon(
                contato.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: contato.isFavorite ? Colors.red : null,
              ),
              onPressed: () => _toggleFavorite(contato),
            ),
          );
        },
      );
    }
  }
}






// import 'package:flutter/material.dart';

// void main() => runApp(const MyApp());

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Contatos App',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const ContactsScreen(),
//     );
//   }
// }

// enum ContatoCategoria { trabalho, amigos, familia, outros }

// extension ContatoCategoriaExtension on ContatoCategoria {
//   String get displayName {
//     switch (this) {
//       case ContatoCategoria.trabalho: return 'Trabalho';
//       case ContatoCategoria.amigos: return 'Amigos';
//       case ContatoCategoria.familia: return 'Família';
//       case ContatoCategoria.outros: return 'Outros';
//     }
//   }
  
//   IconData get icon {
//     switch (this) {
//       case ContatoCategoria.trabalho: return Icons.work;
//       case ContatoCategoria.amigos: return Icons.group;
//       case ContatoCategoria.familia: return Icons.family_restroom;
//       case ContatoCategoria.outros: return Icons.person;
//     }
//   }
  
//   Color get color {
//     switch (this) {
//       case ContatoCategoria.trabalho: return Colors.blue;
//       case ContatoCategoria.amigos: return Colors.green;
//       case ContatoCategoria.familia: return Colors.orange;
//       case ContatoCategoria.outros: return Colors.purple;
//     }
//   }
// }

// class Contato {
//   final String id;
//   final String nomeCompleto;
//   final String email;
//   final String telefone;
//   final String foto;
//   final ContatoCategoria categoria;
//   bool isFavorite;

//   Contato({
//     required this.nomeCompleto, 
//     required this.email, 
//     this.telefone = '',
//     this.foto = '',
//     this.categoria = ContatoCategoria.outros,
//     this.isFavorite = false,
//   }) : id = DateTime.now().millisecondsSinceEpoch.toString();
// }

// class ContactsScreen extends StatefulWidget {
//   const ContactsScreen({super.key});

//   @override
//   State<ContactsScreen> createState() => _ContactsScreenState();
// }

// class _ContactsScreenState extends State<ContactsScreen> {
//   bool _isGridView = false;
  
//   // Lista simplificada de contatos
//   final List<Contato> _contatos = [
//     Contato(
//       nomeCompleto: 'John Doe', 
//       email: 'john_doece@gmail.com',
//       telefone: '+1 555-123-4567',
//       categoria: ContatoCategoria.trabalho,
//     ),
//     Contato(
//       nomeCompleto: 'Alice O. Austin', 
//       email: 'AliceOAustin@rhyta.com',
//       telefone: '+1 555-234-5678',
//       categoria: ContatoCategoria.amigos,
//     ),
//     Contato(
//       nomeCompleto: 'Douglas R. Broadway', 
//       email: 'DouglasRBroadway@dayrep.com',
//       telefone: '+1 555-345-6789',
//       categoria: ContatoCategoria.familia,
//     ),
//   ];

//   int get _favoritesCount => 
//       _contatos.where((contato) => contato.isFavorite).length;

//   void _toggleFavorite(Contato contato) {
//     setState(() {
//       contato.isFavorite = !contato.isFavorite;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Contatos Favoritos $_favoritesCount'),
//         actions: [
//           IconButton(
//             icon: Icon(_isGridView ? Icons.list : Icons.grid_view),
//             onPressed: () {
//               setState(() {
//                 _isGridView = !_isGridView;
//               });
//             },
//           ),
//         ],
//       ),
//       body: _buildContactsList(_contatos),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Adicionar contato (não implementado)')),
//           );
//         },
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
  
//   Widget _buildContactsList(List<Contato> contatos) {
//     if (contatos.isEmpty) {
//       return const Center(
//         child: Text('Nenhum contato encontrado'),
//       );
//     }
    
//     if (_isGridView) {
//       return GridView.builder(
//         padding: const EdgeInsets.all(8.0),
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           childAspectRatio: 0.75,
//           crossAxisSpacing: 10,
//           mainAxisSpacing: 10,
//         ),
//         itemCount: contatos.length,
//         itemBuilder: (context, index) {
//           final contato = contatos[index];
//           return Card(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Expanded(
//                   flex: 2,
//                   child: Container(
//                     color: contato.categoria.color.withOpacity(0.2),
//                     alignment: Alignment.center,
//                     child: Text(
//                       contato.nomeCompleto[0].toUpperCase(),
//                       style: TextStyle(
//                         fontSize: 40,
//                         fontWeight: FontWeight.bold,
//                         color: contato.categoria.color,
//                       ),
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     children: [
//                       Text(
//                         contato.nomeCompleto,
//                         style: const TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 14,
//                         ),
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                         textAlign: TextAlign.center,
//                       ),
//                       Text(
//                         contato.email,
//                         style: TextStyle(
//                           fontSize: 12,
//                           color: Colors.grey[600],
//                         ),
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                         textAlign: TextAlign.center,
//                       ),
//                     ],
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(
//                     contato.isFavorite ? Icons.favorite : Icons.favorite_border,
//                     color: contato.isFavorite ? Colors.red : null,
//                   ),
//                   onPressed: () => _toggleFavorite(contato),
//                 ),
//               ],
//             ),
//           );
//         },
//       );
//     } else {
//       return ListView.builder(
//         itemCount: contatos.length,
//         itemBuilder: (context, index) {
//           final contato = contatos[index];
//           return ListTile(
//             leading: CircleAvatar(
//               backgroundColor: contato.categoria.color.withOpacity(0.2),
//               child: Text(
//                 contato.nomeCompleto[0].toUpperCase(),
//                 style: TextStyle(
//                   color: contato.categoria.color,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             title: Text(contato.nomeCompleto),
//             subtitle: Text(contato.email),
//             trailing: IconButton(
//               icon: Icon(
//                 contato.isFavorite ? Icons.favorite : Icons.favorite_border,
//                 color: contato.isFavorite ? Colors.red : null,
//               ),
//               onPressed: () => _toggleFavorite(contato),
//             ),
//           );
//         },
//       );
//     }
//   }
// }

