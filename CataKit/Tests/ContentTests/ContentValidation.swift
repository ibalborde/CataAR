import Foundation

enum ContentValidation {
  static func isKebabCase(_ id: String) -> Bool {
    guard !id.isEmpty else { return false }
    let parts = id.split(separator: "-", omittingEmptySubsequences: false)
    guard parts.allSatisfy({ !$0.isEmpty }) else { return false }
    return id.allSatisfy { $0.isLowercase || $0.isNumber || $0 == "-" }
  }

  static func hasEs(_ localized: [String: String]) -> Bool {
    guard let es = localized["es"] else { return false }
    return !es.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
  }

  static func isInScaleRange(_ value: Int) -> Bool {
    (1...5).contains(value)
  }
}
