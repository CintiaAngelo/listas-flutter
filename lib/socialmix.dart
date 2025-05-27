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
      title: 'Storyboard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6A0DAD),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        fontFamily: 'Poppins',
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6A0DAD),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        fontFamily: 'Poppins',
      ),
      themeMode: ThemeMode.system,
      home: const StoryCreatorHome(),
    );
  }
}

// Modelo de dados para cenas da história
class StoryScene {
  String id;
  String title;
  String content;
  String? imageUrl;
  List<StoryChoice> choices;
  Color backgroundColor;
  double textSize;
  double moodLevel; // 0 = assustador, 0.5 = neutro, 1 = feliz
  
  StoryScene({
    required this.id,
    required this.title,
    required this.content,
    this.imageUrl,
    required this.choices,
    this.backgroundColor = Colors.white,
    this.textSize = 16.0,
    this.moodLevel = 0.5,
  });
}

// Modelo para escolhas dentro de uma cena
class StoryChoice {
  String text;
  String targetSceneId;
  
  StoryChoice({
    required this.text,
    required this.targetSceneId,
  });
}

// Modelo para uma história completa
class Story {
  String id;
  String title;
  String author;
  String description;
  List<StoryScene> scenes;
  String coverImageUrl;
  String startingSceneId;
  
  Story({
    required this.id,
    required this.title,
    required this.author,
    required this.description,
    required this.scenes,
    required this.coverImageUrl,
    required this.startingSceneId,
  });
}

// Tela inicial do app
class StoryCreatorHome extends StatefulWidget {
  const StoryCreatorHome({super.key});

  @override
  State<StoryCreatorHome> createState() => _StoryCreatorHomeState();
}

