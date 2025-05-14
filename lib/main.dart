import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const title = 'Contacts';

    return MaterialApp(
      title: title,
      home: Scaffold(
          appBar: AppBar(
            title: const Text(title),
          ),
          body: ListView.builder(
            itemCount: contatos.length,
            itemBuilder: (context, index) {
              final contato = contatos[index];
              return ListTile(
                leading: const CircleAvatar(backgroundColor: Colors.black),
                title: Text(contato.nomeCompleto),
                subtitle: Text(contato.nomeCompleto),
              );
            },
          )),
    );
  }
}

List<String> linguagens = ['Java', 'C#', 'Python', 'JavaScript', 'Dart', 'Go'];

class Contato {
  String nomeCompleto;
  String email;

  Contato(this.nomeCompleto, this.email);
}

List<Contato> contatos = [
  Contato('Cintia Angelo', 'cintia@gmail.com'),
  Contato('Thiago Angelo', 'thiago@gmail.com'),
  Contato('Paulo Angelo', 'paulo@gmail.com'),
  Contato('Kely Angelo', 'kely@gmail.com'),
  Contato('Victor Nimeth', 'Victor@gmail.com')
];
