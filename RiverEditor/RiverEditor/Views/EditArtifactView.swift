import Foundation
import SwiftUI
import RiverKit

struct EditArtifactView: View {
    @Binding
    var artifact: StoredArtifact
    
    var title: String {
        "Edit Artifact"
    }
    
    var contentTypes: [Artifact.Content] = [.text, .url, .bool, .number]
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("File name", text: $artifact.fileName)
                TextField("Description", text: $artifact.description)
                Picker("Content Type", selection: $artifact.contentType) {
                    ForEach(contentTypes) { type in
                        Text(type.displayValue)
                            .id(type.rawValue)
                    }
                }
            }
            .navigationTitle(title)
        }
    }
}

extension Artifact.Content: Identifiable {
    public var id: String {
        rawValue
    }
    
    var displayValue: String {
        switch self {
        case .bool:
            return "Boolean"
        case .number:
            return "Number"
        case .text:
            return "Text"
        case .url:
            return "URL"
        }
    }
}
