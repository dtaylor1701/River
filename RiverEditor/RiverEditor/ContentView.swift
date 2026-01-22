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
  case artifacts
  case steps
  
  var id: String {
    rawValue
  }
  
  var displayValue: String {
    switch self {
    case .artifacts:
      return "Artifacts"
    case .steps:
      return "Steps"
    }
  }
}

enum Sheet: String, Identifiable {
  case newArtifact
  case newStep
  
  var id: String {
    rawValue
  }
}

struct ContentView: View {
  @Binding var document: RiverEditorDocument
  
  @State
  var selectedCategory: ViewCategory = .steps
  
  @State
  var selectedArtifact: Artifact?
  
  @State
  var selectedStep: Step?
  
  @State
  var sheet: Sheet?
  
  var body: some View {
    NavigationSplitView {
      List(ViewCategory.allCases, selection: $selectedCategory) { category in
        Button {
          selectedCategory = category
        } label: {
          Text(category.displayValue)
            .asListButtonContent(isSelected: category == selectedCategory)
            .tag(category)
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
            sheet = .newArtifact
          case .steps:
            sheet = .newStep
          }
        } label: {
          Image(systemName: "plus")
        }
      }
    }
    .sheet(item: $sheet) { selectedSheet in
      switch selectedSheet {
      case .newArtifact:
        NewArtifactView { newArtifact in
          document.flow.artifacts.append(newArtifact)
          selectedArtifact = newArtifact
        }
      case .newStep:
        NewStepView { newStep in
          document.flow.steps.append(newStep)
          selectedStep = newStep
        }
      }
    }
  }
}

#Preview {
  ContentView(document: .constant(RiverEditorDocument(flow: .dummy())))
}
