import Foundation

enum ContentBundleJSONLoader {
  static func decode<T: Decodable>(_ type: T.Type, from url: URL) throws -> T {
    let data = try Data(contentsOf: url)
    return try JSONDecoder().decode(type, from: data)
  }

  static func jsonFileURLs(in subdirectory: String, bundle: Bundle) -> [URL] {
    guard
      let directoryURL = bundle.url(
        forResource: subdirectory,
        withExtension: nil,
        subdirectory: "Resources"
      )
    else {
      return []
    }
    let contents = try? FileManager.default.contentsOfDirectory(
      at: directoryURL,
      includingPropertiesForKeys: nil
    )
    return (contents ?? [])
      .filter { $0.pathExtension == "json" }
      .sorted { $0.lastPathComponent < $1.lastPathComponent }
  }
}
