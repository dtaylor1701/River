//
//  RiverEditorDocument.swift
//  RiverEditor
//
//  Created by David Taylor on 10/23/23.
//

import SwiftUI
import UniformTypeIdentifiers
import RiverKit

extension UTType {
  static var flow: UTType {
    UTType(importedAs: "com.river.flow")
  }
}

struct RiverEditorDocument: FileDocument {
  var flow: Flow
  
  init(flow: Flow = Flow.dummy()) {
    self.flow = flow
  }
  
  static var readableContentTypes: [UTType] { [.flow] }
  
  init(configuration: ReadConfiguration) throws {
    guard let data = configuration.file.regularFileContents else {
      throw CocoaError(.fileReadCorruptFile)
    }
    
    self.flow = try JSONDecoder().decode(Flow.self, from: data)
  }
  
  func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
    let data = try JSONEncoder().encode(flow)
    return .init(regularFileWithContents: data)
  }
}
