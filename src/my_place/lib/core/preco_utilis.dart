class PrecoUtilis {
  static double getNumeroStringPreco(String preco) => double.parse(preco
      .replaceAll('R\$', '')
      .replaceAll(',', '')
      .replaceAll('.', '')
      .trim());
}
