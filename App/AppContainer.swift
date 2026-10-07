// Composition root: the only place in the app that knows concrete Data types.
// Wire this into CataARApp once CataAR.xcodeproj depends on the CataKit package.
//
// import ContentBundle
// import Data
// import Domain
//
// @MainActor
// struct AppContainer {
//     let grapeRepository: GrapeRepository = JSONGrapeRepository()
//     let regionRepository: RegionRepository = JSONRegionRepository()
//     let descriptorRepository: DescriptorRepository = JSONDescriptorRepository()
// }
