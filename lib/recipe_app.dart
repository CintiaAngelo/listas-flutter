import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const RecipeApp());
}

// Cores e tema do aplicativo
class AppColors {
  static const primary = Color(0xFF5C8D89);
  static const secondary = Color(0xFFF28123);
  static const background = Color(0xFFF9F9F9);
  static const cardLight = Color(0xFFFFFFFF);
  static const textDark = Color(0xFF333333);
  static const textLight = Color(0xFF757575);
}

// Modelo de dados para Receita
class Recipe {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final List<String> ingredients;
  final List<String> steps;
  final int preparationTime;
  final int servings;
  final String difficulty;
  final String category;
  bool isFavorite;

  Recipe({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.ingredients,
    required this.steps,
    required this.preparationTime,
    required this.servings,
    required this.difficulty,
    required this.category,
    this.isFavorite = false,
  });
}

// Aplicativo principal
class RecipeApp extends StatelessWidget {
  const RecipeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RecipeHub',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          primary: AppColors.primary,
          secondary: AppColors.secondary,
          background: AppColors.background,
        ),
        useMaterial3: true,
        fontFamily: 'Poppins',
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
        ),
        cardTheme: CardTheme(
          color: AppColors.cardLight,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      home: const HomePage(),
    );
  }
}

// Página principal
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  int _carouselIndex = 0;
  final PageController _pageController = PageController();
  
  // Lista de receitas
  final List<Recipe> _recipes = [
    Recipe(
      id: '1',
      title: 'Spaghetti à Bolonhesa',
      description: 'Um clássico italiano que combina massa al dente com um molho de carne rico e saboroso.',
      imageUrl: 'https://images.unsplash.com/photo-1622973536968-3ead9e780960',
      ingredients: [
        '400g de spaghetti',
        '500g de carne moída',
        '1 cebola picada',
        '2 dentes de alho picados',
        '400g de tomate pelado',
        '2 colheres de sopa de extrato de tomate',
        'Sal e pimenta a gosto',
        'Queijo parmesão ralado'
      ],
      steps: [
        'Cozinhe o spaghetti em água fervente com sal até ficar al dente.',
        'Em uma panela, refogue a cebola e o alho em azeite até dourar.',
        'Adicione a carne moída e cozinhe até perder a cor rosada.',
        'Adicione os tomates pelados e o extrato de tomate.',
        'Tempere com sal e pimenta, e deixe cozinhar em fogo baixo por 20 minutos.',
        'Sirva o molho sobre o spaghetti e polvilhe com queijo parmesão.'
      ],
      preparationTime: 35,
      servings: 4,
      difficulty: 'Fácil',
      category: 'Massas',
    ),
    Recipe(
      id: '2',
      title: 'Salada Caesar',
      description: 'Uma salada refrescante com alface romana, croutons, queijo parmesão e molho caesar.',
      imageUrl: 'https://images.unsplash.com/photo-1550304943-4f24f54ddde9',
      ingredients: [
        '1 alface romana',
        '100g de queijo parmesão ralado',
        '100g de croutons',
        '2 filés de peito de frango',
        'Para o molho: 2 gemas, 2 filés de anchova, 1 dente de alho, suco de limão, azeite'
      ],
      steps: [
        'Lave e seque a alface romana, rasgue as folhas em pedaços grandes.',
        'Grelhe os filés de frango temperados com sal e pimenta, depois fatie.',
        'Para o molho, misture as gemas, anchovas amassadas, alho picado, suco de limão e azeite.',
        'Misture a alface com o molho, adicione o frango, croutons e finalize com queijo parmesão.'
      ],
      preparationTime: 25,
      servings: 2,
      difficulty: 'Média',
      category: 'Saladas',
    ),
    Recipe(
      id: '3',
      title: 'Bolo de Chocolate',
      description: 'Um bolo de chocolate fofinho e úmido, perfeito para qualquer ocasião.',
      imageUrl: 'https://images.unsplash.com/photo-1606313564200-e75d5e30476c',
      ingredients: [
        '2 xícaras de farinha de trigo',
        '1 xícara de açúcar',
        '1/2 xícara de chocolate em pó',
        '1 colher de chá de fermento em pó',
        '1/2 colher de chá de bicarbonato de sódio',
        '2 ovos',
        '1 xícara de leite',
        '1/2 xícara de óleo vegetal',
        '1 colher de chá de essência de baunilha'
      ],
      steps: [
        'Pré-aqueça o forno a 180°C e unte uma forma redonda.',
        'Em uma tigela, misture os ingredientes secos: farinha, açúcar, chocolate em pó, fermento e bicarbonato.',
        'Em outra tigela, bata os ovos, o leite, o óleo e a baunilha.',
        'Incorpore os ingredientes líquidos aos secos, misturando bem.',
        'Despeje a massa na forma e asse por 30-35 minutos.',
        'Deixe esfriar antes de desenformar e decorar com cobertura de chocolate, se desejar.'
      ],
      preparationTime: 45,
      servings: 8,
      difficulty: 'Fácil',
      category: 'Sobremesas',
    ),
    Recipe(
      id: '4',
      title: 'Strogonoff de Frango',
      description: 'Um prato clássico brasileiro com frango, creme de leite e champignons.',
      imageUrl: 'https://images.unsplash.com/photo-1604908176997-125f25cc6f3d',
      ingredients: [
        '500g de peito de frango cortado em cubos',
        '1 cebola picada',
        '2 dentes de alho picados',
        '200g de champignons fatiados',
        '1 caixa de creme de leite',
        '3 colheres de sopa de extrato de tomate',
        '2 colheres de sopa de ketchup',
        '1 colher de sopa de mostarda',
        'Sal e pimenta a gosto',
        'Batata palha para servir'
      ],
      steps: [
        'Em uma panela, refogue a cebola e o alho em azeite até dourar.',
        'Adicione o frango e cozinhe até dourar.',
        'Adicione os champignons, o extrato de tomate, o ketchup e a mostarda.',
        'Tempere com sal e pimenta, e deixe cozinhar por alguns minutos.',
        'Desligue o fogo e adicione o creme de leite, misturando bem.',
        'Sirva com arroz branco e batata palha.'
      ],
      preparationTime: 30,
      servings: 4,
      difficulty: 'Média',
      category: 'Carnes',
    ),
    Recipe(
      id: '5',
      title: 'Smoothie de Frutas Vermelhas',
      description: 'Um smoothie refrescante e nutritivo, perfeito para o café da manhã ou lanche.',
      imageUrl: 'https://images.unsplash.com/photo-1553530666-ba11a90a0803',
      ingredients: [
        '1 xícara de frutas vermelhas (morango, framboesa, mirtilo)',
        '1 banana congelada',
        '1 xícara de leite vegetal',
        '1 colher de sopa de mel',
        '1 colher de sopa de sementes de chia'
      ],
      steps: [
        'Adicione todas as frutas no liquidificador.',
        'Adicione o leite vegetal e o mel.',
        'Bata até obter uma mistura homogênea.',
        'Polvilhe com sementes de chia antes de servir.'
      ],
      preparationTime: 5,
      servings: 1,
      difficulty: 'Fácil',
      category: 'Bebidas',
    ),
  ];

  // Categorias de receitas
  final List<Map<String, dynamic>> _categories = [
    {'name': 'Massas', 'icon': Icons.restaurant},
    {'name': 'Saladas', 'icon': Icons.eco},
    {'name': 'Sobremesas', 'icon': Icons.cake},
    {'name': 'Carnes', 'icon': Icons.set_meal},
    {'name': 'Bebidas', 'icon': Icons.local_drink},
    {'name': 'Vegetariano', 'icon': Icons.spa},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(
          'RecipeHub',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              _showSearchDialog();
            },
          ),
        ],
      ),
      drawer: _buildDrawer(),
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: AppColors.primary,
              image: DecorationImage(
                image: NetworkImage('https://images.unsplash.com/photo-1542010589005-d1eacc3918f2'),
                fit: BoxFit.cover,
                opacity: 0.7,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                Text(
                  'RecipeHub',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Suas receitas favoritas',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Início'),
            onTap: () {
              Navigator.pop(context);
              setState(() {
                _currentIndex = 0;
                _pageController.jumpToPage(0);
              });
            },
          ),
          ListTile(
            leading: const Icon(Icons.category),
            title: const Text('Categorias'),
            onTap: () {
              Navigator.pop(context);
              setState(() {
                _currentIndex = 1;
                _pageController.jumpToPage(1);
              });
            },
          ),
          ListTile(
            leading: const Icon(Icons.favorite),
            title: const Text('Favoritos'),
            onTap: () {
              Navigator.pop(context);
              setState(() {
                _currentIndex = 2;
                _pageController.jumpToPage(2);
              });
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Configurações'),
            onTap: () {
              Navigator.pop(context);
              // Navegação para configurações (não implementada)
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('Sobre'),
            onTap: () {
              Navigator.pop(context);
              _showAboutDialog();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return PageView(
      controller: _pageController,
      onPageChanged: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
      children: [
        _buildHomePage(),
        _buildCategoriesPage(),
        _buildFavoritesPage(),
      ],
    );
  }

  Widget _buildHomePage() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Carrossel de receitas em destaque
          _buildFeaturedCarousel(),
          
          // Título para receitas recentes
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Receitas Recentes',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Ver todas as receitas
                  },
                  child: const Text('Ver todas'),
                ),
              ],
            ),
          ),
          
          // Lista de receitas recentes
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _recipes.length,
            itemBuilder: (context, index) {
              final recipe = _recipes[index];
              return _buildRecipeListItem(recipe);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedCarousel() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
          child: Text(
            'Receitas em Destaque',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
        ),
        SizedBox(
          height: 250,
          child: PageView.builder(
            itemCount: _recipes.length,
            onPageChanged: (index) {
              setState(() {
                _carouselIndex = index;
              });
            },
            itemBuilder: (context, index) {
              final recipe = _recipes[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RecipeDetailPage(recipe: recipe),
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Imagem da receita
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          '${recipe.imageUrl}?w=600&fit=crop&crop=entropy',
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey[300],
                              child: const Center(
                                child: Icon(Icons.broken_image, size: 48),
                              ),
                            );
                          },
                        ),
                      ),
                      // Sobreposição escura para melhorar legibilidade
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.7),
                            ],
                          ),
                        ),
                      ),
                      // Informações da receita
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                recipe.title,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  _buildInfoChip(Icons.timer, '${recipe.preparationTime} min'),
                                  const SizedBox(width: 8),
                                  _buildInfoChip(Icons.people, '${recipe.servings} porções'),
                                  const SizedBox(width: 8),
                                  _buildInfoChip(Icons.category, recipe.category),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Botão de favorito
                      Positioned(
                        top: 12,
                        right: 12,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              recipe.isFavorite = !recipe.isFavorite;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Icon(
                              recipe.isFavorite ? Icons.favorite : Icons.favorite_border,
                              color: recipe.isFavorite ? Colors.red : Colors.grey,
                              size: 22,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        // Indicadores do carrossel
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _recipes.length,
              (index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _carouselIndex == index
                      ? AppColors.primary
                      : Colors.grey.shade300,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoChip(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 16),
          const SizedBox(width: 4),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecipeListItem(Recipe recipe) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RecipeDetailPage(recipe: recipe),
            ),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              // Imagem da receita
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  '${recipe.imageUrl}?w=200&h=200&fit=crop',
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
              const SizedBox(width: 16),
              // Informações da receita
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      recipe.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      recipe.description,
                      style: const TextStyle(
                        color: AppColors.textLight,
                        fontSize: 12,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.timer, size: 14, color: Colors.grey[600]),
                        const SizedBox(width: 4),
                        Text(
                          '${recipe.preparationTime} min',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Icon(Icons.star, size: 14, color: Colors.amber[600]),
                        const SizedBox(width: 4),
                        Text(
                          recipe.difficulty,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Botão de favorito
              IconButton(
                icon: Icon(
                  recipe.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: recipe.isFavorite ? Colors.red : Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    recipe.isFavorite = !recipe.isFavorite;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoriesPage() {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.2,
      ),
      itemCount: _categories.length,
      itemBuilder: (context, index) {
        final category = _categories[index];
        return Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: InkWell(
            onTap: () {
              // Navegação para lista de receitas da categoria
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CategoryRecipesPage(
                    categoryName: category['name'],
                    recipes: _recipes.where((r) => r.category == category['name']).toList(),
                  ),
                ),
              );
            },
            borderRadius: BorderRadius.circular(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: AppColors.primary.withOpacity(0.2),
                  child: Icon(
                    category['icon'],
                    color: AppColors.primary,
                    size: 30,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  category['name'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFavoritesPage() {
    final favoriteRecipes = _recipes.where((recipe) => recipe.isFavorite).toList();

    if (favoriteRecipes.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite_border,
              size: 80,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'Nenhuma receita favorita ainda',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Adicione receitas aos favoritos para encontrá-las aqui',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  _currentIndex = 0;
                  _pageController.jumpToPage(0);
                });
              },
              icon: const Icon(Icons.home),
              label: const Text('Ir para receitas'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: favoriteRecipes.length,
      itemBuilder: (context, index) {
        return _buildRecipeListItem(favoriteRecipes[index]);
      },
    );
  }

  Widget _buildBottomNavBar() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        });
      },
      selectedItemColor: AppColors.primary,
      unselectedItemColor: Colors.grey,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Início',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.category),
          label: 'Categorias',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'Favoritos',
        ),
      ],
    );
  }

  void _showSearchDialog() {
    showSearch(
      context: context,
      delegate: RecipeSearchDelegate(_recipes),
    );
  }

  void _showAboutDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Sobre o RecipeHub'),
          content: const Text(
            'RecipeHub é um aplicativo para amantes da culinária, onde você pode encontrar e salvar suas receitas favoritas.\n\n'
            'Versão 1.0.0\n'
            'Desenvolvido com Flutter',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Fechar'),
            ),
          ],
        );
      },
    );
  }
}