class _StoryCreatorHomeState extends State<StoryCreatorHome> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  // Lista de histórias de exemplo
  final List<Story> _stories = [
    Story(
      id: '1',
      title: 'A Mansão Misteriosa',
      author: 'João Silva',
      description: 'Explore os segredos de uma mansão abandonada e descubra o que aconteceu com seus antigos moradores.',
      coverImageUrl: 'https://images.unsplash.com/photo-1518780664697-55e3ad937233',
      startingSceneId: 'scene1',
      scenes: [
        StoryScene(
          id: 'scene1',
          title: 'A Chegada',
          content: 'Você está parado em frente a uma mansão antiga. A pintura está descascando e as janelas estão cobertas de poeira. Você ouve um barulho vindo de dentro.',
          imageUrl: 'https://images.unsplash.com/photo-1518780664697-55e3ad937233',
          backgroundColor: Colors.indigo.shade100,
          moodLevel: 0.3,
          choices: [
            StoryChoice(text: 'Entrar pela porta da frente', targetSceneId: 'scene2'),
            StoryChoice(text: 'Dar a volta e procurar uma entrada pelos fundos', targetSceneId: 'scene3'),
            StoryChoice(text: 'Desistir e ir embora', targetSceneId: 'scene4'),
          ],
        ),
        StoryScene(
          id: 'scene2',
          title: 'O Hall de Entrada',
          content: 'A porta range ao abrir. Você se encontra em um grande hall de entrada. Um candelabro enorme, coberto de teias de aranha, pende do teto. Há duas portas: uma à esquerda e outra à direita.',
          imageUrl: 'https://images.unsplash.com/photo-1596436889106-be35e843f974',
          backgroundColor: Colors.brown.shade100,
          moodLevel: 0.2,
          choices: [
            StoryChoice(text: 'Ir para a porta da esquerda', targetSceneId: 'scene5'),
            StoryChoice(text: 'Ir para a porta da direita', targetSceneId: 'scene6'),
          ],
        ),
        StoryScene(
          id: 'scene3',
          title: 'Os Fundos da Mansão',
          content: 'Você contorna a mansão e encontra um jardim abandonado. Há uma porta de serviço entreaberta e uma janela quebrada pela qual você poderia entrar.',
          backgroundColor: Colors.green.shade100,
          moodLevel: 0.4,
          choices: [
            StoryChoice(text: 'Entrar pela porta de serviço', targetSceneId: 'scene7'),
            StoryChoice(text: 'Entrar pela janela quebrada', targetSceneId: 'scene8'),
          ],
        ),
        StoryScene(
          id: 'scene4',
          title: 'A Estrada de Volta',
          content: 'Você decide que não vale a pena arriscar e começa a caminhar de volta. Enquanto se afasta, sente como se estivesse sendo observado...',
          backgroundColor: Colors.blueGrey.shade100,
          moodLevel: 0.6,
          choices: [
            StoryChoice(text: 'Continuar indo embora', targetSceneId: 'scene9'),
            StoryChoice(text: 'Olhar para trás', targetSceneId: 'scene10'),
          ],
        ),
      ],
    ),
    Story(
      id: '2',
      title: 'Viagem Intergaláctica',
      author: 'Maria Oliveira',
      description: 'Como capitão de uma nave espacial, suas decisões determinarão o destino da tripulação.',
      coverImageUrl: 'https://images.unsplash.com/photo-1451187580459-43490279c0fa',
      startingSceneId: 'scene1',
      scenes: [
        StoryScene(
          id: 'scene1',
          title: 'Alerta de Emergência',
          content: 'Sirenes ecoam por toda a nave. O sistema de navegação detectou uma anomalia espacial à frente. Sua tripulação aguarda ordens.',
          imageUrl: 'https://images.unsplash.com/photo-1451187580459-43490279c0fa',
          backgroundColor: Colors.red.shade100,
          moodLevel: 0.3,
          choices: [
            StoryChoice(text: 'Desviar da anomalia', targetSceneId: 'scene2'),
            StoryChoice(text: 'Investigar a anomalia', targetSceneId: 'scene3'),
            StoryChoice(text: 'Preparar-se para o impacto', targetSceneId: 'scene4'),
          ],
        ),
      ],
    ),
    Story(
      id: '3',
      title: 'O Tesouro Perdido',
      author: 'Carlos Mendes',
      description: 'Uma caça ao tesouro que te levará pelos quatro cantos do mundo.',
      coverImageUrl: 'https://images.unsplash.com/photo-1633151188818-83a93b36bad1',
      startingSceneId: 'scene1',
      scenes: [
        StoryScene(
          id: 'scene1',
          title: 'O Mapa',
          content: 'Após anos de pesquisa, você finalmente encontrou o mapa do lendário tesouro do Capitão Barba Negra. O mapa indica três possíveis locais iniciais para sua busca.',
          imageUrl: 'https://images.unsplash.com/photo-1633151188818-83a93b36bad1',
          backgroundColor: Colors.amber.shade100,
          moodLevel: 0.8,
          choices: [
            StoryChoice(text: 'Ir para a ilha deserta no Caribe', targetSceneId: 'scene2'),
            StoryChoice(text: 'Explorar as cavernas na costa da Irlanda', targetSceneId: 'scene3'),
            StoryChoice(text: 'Visitar o antigo porto em Singapura', targetSceneId: 'scene4'),
          ],
        ),
      ],
    ),
  ];
  
  // Histórias criadas pelo usuário
  final List<Story> _myStories = [];
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }
  
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Storyboard',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Explorar'),
            Tab(text: 'Minhas Histórias'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Pesquisar histórias (não implementado)'),
                ),
              );
            },
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildExploreTab(),
          _buildMyStoriesTab(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showCreateStoryDialog();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
  
  // Construir a aba de exploração
  Widget _buildExploreTab() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Banner superior
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.secondary,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Crie sua própria aventura',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Histórias interativas onde você decide o rumo da narrativa',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      _showCreateStoryDialog();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Theme.of(context).colorScheme.primary,
                    ),
                    child: const Text('Comece a criar'),
                  ),
                ],
              ),
            ),
          ),
          
          // Histórias populares
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Histórias Populares',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          
          SizedBox(
            height: 250,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _stories.length,
              itemBuilder: (context, index) {
                final story = _stories[index];
                return _buildStoryCard(story);
              },
            ),
          ),
          
          // Categorias
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Categorias',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildCategoryChip('Aventura', Icons.hiking),
                _buildCategoryChip('Mistério', Icons.search),
                _buildCategoryChip('Ficção Científica', Icons.rocket),
                _buildCategoryChip('Terror', Icons.psychology),
                _buildCategoryChip('Romance', Icons.favorite),
                _buildCategoryChip('Fantasia', Icons.auto_fix_high),
              ],
            ),
          ),
          
          // Histórias recentes
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Histórias Recentes',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _stories.length,
            itemBuilder: (context, index) {
              final story = _stories[index];
              return _buildStoryListItem(story);
            },
          ),
        ],
      ),
    );
  }
  
  // Construir a aba de minhas histórias
  Widget _buildMyStoriesTab() {
    if (_myStories.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.book,
              size: 80,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            const Text(
              'Você ainda não criou nenhuma história',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Toque no botão + para começar a criar',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                _showCreateStoryDialog();
              },
              icon: const Icon(Icons.add),
              label: const Text('Criar nova história'),
            ),
          ],
        ),
      );
    }
    
    return ListView.builder(
      itemCount: _myStories.length,
      itemBuilder: (context, index) {
        final story = _myStories[index];
        return _buildMyStoryItem(story);
      },
    );
  }
  
  // Card para história
  Widget _buildStoryCard(Story story) {
    return Card(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
      child: SizedBox(
        width: 180,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => StoryReaderScreen(story: story),
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Imagem de capa
              Stack(
                children: [
                  Image.network(
                    '${story.coverImageUrl}?w=400&h=250&fit=crop',
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        height: 120,
                        color: Colors.grey[300],
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 120,
                        color: Colors.grey[300],
                        child: const Icon(Icons.broken_image, size: 40),
                      );
                    },
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.route,
                            color: Colors.white,
                            size: 14,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${story.scenes.length}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              
              // Conteúdo
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      story.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'por ${story.author}',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      story.description,
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  // Item de lista para história
  Widget _buildStoryListItem(Story story) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => StoryReaderScreen(story: story),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Imagem de capa
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  '${story.coverImageUrl}?w=200&h=200&fit=crop',
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 80,
                      height: 80,
                      color: Colors.grey[300],
                      child: const Icon(Icons.broken_image),
                    );
                  },
                ),
              ),
              
              const SizedBox(width: 12),
              
              // Conteúdo
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      story.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'por ${story.author}',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      story.description,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              
              // Contagem de cenas
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${story.scenes.length}',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'cenas',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  // Item para minhas histórias
  Widget _buildMyStoryItem(Story story) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          _showStoryOptions(story);
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Imagem de capa
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  '${story.coverImageUrl}?w=200&h=200&fit=crop',
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 80,
                      height: 80,
                      color: Colors.grey[300],
                      child: const Icon(Icons.broken_image),
                    );
                  },
                ),
              ),
              
              const SizedBox(width: 12),
              
              // Conteúdo
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      story.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.edit, size: 12, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text(
                          'Última edição: Ontem',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      story.description,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              
              // Ícone de menu
              IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () {
                  _showStoryOptions(story);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  // Construir chip de categoria
  Widget _buildCategoryChip(String label, IconData icon) {
    return ActionChip(
      avatar: Icon(
        icon,
        size: 16,
        color: Theme.of(context).colorScheme.primary,
      ),
      label: Text(label),
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Categoria: $label'),
          ),
        );
      },
    );
  }
  
  // Mostrar diálogo para criar história
  void _showCreateStoryDialog() {
    showDialog(
      context: context,
      builder: (context) {
        String title = '';
        String description = '';
        
        return AlertDialog(
          title: const Text('Nova História'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Título',
                    hintText: 'Ex: A Mansão Misteriosa',
                  ),
                  onChanged: (value) {
                    title = value;
                  },
                ),
                const SizedBox(height: 16),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Descrição',
                    hintText: 'Breve descrição da sua história',
                  ),
                  maxLines: 3,
                  onChanged: (value) {
                    description = value;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                if (title.isNotEmpty && description.isNotEmpty) {
                  // Criar uma nova história
                  final newStory = Story(
                    id: 'user_${DateTime.now().millisecondsSinceEpoch}',
                    title: title,
                    author: 'Você',
                    description: description,
                    coverImageUrl: 'https://images.unsplash.com/photo-1518020382113-a7e8fc38eac9',
                    startingSceneId: 'scene1',
                    scenes: [
                      StoryScene(
                        id: 'scene1',
                        title: 'Início',
                        content: 'Esta é a primeira cena da sua história. Edite-a para começar!',
                        backgroundColor: Colors.white,
                        choices: [],
                      ),
                    ],
                  );
                  
                  setState(() {
                    _myStories.add(newStory);
                  });
                  
                  Navigator.pop(context);
                  
                  // Abrir o editor
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StoryEditorScreen(story: newStory),
                    ),
                  );
                }
              },
              child: const Text('Criar'),
            ),
          ],
        );
      },
    );
  }
  
  // Mostrar opções para a história
  void _showStoryOptions(Story story) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text('Editar história'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StoryEditorScreen(story: story),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.play_arrow),
                title: const Text('Testar história'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StoryReaderScreen(story: story),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.share),
                title: const Text('Compartilhar'),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Compartilhamento não implementado'),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title: const Text('Excluir história', style: TextStyle(color: Colors.red)),
                onTap: () {
                  Navigator.pop(context);
                  _showDeleteConfirmation(story);
                },
              ),
            ],
          ),
        );
      },
    );
  }
  
  // Mostrar confirmação de exclusão
  void _showDeleteConfirmation(Story story) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Excluir história'),
          content: Text('Tem certeza que deseja excluir "${story.title}"? Esta ação não pode ser desfeita.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _myStories.removeWhere((s) => s.id == story.id);
                });
                
                Navigator.pop(context);
                
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('História excluída'),
                  ),
                );
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.red,
              ),
              child: const Text('Excluir'),
            ),
          ],
        );
      },
    );
  }
}

