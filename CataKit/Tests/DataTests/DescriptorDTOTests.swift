import Domain
import Testing

@testable import Data

@Suite("DescriptorDTO")
struct DescriptorDTOTests {
  @Test("maps a known family")
  func mapsKnownFamily() throws {
    let dto = DescriptorDTO(id: "ciruela", names: ["es": "Ciruela"], family: "fruta negra")
    let descriptor = try dto.toDomain()
    #expect(descriptor.id == "ciruela")
    #expect(descriptor.names.es == "Ciruela")
    #expect(descriptor.family == .blackFruit)
  }

  @Test("throws decodingFailed for an unknown family")
  func throwsForUnknownFamily() {
    let dto = DescriptorDTO(id: "ciruela", names: ["es": "Ciruela"], family: "no-existe")
    #expect(throws: ContentError.decodingFailed("descriptor ciruela: unknown family 'no-existe'")) {
      try dto.toDomain()
    }
  }
}
