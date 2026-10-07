import Foundation

/// Exposes the resource bundle holding `manifest.json`, `descriptors.json`, and the
/// `grapes/` and `regions/` content directories.
public enum ContentBundle {
  public static var resourceBundle: Bundle {
    Bundle.module
  }
}
