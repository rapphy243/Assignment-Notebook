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
