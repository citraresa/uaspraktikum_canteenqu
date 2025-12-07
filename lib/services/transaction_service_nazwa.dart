import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:canteenqu/models/transaksiKt.dart';

class TransactionService {
  final CollectionReference trxRef =
      FirebaseFirestore.instance.collection('transactions');

  Future<void> simpanTransaksi(TransactionNazwa trx) async {
    await trxRef.doc(trx.trxid).set(trx.toMap());
  }
}
