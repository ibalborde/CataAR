import Domain

struct DescriptorDTO: Codable {
  let id: String
  let names: [String: String]
  let family: String
}

extension DescriptorDTO {
  func toDomain() throws -> Descriptor {
    guard let family = DescriptorFamily(rawValue: family) else {
      throw ContentError.decodingFailed("descriptor \(id): unknown family '\(family)'")
    }
    return Descriptor(id: id, names: LocalizedText(values: names), family: family)
  }
}