// Página de detalhes da receita
class RecipeDetailPage extends StatefulWidget {
  final Recipe recipe;

  const RecipeDetailPage({super.key, required this.recipe});

  @override
  State<RecipeDetailPage> createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState extends State<RecipeDetailPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

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
      body: CustomScrollView(
        slivers: [
          // App bar com imagem de fundo
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                widget.recipe.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      color: Colors.black,
                      blurRadius: 4,
                    ),
                  ],
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    '${widget.recipe.imageUrl}?w=800&fit=crop&crop=entropy',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[300],
                        child: const Center(
                          child: Icon(Icons.broken_image, size: 48),
                        ),
                      );
                    },
                  ),
                  // Sobreposição gradiente para melhorar legibilidade
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  widget.recipe.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: widget.recipe.isFavorite ? Colors.red : Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    widget.recipe.isFavorite = !widget.recipe.isFavorite;
                  });
                },
              ),
              IconButton(
                icon: const Icon(Icons.share),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Compartilhar receita (não implementado)'),
                    ),
                  );
                },
              ),
            ],
          ),
          
          // Informações da receita
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Cartão de informações rápidas
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildInfoColumn(Icons.timer, '${widget.recipe.preparationTime} min', 'Tempo'),
                          _buildInfoColumn(Icons.people, '${widget.recipe.servings}', 'Porções'),
                          _buildInfoColumn(Icons.layers, widget.recipe.difficulty, 'Dificuldade'),
                          _buildInfoColumn(Icons.category, widget.recipe.category, 'Categoria'),
                        ],
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Descrição da receita
                  Text(
                    widget.recipe.description,
                    style: const TextStyle(
                      fontSize: 16,
                      color: AppColors.textLight,
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Abas para ingredientes e modo de preparo
                  TabBar(
                    controller: _tabController,
                    labelColor: AppColors.primary,
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: AppColors.primary,
                    tabs: const [
                      Tab(text: 'Ingredientes'),
                      Tab(text: 'Modo de Preparo'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          
          // Conteúdo das abas
          SliverFillRemaining(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Aba de ingredientes
                _buildIngredientsTab(),
                
                // Aba de modo de preparo
                _buildStepsTab(),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _startCooking();
        },
        backgroundColor: AppColors.secondary,
        icon: const Icon(Icons.play_arrow),
        label: const Text('Começar a cozinhar'),
      ),
    );
  }

  Widget _buildInfoColumn(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, color: AppColors.primary),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildIngredientsTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: widget.recipe.ingredients.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    widget.recipe.ingredients[index],
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildStepsTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: widget.recipe.steps.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 24.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '${index + 1}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    widget.recipe.steps[index],
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _startCooking() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Modo de Preparo Passo a Passo',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Este recurso irá guiá-lo através de cada passo da receita, com temporizadores e lembretes.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Modo de preparo passo a passo (não implementado)'),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondary,
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text(
                  'Iniciar',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancelar'),
              ),
            ],
          ),
        );
      },
    );
  }
}

