import Domain

public enum DescriptorFixture {
  public static func make(
    id: String = "fixture-descriptor",
    names: LocalizedText = LocalizedText(values: ["es": "Descriptor de prueba"]),
    family: DescriptorFamily = .redFruit
  ) -> Descriptor {
    Descriptor(id: id, names: names, family: family)
  }
}
