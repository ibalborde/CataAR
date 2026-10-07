import Domain
import Foundation

struct SourceDTO: Codable {
  let title: String
  let url: String
  let accessed: String
}

extension SourceDTO {
  func toDomain() throws -> Source {
    guard let resolvedURL = URL(string: url) else {
      throw ContentError.decodingFailed("invalid source url: \(url)")
    }
    return Source(title: title, url: resolvedURL, accessed: accessed)
  }
}
