import Foundation

public struct Source: Sendable, Hashable {
  public let title: String
  public let url: URL
  public let accessed: String

  public init(title: String, url: URL, accessed: String) {
    self.title = title
    self.url = url
    self.accessed = accessed
  }
}
