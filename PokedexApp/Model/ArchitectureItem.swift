import Foundation

struct ArchitectureItem: Identifiable {
    let id: String
    let type: ArchitectureType
    var title: String {
        type.rawValue
    }

    init(
        type: ArchitectureType
    ) {
        self.id = UUID().uuidString
        self.type = type
    }
}
