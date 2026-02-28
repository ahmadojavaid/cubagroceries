
extension Let<T> on T? {
  R? let<R>(R? Function(T it) block) => this == null ? null : block(this as T);
}
