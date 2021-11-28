class FirestorePath {
  static String todo(String uid, String noteId) => 'users/$uid/todos/$noteId';
  static String todos(String uid) => 'users/$uid/todos';
}
