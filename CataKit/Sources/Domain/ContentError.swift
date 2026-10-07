public enum ContentError: Error, Sendable, Hashable {
  case notFound(id: String)
  case decodingFailed(String)
  case invalidReference(String)
}
