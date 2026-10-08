import Foundation

/// Materializes a throwaway directory laid out like ContentBundle's `Content/`
/// folder, so repository tests can point at it via `Bundle(url:)`.
enum FixtureBundle {
  static func make(resources: [String: String]) throws -> Bundle {
    let root = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString)
    try FileManager.default.createDirectory(at: root, withIntermediateDirectories: true)
    for (relativePath, contents) in resources {
      let fileURL = root.appendingPathComponent("Content/\(relativePath)")
      try FileManager.default.createDirectory(
        at: fileURL.deletingLastPathComponent(),
        withIntermediateDirectories: true
      )
      try contents.write(to: fileURL, atomically: true, encoding: .utf8)
    }
    guard let bundle = Bundle(url: root) else {
      throw CocoaError(.fileNoSuchFile)
    }
    return bundle
  }
}
