import 'package:flutter/material.dart';
import './contatos/lista_contatos.dart';
import './transferencias/lista.dart';
import '../testes/teste_api.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Dashboard")),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            //alinhamento horizontal
            crossAxisAlignment: CrossAxisAlignment.start,

            children: <Widget>[
              Image.asset("images/bytebank_logo.png"),

              const SizedBox(height: 8.0),

              // o widget Wrap organiza os elementos em linhas e permite quebra automática.
              // diferente do Row, se não houver espaço suficiente na tela,
              // o Wrap joga os próximos elementos para a linha de baixo.
              // isso evita erros de overflow em telas menores.
              Wrap(
                // define o espaçamento horizontal entre os itens.
                spacing: 12,

                // define o espaçamento vertical entre as linhas,
                // caso os itens quebrem para a próxima linha.
                runSpacing: 12,

                // lista de widgets que serão exibidos dentro do Wrap.
                children: [
                  // primeiro card do dashboard: acesso à tela de contatos.
                  _FeatureItem(
                    // texto exibido no card.
                    nome: 'Contatos',

                    // ícone exibido no card.
                    icone: Icons.people,

                    // função executada quando o usuário toca no card.
                    onClick: () {
                      // Navigator.of(context).push abre uma nova tela,
                      // empilhando essa tela sobre a tela atual.
                      Navigator.of(context).push(
                        // MaterialPageRoute define qual tela será aberta.
                        MaterialPageRoute(
                          // builder cria a tela de destino.
                          // neste caso, abre a lista de contatos.
                          builder: (context) => ListaContatos(),
                        ),
                      );
                    },
                  ),

                  // segundo card do dashboard: acesso à tela de transferências.
                  _FeatureItem(
                    // texto exibido no card.
                    nome: 'Transferências',

                    // ícone exibido no card.
                    icone: Icons.monetization_on,

                    // função executada ao tocar no card.
                    onClick: () {
                      // abre a tela de lista de transferências.
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ListaTransferencias(),
                        ),
                      );
                    },
                  ),

                  // terceiro card do dashboard: acesso à tela temporária de testes da api.
                  _FeatureItem(
                    // texto exibido no card.
                    nome: 'Teste API',

                    // ícone de nuvem, representando comunicação com serviço remoto.
                    icone: Icons.cloud,

                    // função executada ao tocar no card.
                    onClick: () {
                      // abre a tela TesteApi, usada para testar a comunicação
                      // entre flutter, api no render e postgresql.
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const TesteApi(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final String nome;
  final IconData icone;
  final void Function() onClick;

  const _FeatureItem({
    required this.nome,
    required this.icone,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.primary,
      borderRadius: BorderRadius.circular(12),

      child: InkWell(
        onTap: onClick,
        borderRadius: BorderRadius.circular(12),

        child: Container(
          height: 120,
          width: 120,
          padding: const EdgeInsets.all(8),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icone, color: Colors.white, size: 32),
              const SizedBox(height: 8),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  nome,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
