//
//  RiverEditorApp.swift
//  RiverEditor
//
//  Created by David Taylor on 10/23/23.
//

import SwiftUI

@main
struct RiverEditorApp: App {
    var body: some Scene {
        DocumentGroup(newDocument: RiverEditorDocument()) { file in
            ContentView(document: file.$document)
        }
    }
}