// Página de receitas por categoria
class CategoryRecipesPage extends StatelessWidget {
  final String categoryName;
  final List<Recipe> recipes;

  const CategoryRecipesPage({
    super.key,
    required this.categoryName,
    required this.recipes,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName),
      ),
      body: recipes.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.no_food,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Nenhuma receita encontrada',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: recipes.length,
              itemBuilder: (context, index) {
                final recipe = recipes[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RecipeDetailPage(recipe: recipe),
                        ),
                      );
                    },
                    borderRadius: BorderRadius.circular(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Imagem da receita
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                          child: Image.network(
                            '${recipe.imageUrl}?w=600&fit=crop',
                            height: 180,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                height: 180,
                                color: Colors.grey[300],
                                child: const Center(
                                  child: Icon(Icons.broken_image, size: 48),
                                ),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      recipe.title,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      recipe.isFavorite ? Icons.favorite : Icons.favorite_border,
                                      color: recipe.isFavorite ? Colors.red : Colors.grey,
                                    ),
                                    onPressed: () {
                                      // Atualizar favorito
                                      // (não implementado - precisa StatefulWidget)
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                recipe.description,
                                style: const TextStyle(
                                  color: AppColors.textLight,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.timer,
                                    size: 16,
                                    color: AppColors.textLight,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${recipe.preparationTime} min',
                                    style: const TextStyle(
                                      color: AppColors.textLight,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  const Icon(
                                    Icons.people,
                                    size: 16,
                                    color: AppColors.textLight,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${recipe.servings} porções',
                                    style: const TextStyle(
                                      color: AppColors.textLight,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

// Delegado de pesquisa
class RecipeSearchDelegate extends SearchDelegate<String> {
  final List<Recipe> recipes;

  RecipeSearchDelegate(this.recipes);

  @override
  String get searchFieldLabel => 'Buscar receitas...';

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSearchResults();
  }

  Widget _buildSearchResults() {
    if (query.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search,
              size: 80,
              color: Colors.grey[300],
            ),
            const SizedBox(height: 16),
            Text(
              'Busque por receitas, ingredientes ou categorias',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    final filteredRecipes = recipes.where((recipe) {
      return recipe.title.toLowerCase().contains(query.toLowerCase()) ||
             recipe.category.toLowerCase().contains(query.toLowerCase()) ||
             recipe.ingredients.any((ingredient) => 
               ingredient.toLowerCase().contains(query.toLowerCase())
             );
    }).toList();

    if (filteredRecipes.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.no_food,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'Nenhuma receita encontrada para "$query"',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: filteredRecipes.length,
      itemBuilder: (context, index) {
        final recipe = filteredRecipes[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                '${recipe.imageUrl}?w=100&h=100&fit=crop',
                width: 60,
                height: 60,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 60,
                    height: 60,
                    color: Colors.grey[300],
                    child: const Icon(Icons.broken_image),
                  );
                },
              ),
            ),
            title: Text(
              recipe.title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              recipe.category,
              style: const TextStyle(color: AppColors.textLight),
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              close(context, recipe.id);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RecipeDetailPage(recipe: recipe),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
