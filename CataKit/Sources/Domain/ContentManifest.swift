public struct ContentManifest: Sendable, Hashable {
  public let schemaVersion: Int
  public let contentVersion: String
  public let defaultLocale: String

  public init(schemaVersion: Int, contentVersion: String, defaultLocale: String) {
    self.schemaVersion = schemaVersion
    self.contentVersion = contentVersion
    self.defaultLocale = defaultLocale
  }
}
