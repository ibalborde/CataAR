import Domain

struct ManifestDTO: Codable {
  let schemaVersion: Int
  let contentVersion: String
  let defaultLocale: String
}

extension ManifestDTO {
  func toDomain() -> ContentManifest {
    ContentManifest(
      schemaVersion: schemaVersion,
      contentVersion: contentVersion,
      defaultLocale: defaultLocale
    )
  }
}