// Tela de leitura da história
class StoryReaderScreen extends StatefulWidget {
  final Story story;
  
  const StoryReaderScreen({super.key, required this.story});

  @override
  State<StoryReaderScreen> createState() => _StoryReaderScreenState();
}

class _StoryReaderScreenState extends State<StoryReaderScreen> {
  late StoryScene _currentScene;
  List<StoryScene> _visitedScenes = [];
  
  @override
  void initState() {
    super.initState();
    // Começar pela cena inicial
    _currentScene = widget.story.scenes.firstWhere(
      (scene) => scene.id == widget.story.startingSceneId,
      orElse: () => widget.story.scenes.first,
    );
    _visitedScenes.add(_currentScene);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App bar
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                _currentScene.title,
                style: const TextStyle(
                  shadows: [
                    Shadow(
                      color: Colors.black,
                      blurRadius: 4,
                    ),
                  ],
                ),
              ),
              background: _currentScene.imageUrl != null
                  ? Image.network(
                      '${_currentScene.imageUrl}?w=800',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: _currentScene.backgroundColor,
                          child: const Center(
                            child: Icon(Icons.image, size: 48, color: Colors.white54),
                          ),
                        );
                      },
                    )
                  : Container(
                      color: _currentScene.backgroundColor,
                      child: const Center(
                        child: Icon(Icons.auto_stories, size: 48, color: Colors.white54),
                      ),
                    ),
            ),
          ),
          
          // Conteúdo
          SliverToBoxAdapter(
            child: Container(
              color: _currentScene.backgroundColor,
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // Texto da cena
                  Text(
                    _currentScene.content,
                    style: TextStyle(
                      fontSize: _currentScene.textSize,
                      height: 1.5,
                    ),
                  ),
                  
                  const SizedBox(height: 40),
                  
                  // Escolhas
                  if (_currentScene.choices.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: _currentScene.choices.map((choice) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: ElevatedButton(
                            onPressed: () {
                              _navigateToScene(choice.targetSceneId);
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(choice.text),
                          ),
                        );
                      }).toList(),
                    )
                  else
                    Column(
                      children: [
                        const Text(
                          'Fim desta aventura',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton.icon(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.home),
                          label: const Text('Voltar ao início'),
                        ),
                      ],
                    ),
                  
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: _visitedScenes.length > 1
          ? FloatingActionButton(
              mini: true,
              onPressed: () {
                _goBack();
              },
              child: const Icon(Icons.arrow_back),
            )
          : null,
    );
  }
  
  // Navegar para uma cena
  void _navigateToScene(String sceneId) {
    final nextScene = widget.story.scenes.firstWhere(
      (scene) => scene.id == sceneId,
      orElse: () => _currentScene,
    );
    
    setState(() {
      _currentScene = nextScene;
      _visitedScenes.add(nextScene);
    });
  }
  
  // Voltar para a cena anterior
  void _goBack() {
    if (_visitedScenes.length > 1) {
      setState(() {
        _visitedScenes.removeLast();
        _currentScene = _visitedScenes.last;
      });
    }
  }
}

