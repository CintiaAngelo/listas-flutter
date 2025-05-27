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
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
          fillColor: Colors.grey.shade100,
        ),
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

class _ContactsScreenState extends State<ContactsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentIndex = 0;
  bool _isGridView = false;
  
  // Lista de contatos
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

  List<Contato> get _favoritos => 
      _contatos.where((contato) => contato.isFavorite).toList();
  
  int get _favoritesCount => _favoritos.length;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {
          _currentIndex = _tabController.index;
        });
      }
    });
  }
  
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _toggleFavorite(Contato contato) {
    setState(() {
      contato.isFavorite = !contato.isFavorite;
    });
  }
  
  void _addContato(Contato contato) {
    setState(() {
      _contatos.add(contato);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contatos Favoritos $_favoritesCount'),
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
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Todos', icon: Icon(Icons.people)),
            Tab(text: 'Favoritos', icon: Icon(Icons.favorite)),
          ],
        ),
      ),
      drawer: _buildBeautifulDrawer(),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Tab de todos os contatos
          _buildContactsList(_contatos),
          // Tab de favoritos
          _buildContactsList(_favoritos),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddContactDialog(),
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            if (index < 2) {
              _tabController.animateTo(index);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Configurações (não implementado)')),
              );
            }
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Contatos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favoritos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Configurações',
          ),
        ],
      ),
    );
  }
  
  Widget _buildBeautifulDrawer() {
    return Drawer(
      child: Column(
        children: [
          // Cabeçalho estilizado com imagem de fundo
          Container(
            height: 200,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('https://picsum.photos/800/400?blur=2'),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                // Overlay para melhorar legibilidade do texto
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.black.withOpacity(0.4),
                ),
                // Conteúdo do cabeçalho
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Foto de perfil com borda
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: 2,
                            ),
                            image: const DecorationImage(
                              image: NetworkImage('https://randomuser.me/api/portraits/men/31.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        // Nome do usuário
                        const Text(
                          'José da Silva Vieira',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                color: Colors.black,
                                blurRadius: 2,
                              ),
                            ],
                          ),
                        ),
                        // Email do usuário
                        const Text(
                          'jsilvavieira@github.com',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            shadows: [
                              Shadow(
                                color: Colors.black,
                                blurRadius: 2,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Menu principal
          Expanded(
            child: Container(
              color: Colors.white,
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  // Seção principal
                  const Padding(
                    padding: EdgeInsets.only(left: 16, top: 16, bottom: 8),
                    child: Text(
                      'PRINCIPAL',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  _buildDrawerItem(
                    icon: Icons.person,
                    title: 'Perfil',
                    onTap: () => Navigator.pop(context),
                  ),
                  _buildDrawerItem(
                    icon: Icons.book,
                    title: 'Repositórios',
                    onTap: () => Navigator.pop(context),
                    badge: '12',
                  ),
                  _buildDrawerItem(
                    icon: Icons.star,
                    title: 'Favoritos',
                    onTap: () {
                      Navigator.pop(context);
                      _tabController.animateTo(1);
                    },
                    badge: _favoritesCount.toString(),
                  ),
                  
                  const Divider(),
                  
                  // Seção de categorias
                  const Padding(
                    padding: EdgeInsets.only(left: 16, top: 8, bottom: 8),
                    child: Text(
                      'CATEGORIAS',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  
                  // Itens de categoria
                  ...ContatoCategoria.values.map((categoria) => 
                    _buildDrawerItem(
                      icon: categoria.icon,
                      iconColor: categoria.color,
                      title: categoria.displayName,
                      onTap: () => Navigator.pop(context),
                    ),
                  ),
                  
                  const Divider(),
                  
                  // Seção de configurações
                  const Padding(
                    padding: EdgeInsets.only(left: 16, top: 8, bottom: 8),
                    child: Text(
                      'CONFIGURAÇÕES',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  _buildDrawerItem(
                    icon: Icons.settings,
                    title: 'Configurações',
                    onTap: () => Navigator.pop(context),
                  ),
                  _buildDrawerItem(
                    icon: Icons.help,
                    title: 'Ajuda',
                    onTap: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
          ),
          
          // Rodapé com versão
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            color: Colors.grey.shade100,
            width: double.infinity,
            child: const Center(
              child: Text(
                'Versão 1.0.0',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? iconColor,
    String? badge,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: iconColor,
      ),
      title: Text(title),
      trailing: badge != null
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                badge,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            )
          : null,
      onTap: onTap,
    );
  }
  
  Widget _buildContactsList(List<Contato> contatos) {
    if (contatos.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.person_off, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            const Text(
              'Nenhum contato encontrado',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () => _showAddContactDialog(),
              icon: const Icon(Icons.add),
              label: const Text('Adicionar contato'),
            ),
          ],
        ),
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
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Cabeçalho com avatar e categoria
                Stack(
                  children: [
                    Container(
                      height: 120,
                      decoration: BoxDecoration(
                        color: contato.categoria.color.withOpacity(0.2),
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(12),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        contato.nomeCompleto[0].toUpperCase(),
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: contato.categoria.color,
                        ),
                      ),
                    ),
                    // Badge de categoria
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: contato.categoria.color,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          contato.categoria.icon,
                          size: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Text(
                        contato.nomeCompleto,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 4),
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
                      if (contato.telefone.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Text(
                          contato.telefone,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ],
                  ),
                ),
                const Spacer(),
                // Botão de favorito
                Material(
                  color: Colors.grey.shade100,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(12),
                    ),
                  ),
                  child: InkWell(
                    onTap: () => _toggleFavorite(contato),
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(12),
                    ),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            contato.isFavorite ? Icons.favorite : Icons.favorite_border,
                            size: 20,
                            color: contato.isFavorite ? Colors.red : Colors.grey,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            contato.isFavorite ? 'Favoritado' : 'Favoritar',
                            style: TextStyle(
                              color: contato.isFavorite ? Colors.red : Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
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
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: contato.categoria.color.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Stack(
                    children: [
                      Text(
                        contato.nomeCompleto[0].toUpperCase(),
                        style: TextStyle(
                          color: contato.categoria.color,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: contato.categoria.color,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 1),
                          ),
                          child: Icon(
                            contato.categoria.icon,
                            size: 8,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              title: Text(
                contato.nomeCompleto,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(contato.email),
                  if (contato.telefone.isNotEmpty)
                    Text(contato.telefone),
                ],
              ),
              isThreeLine: contato.telefone.isNotEmpty,
              trailing: IconButton(
                icon: Icon(
                  contato.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: contato.isFavorite ? Colors.red : null,
                ),
                onPressed: () => _toggleFavorite(contato),
              ),
            ),
          );
        },
      );
    }
  }
  
  void _showAddContactDialog() {
    // Controladores para os campos do formulário
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final phoneController = TextEditingController();
    ContatoCategoria selectedCategoria = ContatoCategoria.outros;
    
    // Chave para validação do formulário
    final formKey = GlobalKey<FormState>();
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 16,
                right: 16,
                top: 16,
              ),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Título
                    Center(
                      child: Column(
                        children: [
                          Container(
                            width: 40,
                            height: 5,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Novo Contato',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    
                    // Nome
                    TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: 'Nome Completo',
                        prefixIcon: Icon(Icons.person),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira o nome';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    
                    // Email
                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira o email';
                        }
                        if (!value.contains('@')) {
                          return 'Por favor, insira um email válido';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    
                    // Telefone
                    TextFormField(
                      controller: phoneController,
                      decoration: const InputDecoration(
                        labelText: 'Telefone (opcional)',
                        prefixIcon: Icon(Icons.phone),
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 12),
                    
                    // Categoria
                    DropdownButtonFormField<ContatoCategoria>(
                      value: selectedCategoria,
                      decoration: const InputDecoration(
                        labelText: 'Categoria',
                        prefixIcon: Icon(Icons.category),
                      ),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            selectedCategoria = value;
                          });
                        }
                      },
                      items: ContatoCategoria.values.map((categoria) {
                        return DropdownMenuItem<ContatoCategoria>(
                          value: categoria,
                          child: Row(
                            children: [
                              Icon(categoria.icon, color: categoria.color, size: 20),
                              const SizedBox(width: 8),
                              Text(categoria.displayName),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 24),
                    
                    // Botões
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancelar'),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              // Criar novo contato
                              final newContato = Contato(
                                nomeCompleto: nameController.text,
                                email: emailController.text,
                                telefone: phoneController.text,
                                categoria: selectedCategoria,
                              );
                              
                              // Adicionar à lista
                              _addContato(newContato);
                              
                              // Fechar o modal
                              Navigator.pop(context);
                              
                              // Mostrar mensagem de sucesso
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('${newContato.nomeCompleto} adicionado com sucesso!'),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple,
                            foregroundColor: Colors.white,
                          ),
                          child: const Text('Salvar'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
