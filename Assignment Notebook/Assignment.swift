//
//  Assignment.swift
//  Assignment Notebook
//
//  Created by Raphael Abano on 1/24/25.
//

import SwiftUI

class AssignmentList: ObservableObject {
    @Published var items : [AssignmentItem] {
        didSet {
            if let encodedData = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encodedData, forKey: "data")
            }
        }
    }
    init() {
        if let data = UserDefaults.standard.data(forKey: "data") {
            if let decodedData = try? JSONDecoder().decode([AssignmentItem].self, from: data) {
                items = decodedData
                return
            }
        }
        items = []
    }
}

struct AssignmentItem : Identifiable, Codable {
    var id = UUID()
    var course: String
    var description: String
    var dueDate = Date()
}

let colors = ["English": Color.blue,
              "Math": Color.gray,
              "Science": Color.green,
              "Computer Science": Color.gray,
              "Social Studies": Color.orange,
              "Economics": Color.orange,
              "World Language": Color.yellow]

let icons = ["English": "book",
             "Math": "plus.forwardslash.minus",
             "Science": "atom",
             "Computer Science": "apple.terminal",
             "Social Studies": "globe",
             "Economics": "chart.line.uptrend.xyaxis",
             "World Language": "translate"]
