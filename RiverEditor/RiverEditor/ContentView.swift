//
//  ContentView.swift
//  RiverEditor
//
//  Created by David Taylor on 10/23/23.
//

import SwiftUI
import RiverKit

enum ViewCategory: String, Identifiable, CaseIterable {
    var id: String {
        rawValue
    }
    
    case artifacts
    case steps
}

struct ContentView: View {
    @Binding var document: RiverEditorDocument
    
    @State
    var selectedCategory: ViewCategory = .steps
    
    @State
    var selectedArtifact: StoredArtifact?
    
    @State
    var selectedStep: StoredStep?
    
    var body: some View {
        NavigationSplitView {
            List(ViewCategory.allCases, selection: $selectedCategory) { category in
                Button {
                    selectedCategory = category
                } label: {
                    Text(category.rawValue)
                }
            }
            .buttonStyle(.plain)
        } content: {
            switch selectedCategory {
            case .artifacts:
                ArtifactsView(artifacts: $document.flow.artifacts, selected: $selectedArtifact)
            case .steps:
                StepsView(steps: $document.flow.steps, selected: $selectedStep)
            }
        } detail: {
            switch selectedCategory {
            case .artifacts:
                if let artifactBinding = artifactBinding(selectedArtifact) {
                    EditArtifactView(artifact: artifactBinding)
                } else {
                    Text("Select an artifact")
                }
            case .steps:
                Text(selectedStep?.name ?? "Select a step")
            }
        }
    }
    
    func artifactBinding(_ artifact: StoredArtifact?) -> Binding<StoredArtifact>? {
        guard let artifact, 
                let index = document.flow.artifacts.firstIndex(where: { $0.fileName == artifact.fileName }) else {
            return nil
        }
        
        return Binding {
            document.flow.artifacts[index]
        } set: { newValue in
            document.flow.artifacts[index] = newValue
        }

    }
}

#Preview {
    ContentView(document: .constant(RiverEditorDocument(flow: .exampleFlow())))
}


func unwrapped<Value>(_ binding: Binding<Value?>) -> Binding<Value>? {
    guard let value = binding.wrappedValue else {
        return nil
    }
    
    return Binding(get: { return value }, set: { binding.wrappedValue = $0 })
}