// Tela de edição da história
class StoryEditorScreen extends StatefulWidget {
  final Story story;
  
  const StoryEditorScreen({super.key, required this.story});

  @override
  State<StoryEditorScreen> createState() => _StoryEditorScreenState();
}

class _StoryEditorScreenState extends State<StoryEditorScreen> {
  late Story _editableStory;
  StoryScene? _selectedScene;
  int _red = 255;
  int _green = 255;
  int _blue = 255;
  double _moodSliderValue = 0.5;
  double _textSizeSliderValue = 16.0;
  
  @override
  void initState() {
    super.initState();
    // Copiar a história para edição
    _editableStory = widget.story;
    
    // Selecionar a primeira cena para edição
    if (_editableStory.scenes.isNotEmpty) {
      _selectedScene = _editableStory.scenes.first;
      _updateColorFromScene();
      _moodSliderValue = _selectedScene!.moodLevel;
      _textSizeSliderValue = _selectedScene!.textSize;
    }
  }
  
  void _updateColorFromScene() {
    if (_selectedScene != null) {
      // Extrair componentes RGB da cor de fundo
      _red = _selectedScene!.backgroundColor.red;
      _green = _selectedScene!.backgroundColor.green;
      _blue = _selectedScene!.backgroundColor.blue;
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar: ${_editableStory.title}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.preview),
            tooltip: 'Prévia',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StoryReaderScreen(story: _editableStory),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.save),
            tooltip: 'Salvar',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('História salva com sucesso!'),
                ),
              );
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: _selectedScene == null
          ? const Center(child: Text('Nenhuma cena selecionada'))
          : Row(
              children: [
                // Barra lateral com lista de cenas
                Container(
                  width: 250,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    border: Border(
                      right: BorderSide(
                        color: Theme.of(context).dividerColor,
                      ),
                    ),
                  ),
                  child: Column(
                    children: [
                      // Título
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            const Text(
                              'Cenas',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            const Spacer(),
                            IconButton(
                              icon: const Icon(Icons.add),
                              tooltip: 'Adicionar cena',
                              onPressed: _addNewScene,
                            ),
                          ],
                        ),
                      ),
                      
                      const Divider(height: 1),
                      
                      // Lista de cenas
                      Expanded(
                        child: ListView.builder(
                          itemCount: _editableStory.scenes.length,
                          itemBuilder: (context, index) {
                            final scene = _editableStory.scenes[index];
                            final isSelected = scene.id == _selectedScene?.id;
                            
                            return ListTile(
                              title: Text(
                                scene.title,
                                style: TextStyle(
                                  fontWeight: isSelected ? FontWeight.bold : null,
                                ),
                              ),
                              subtitle: Text(
                                'ID: ${scene.id}',
                                style: const TextStyle(fontSize: 12),
                              ),
                              selected: isSelected,
                              selectedTileColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                              onTap: () {
                                setState(() {
                                  _selectedScene = scene;
                                  _updateColorFromScene();
                                  _moodSliderValue = _selectedScene!.moodLevel;
                                  _textSizeSliderValue = _selectedScene!.textSize;
                                });
                              },
                              trailing: IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  _deleteScene(scene.id);
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Editor de cena
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Título da cena
                        const Text(
                          'Título da cena',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          initialValue: _selectedScene!.title,
                          decoration: const InputDecoration(
                            hintText: 'Ex: A Chegada',
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value) {
                            setState(() {
                              _selectedScene!.title = value;
                            });
                          },
                        ),
                        
                        const SizedBox(height: 20),
                        
                        // Conteúdo da cena
                        const Text(
                          'Conteúdo da cena',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          initialValue: _selectedScene!.content,
                          decoration: const InputDecoration(
                            hintText: 'Descreva o que acontece nesta cena...',
                            border: OutlineInputBorder(),
                          ),
                          maxLines: 5,
                          onChanged: (value) {
                            setState(() {
                              _selectedScene!.content = value;
                            });
                          },
                        ),
                        
                        const SizedBox(height: 20),
                        
                        // URL da imagem
                        const Text(
                          'URL da imagem (opcional)',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          initialValue: _selectedScene!.imageUrl,
                          decoration: const InputDecoration(
                            hintText: 'https://exemplo.com/imagem.jpg',
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value) {
                            setState(() {
                              _selectedScene!.imageUrl = value.isEmpty ? null : value;
                            });
                          },
                        ),
                        
                        const SizedBox(height: 20),
                        
                        // Cor de fundo
                        const Text(
                          'Cor de fundo',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  _buildColorSlider('R', _red.toDouble(), Colors.red, (value) {
                                    setState(() {
                                      _red = value.toInt();
                                      _selectedScene!.backgroundColor = Color.fromRGBO(_red, _green, _blue, 1);
                                    });
                                  }),
                                  _buildColorSlider('G', _green.toDouble(), Colors.green, (value) {
                                    setState(() {
                                      _green = value.toInt();
                                      _selectedScene!.backgroundColor = Color.fromRGBO(_red, _green, _blue, 1);
                                    });
                                  }),
                                  _buildColorSlider('B', _blue.toDouble(), Colors.blue, (value) {
                                    setState(() {
                                      _blue = value.toInt();
                                      _selectedScene!.backgroundColor = Color.fromRGBO(_red, _green, _blue, 1);
                                    });
                                  }),
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(_red, _green, _blue, 1),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ],
                        ),
                        
                        const SizedBox(height: 20),
                        
                        // Ajustes de texto
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Tamanho do texto',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      const Icon(Icons.text_fields, size: 16),
                                      Expanded(
                                        child: Slider(
                                          value: _textSizeSliderValue,
                                          min: 12,
                                          max: 24,
                                          divisions: 12,
                                          label: _textSizeSliderValue.toStringAsFixed(1),
                                          onChanged: (value) {
                                            setState(() {
                                              _textSizeSliderValue = value;
                                              _selectedScene!.textSize = value;
                                            });
                                          },
                                        ),
                                      ),
                                      Text(_textSizeSliderValue.toStringAsFixed(1)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Clima da cena',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      const Icon(Icons.sentiment_very_dissatisfied, size: 16),
                                      Expanded(
                                        child: Slider(
                                          value: _moodSliderValue,
                                          min: 0,
                                          max: 1,
                                          divisions: 10,
                                          label: _getMoodLabel(_moodSliderValue),
                                          onChanged: (value) {
                                            setState(() {
                                              _moodSliderValue = value;
                                              _selectedScene!.moodLevel = value;
                                            });
                                          },
                                        ),
                                      ),
                                      const Icon(Icons.sentiment_very_satisfied, size: 16),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        
                        const SizedBox(height: 30),
                        
                        // Escolhas
                        const Text(
                          'Escolhas',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 8),
                        
                        ..._selectedScene!.choices.asMap().entries.map((entry) {
                          final index = entry.key;
                          final choice = entry.value;
                          
                          return Card(
                            margin: const EdgeInsets.only(bottom: 16),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Escolha ${index + 1}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const Spacer(),
                                      IconButton(
                                        icon: const Icon(Icons.delete),
                                        onPressed: () {
                                          setState(() {
                                            _selectedScene!.choices.removeAt(index);
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  TextFormField(
                                    initialValue: choice.text,
                                    decoration: const InputDecoration(
                                      labelText: 'Texto da escolha',
                                      hintText: 'Ex: Entrar pela porta',
                                      border: OutlineInputBorder(),
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        choice.text = value;
                                      });
                                    },
                                  ),
                                  const SizedBox(height: 8),
                                  DropdownButtonFormField<String>(
                                    value: choice.targetSceneId,
                                    decoration: const InputDecoration(
                                      labelText: 'Cena de destino',
                                      border: OutlineInputBorder(),
                                    ),
                                    items: _editableStory.scenes.map((scene) {
                                      return DropdownMenuItem<String>(
                                        value: scene.id,
                                        child: Text(scene.title),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        choice.targetSceneId = value!;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                        
                        // Botão para adicionar escolha
                        ElevatedButton.icon(
                          onPressed: _addChoice,
                          icon: const Icon(Icons.add),
                          label: const Text('Adicionar escolha'),
                        ),
                        
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
  
  Widget _buildColorSlider(String label, double value, Color color, ValueChanged<double> onChanged) {
    return Row(
      children: [
        SizedBox(
          width: 20,
          child: Text(
            label,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: Slider(
            activeColor: color,
            value: value,
            min: 0,
            max: 255,
            onChanged: onChanged,
          ),
        ),
        SizedBox(
          width: 40,
          child: Text(
            value.toInt().toString(),
            style: TextStyle(
              color: color,
            ),
          ),
        ),
      ],
    );
  }
  
  String _getMoodLabel(double value) {
    if (value < 0.2) return 'Assustador';
    if (value < 0.4) return 'Tenso';
    if (value < 0.6) return 'Neutro';
    if (value < 0.8) return 'Positivo';
    return 'Feliz';
  }
  
  void _addNewScene() {
    final newSceneId = 'scene${_editableStory.scenes.length + 1}';
    
    final newScene = StoryScene(
      id: newSceneId,
      title: 'Nova Cena',
      content: 'Descreva o que acontece nesta cena...',
      backgroundColor: Colors.white,
      choices: [],
    );
    
    setState(() {
      _editableStory.scenes.add(newScene);
      _selectedScene = newScene;
      _updateColorFromScene();
      _moodSliderValue = _selectedScene!.moodLevel;
      _textSizeSliderValue = _selectedScene!.textSize;
    });
  }
  
  void _deleteScene(String sceneId) {
    // Não permitir excluir se for a única cena
    if (_editableStory.scenes.length <= 1) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Não é possível excluir a única cena'),
        ),
      );
      return;
    }
    
    setState(() {
      _editableStory.scenes.removeWhere((scene) => scene.id == sceneId);
      
      // Se a cena excluída for a cena selecionada, selecione outra
      if (_selectedScene?.id == sceneId) {
        _selectedScene = _editableStory.scenes.first;
        _updateColorFromScene();
        _moodSliderValue = _selectedScene!.moodLevel;
        _textSizeSliderValue = _selectedScene!.textSize;
      }
      
      // Atualizar referências nas escolhas
      for (final scene in _editableStory.scenes) {
        for (final choice in scene.choices) {
          if (choice.targetSceneId == sceneId) {
            choice.targetSceneId = _editableStory.scenes.first.id;
          }
        }
      }
    });
  }
  
  void _addChoice() {
    final newChoice = StoryChoice(
      text: 'Nova escolha',
      targetSceneId: _editableStory.scenes.first.id,
    );
    
    setState(() {
      _selectedScene!.choices.add(newChoice);
    });
  }
}
