import Foundation

struct ArchitectureItem: Identifiable {
    let id: String
    let title: String
    let branchName: String
    let isCurrentBranch: Bool
    var iconName: String {
        isCurrentBranch ?
        "chevron.right" :
        "doc.on.doc.fill"
    }

    init(
        title: String,
        branchName: String,
        isCurrentBranch: Bool
    ) {
        self.id = UUID().uuidString
        self.title = title
        self.branchName = branchName
        self.isCurrentBranch = isCurrentBranch
    }
}
