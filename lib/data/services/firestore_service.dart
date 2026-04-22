import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  FirestoreService({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  /// Get a typed reference to a collection
  CollectionReference<Map<String, dynamic>> collection(String path) {
    return _firestore.collection(path);
  }

  /// Get a typed reference to a document
  DocumentReference<Map<String, dynamic>> doc(String path) {
    return _firestore.doc(path);
  }

  /// Create or overwrite document with explicit ID
  Future<void> setDoc({
    required String path,
    required Map<String, dynamic> data,
    bool merge = false,
  }) async {
    await _firestore.doc(path).set(data, SetOptions(merge: merge));
  }

  /// Create document with auto-generated ID; returns the generated ID
  Future<String> addDoc({
    required String collectionPath,
    required Map<String, dynamic> data,
  }) async {
    final ref = await _firestore.collection(collectionPath).add(data);
    return ref.id;
  }

  /// Read a single document; returns null if it doesn't exist
  Future<Map<String, dynamic>?> getDoc(String path) async {
    final snap = await _firestore.doc(path).get();
    if (!snap.exists) return null;
    return {'id': snap.id, ...?snap.data()};
  }

  /// Read a collection (one-shot); each map includes 'id' field
  Future<List<Map<String, dynamic>>> getCollection(
    String path, {
    Query<Map<String, dynamic>> Function(Query<Map<String, dynamic>>)?
        queryBuilder,
  }) async {
    Query<Map<String, dynamic>> query = _firestore.collection(path);
    if (queryBuilder != null) query = queryBuilder(query);
    final snap = await query.get();
    return snap.docs.map((d) => {'id': d.id, ...d.data()}).toList();
  }

  /// Stream a single document; emits null when deleted/missing
  Stream<Map<String, dynamic>?> docStream(String path) {
    return _firestore.doc(path).snapshots().map((snap) {
      if (!snap.exists) return null;
      return {'id': snap.id, ...?snap.data()};
    });
  }

  /// Stream a collection; supports optional query builder
  Stream<List<Map<String, dynamic>>> collectionStream(
    String path, {
    Query<Map<String, dynamic>> Function(Query<Map<String, dynamic>>)?
        queryBuilder,
  }) {
    Query<Map<String, dynamic>> query = _firestore.collection(path);
    if (queryBuilder != null) query = queryBuilder(query);
    return query.snapshots().map((snap) {
      return snap.docs.map((d) => {'id': d.id, ...d.data()}).toList();
    });
  }

  /// Update specific fields (partial update)
  Future<void> updateDoc({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    await _firestore.doc(path).update(data);
  }

  /// Delete a document
  Future<void> deleteDoc(String path) async {
    await _firestore.doc(path).delete();
  }

  /// Run a transaction; caller provides the transaction body
  Future<T> runTransaction<T>(
    Future<T> Function(Transaction tx) handler,
  ) {
    return _firestore.runTransaction<T>(handler);
  }

  /// Create a WriteBatch for multi-document atomic writes
  WriteBatch batch() => _firestore.batch();

  /// Firestore SDK instance (escape hatch for rare advanced queries in repository)
  FirebaseFirestore get raw => _firestore;
}
