class Transferencia {
  final int? id;
  final double valor;
  final int numeroConta;

  Transferencia(this.valor, this.numeroConta, {this.id});

  factory Transferencia.fromJson(Map<String, dynamic> json) {
    final valor = json['valor'];
    final numeroConta = json['numero_conta'] ?? json['numeroConta'];

    return Transferencia(
      double.parse(valor.toString()),
      int.parse(numeroConta.toString()),
      id: json['id'] == null ? null : int.parse(json['id'].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {'valor': valor, 'numeroConta': numeroConta};
  }

  @override
  String toString() {
    return 'Transferencia{valor: $valor, numeroConta: $numeroConta}';
  }
}
