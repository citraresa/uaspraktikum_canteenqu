class TransactionNazwa {
  final String  trxid;
  final num total_final;
  final String status;
  final List<Map<String, dynamic>> items;
  final DateTime timestamp;

  TransactionNazwa({
    required this.trxid,
    required this.total_final,
    required this.status,
    required this.items,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': trxid,
      'total': total_final,
      'status': status,
      'items': items,
      'timestamp': timestamp,
    };
  }
}
