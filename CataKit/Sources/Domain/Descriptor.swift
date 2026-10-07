public struct Descriptor: Sendable, Hashable, Identifiable {
  public let id: String
  public let names: LocalizedText
  public let family: DescriptorFamily

  public init(id: String, names: LocalizedText, family: DescriptorFamily) {
    self.id = id
    self.names = names
    self.family = family
  }
}
