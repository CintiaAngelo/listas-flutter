import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Portfolio Simples',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: const Color(0xFF121212),
        useMaterial3: true,
      ),
      home: const PortfolioPage(),
    );
  }
}

class PortfolioPage extends StatelessWidget {
  const PortfolioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meu Portfolio'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Cabeçalho/Perfil
              _buildHeader(),
              
              const Divider(height: 40),
              
              // Seção Sobre
              _buildSectionTitle('Sobre Mim'),
              _buildAboutSection(),
              
              const Divider(height: 40),
              
              // Seção Projetos
              _buildSectionTitle('Meus Projetos'),
              _buildProjectsSection(),
              
              const Divider(height: 40),
              
              // Seção Habilidades
              _buildSectionTitle('Minhas Habilidades'),
              _buildSkillsSection(),
              
              const Divider(height: 40),
              
              // Seção Contato
              _buildSectionTitle('Contato'),
              _buildContactSection(context),
              
              const SizedBox(height: 30),
              const Center(
                child: Text(
                  '© 2023 João Silva',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildHeader() {
    return Center(
      child: Column(
        children: [
          const CircleAvatar(
            radius: 60,
            backgroundColor: Colors.deepPurple,
            child: CircleAvatar(
              radius: 57,
              backgroundImage: NetworkImage(
                'https://randomuser.me/api/portraits/men/32.jpg',
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'João Silva',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            'Desenvolvedor Flutter',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildSocialIcon(Icons.email),
              _buildSocialIcon(Icons.link),
              _buildSocialIcon(Icons.code),
              _buildSocialIcon(Icons.facebook),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildSocialIcon(IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: CircleAvatar(
        radius: 18,
        backgroundColor: Colors.deepPurple.withAlpha(70),
        child: Icon(icon, size: 18, color: Colors.white),
      ),
    );
  }
  
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.deepPurple,
        ),
      ),
    );
  }
  
  Widget _buildAboutSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Desenvolvedor Flutter apaixonado por criar aplicativos móveis bonitos e funcionais. '
          'Especializado em desenvolvimento cross-platform com foco em performance e design intuitivo.',
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 16),
        Text(
          '• Bacharel em Ciência da Computação\n'
          '• 3+ anos de experiência em desenvolvimento mobile\n'
          '• Certificação Flutter Developer',
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }
  
  Widget _buildProjectsSection() {
    final projects = [
      {
        'title': 'EcoTrack',
        'description': 'Aplicativo de monitoramento ambiental',
        'tech': 'Flutter, Firebase',
      },
      {
        'title': 'FinancePro',
        'description': 'Aplicativo de gestão financeira pessoal',
        'tech': 'Flutter, SQLite',
      },
      {
        'title': 'FitJourney',
        'description': 'Aplicativo de fitness e saúde',
        'tech': 'Flutter, Firebase, BLoC',
      },
    ];
    
    return Column(
      children: projects.map((project) => _buildProjectCard(project)).toList(),
    );
  }
  
  Widget _buildProjectCard(Map<String, String> project) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              project['title']!,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              project['description']!,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Tecnologias: ${project['tech']}',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildSkillsSection() {
    final skills = [
      {'name': 'Flutter', 'level': 0.95},
      {'name': 'Dart', 'level': 0.90},
      {'name': 'Firebase', 'level': 0.85},
      {'name': 'UI/UX Design', 'level': 0.80},
      {'name': 'Git', 'level': 0.90},
    ];
    
    return Column(
      children: skills.map((skill) => _buildSkillBar(skill)).toList(),
    );
  }
  
  Widget _buildSkillBar(Map<String, dynamic> skill) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                skill['name'],
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                '${(skill['level'] * 100).toInt()}%',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          LinearProgressIndicator(
            value: skill['level'],
            backgroundColor: Colors.grey[800],
            color: Colors.deepPurple,
            minHeight: 8,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      ),
    );
  }
  
  Widget _buildContactSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Estou sempre aberto a novas oportunidades e colaborações.',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 16),
        
        // Informações de contato
        _buildContactInfo(Icons.email, 'joao.silva@example.com'),
        _buildContactInfo(Icons.phone, '+55 (11) 98765-4321'),
        _buildContactInfo(Icons.location_on, 'São Paulo, Brasil'),
        
        const SizedBox(height: 24),
        
        // Formulário simplificado
        const TextField(
          decoration: InputDecoration(
            labelText: 'Nome',
            border: OutlineInputBorder(),
            filled: true,
            fillColor: Color(0xFF1E1E1E),
          ),
        ),
        const SizedBox(height: 12),
        const TextField(
          decoration: InputDecoration(
            labelText: 'Email',
            border: OutlineInputBorder(),
            filled: true,
            fillColor: Color(0xFF1E1E1E),
          ),
        ),
        const SizedBox(height: 12),
        const TextField(
          maxLines: 3,
          decoration: InputDecoration(
            labelText: 'Mensagem',
            border: OutlineInputBorder(),
            filled: true,
            fillColor: Color(0xFF1E1E1E),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Mensagem enviada com sucesso!')),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Text('Enviar Mensagem'),
          ),
        ),
      ],
    );
  }
  
  Widget _buildContactInfo(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.deepPurple, size: 20),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
