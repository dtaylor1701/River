//
//  ContentView.swift
//  RiverEditor
//
//  Created by David Taylor on 10/23/23.
//

import SwiftUI
import RiverKit
import Goose

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
  var selectedArtifact: Artifact?
  
  @State
  var selectedStep: Step?
  
  var body: some View {
    NavigationSplitView {
      List(ViewCategory.allCases, selection: $selectedCategory) { category in
        Button {
          selectedCategory = category
        } label: {
          Text(category.rawValue)
            .asListButtonContent(isSelected: category == selectedCategory)
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
        if let artifactBinding = selectedArtifact?.binding(in: $document.flow.artifacts) {
          EditArtifactView(artifact: artifactBinding, flow: $document.flow)
        } else {
          Text("Select an artifact")
        }
      case .steps:
        if let stepBinding = selectedStep?.binding(in: $document.flow.steps) {
          EditStepView(step: stepBinding, flow: $document.flow)
        } else {
          Text("Select a step")
        }
      }
    }
    .toolbar {
      ToolbarItem {
        Button {
          switch selectedCategory {
          case .artifacts:
            document.flow.artifacts.append(Artifact(description: "", fileName: ""))
          case .steps:
            document.flow.steps.append(Step(name: "New Step", dependencyIDs: [], actions: []))
          }
        } label: {
          Image(systemName: "plus")
        }
      }
    }
  }
}

#Preview {
  ContentView(document: .constant(RiverEditorDocument(flow: .dummy())))
}
