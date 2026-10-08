import ContentBundle
import Foundation

@testable import Data

enum ContentFiles {
  static var manifestURL: URL? {
    ContentBundle.resourceBundle.url(
      forResource: "manifest",
      withExtension: "json",
      subdirectory: "Content"
    )
  }

  static var descriptorsURL: URL? {
    ContentBundle.resourceBundle.url(
      forResource: "descriptors",
      withExtension: "json",
      subdirectory: "Content"
    )
  }

  static var grapeFileURLs: [URL] {
    ContentBundleJSONLoader.jsonFileURLs(in: "grapes", bundle: ContentBundle.resourceBundle)
  }

  static var regionFileURLs: [URL] {
    ContentBundleJSONLoader.jsonFileURLs(in: "regions", bundle: ContentBundle.resourceBundle)
  }
}
