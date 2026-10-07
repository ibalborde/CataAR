/// Text localized by BCP-47-ish locale code, keyed as in content JSON (`{"es": "..."}`).
/// `es` is mandatory in content and acts as the fallback for any missing locale.
public struct LocalizedText: Sendable, Hashable {
  public let values: [String: String]

  public init(values: [String: String]) {
    self.values = values
  }

  public var es: String {
    values["es"] ?? ""
  }

  public func text(locale: String) -> String {
    values[locale] ?? es
  }
}
