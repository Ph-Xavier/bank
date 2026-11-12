// biblioteca padrão do dart usada para converter dados em formato json.
// neste exemplo, usamos jsonDecode para transformar a resposta da api
// em um objeto que o dart consegue manipular.
import 'dart:convert';

// importa o pacote http, responsável por fazer requisições http.
// o apelido "http" facilita a chamada dos métodos, como http.get().
import 'package:http/http.dart' as http;
import '../models/contato.dart';
import '../models/transferencia.dart';

// classe responsável por centralizar a comunicação com a api.
//
// neste primeiro momento, ela terá apenas um método de teste,
// usado para verificar se o flutter consegue se comunicar com a api
// e se a api consegue acessar o banco remoto.
class ApiService {
  // endereço base da api publicada no render.
  //
  // atenção:
  // substitua este endereço pela url real da sua api.
  //
  // exemplo:
  // static const String baseUrl = 'https://bank-api-aula.onrender.com';
  static const String baseUrl = 'https://bank-api-t311.onrender.com';

  // método assíncrono que testa a conexão com o banco remoto.
  //
  // ele acessa a rota:
  // GET /teste-banco
  //
  // essa rota foi criada na api para verificar se o backend
  // consegue se conectar ao postgresql.
  static Future<String> testarConexaoBanco() async {
    // realiza uma requisição http do tipo get para a rota /teste-banco.
    //
    // Uri.parse transforma o texto da url em um objeto Uri,
    // que é o formato exigido pelo pacote http.
    final resposta = await http.get(Uri.parse('$baseUrl/teste-banco'));

    // verifica se o status da resposta é diferente de 200.
    //
    // status 200 significa que a requisição foi concluída com sucesso.
    // se vier qualquer outro código, lançamos uma exceção.
    if (resposta.statusCode != 200) {
      throw Exception('erro ao testar conexão com o banco');
    }

    // converte o corpo da resposta json em um objeto dart.
    //
    // exemplo de resposta esperada da api:
    // {
    //   "mensagem": "conexão com o banco realizada com sucesso",
    //   "dataHoraBanco": "2026-..."
    // }
    final dados = jsonDecode(resposta.body);

    // retorna apenas a mensagem recebida da api.
    //
    // essa mensagem será exibida na tela TesteApi.
    return dados['mensagem'];
  }

  static Future<List<Transferencia>> buscarTransferencias() async {
    final resposta = await http.get(Uri.parse('$baseUrl/transferencias'));

    if (resposta.statusCode != 200) {
      throw Exception('erro ao buscar transferências');
    }

    final dados = jsonDecode(resposta.body) as List<dynamic>;
    return dados
        .map(
          (item) =>
              Transferencia.fromJson(Map<String, dynamic>.from(item as Map)),
        )
        .toList();
  }

  static Future<void> salvarTransferencia(Transferencia transferencia) async {
    final resposta = await http.post(
      Uri.parse('$baseUrl/transferencias'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(transferencia.toJson()),
    );

    if (resposta.statusCode != 201) {
      throw Exception('erro ao salvar transferência');
    }
  }

  static Future<List<Contato>> buscarContatos() async {
    final resposta = await http.get(Uri.parse('$baseUrl/contatos'));

    if (resposta.statusCode != 200) {
      throw Exception('erro ao buscar contatos');
    }

    final dados = jsonDecode(resposta.body) as List<dynamic>;
    return dados
        .map((item) => Contato.fromJson(Map<String, dynamic>.from(item as Map)))
        .toList();
  }

  static Future<void> salvarContato(Contato contato) async {
    final resposta = await http.post(
      Uri.parse('$baseUrl/contatos'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(contato.toJson()),
    );

    if (resposta.statusCode != 201) {
      throw Exception('erro ao salvar contato');
    }
  }
}
