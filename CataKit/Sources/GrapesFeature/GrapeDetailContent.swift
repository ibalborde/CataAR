import Domain

public struct GrapeDetailContent: Sendable {
  public let grape: Grape
  public let descriptors: [String: Descriptor]
  public let grapeNames: [String: String]

  public init(grape: Grape, descriptors: [String: Descriptor], grapeNames: [String: String]) {
    self.grape = grape
    self.descriptors = descriptors
    self.grapeNames = grapeNames
  }
}
