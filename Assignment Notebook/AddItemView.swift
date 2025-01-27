//
//  AddItemView.swift
//  To-Do-List
//
//  Created by Raphael Abano on 1/22/25.
//

import SwiftUI

struct AddItemView: View {
    @Environment(\.presentationMode) var presintationMode
    static let courses = ["English", "Math", "Science", "Computer Science", "Social Studies", "Economics", "World Language"]
    @ObservedObject var assignmentItems: AssignmentList
    @State private var course = ""
    @State private var description = ""
    @State private var dueDate = Date()
    var body: some View {
        NavigationView {
            Form {
                TextField("Description", text: $description)
                DatePicker("Due Date", selection: $dueDate)
                Picker("Course", selection: $course) {
                    ForEach(Self.courses, id: \.self) { course in
                        Text(course)
                    }
                }
            }
            .navigationBarTitle("Add New Assignment", displayMode: .inline)
            .navigationBarItems(trailing: Button("Save") {
                if course.count > 0 && description.count > 0 {
                    let item = AssignmentItem(id: UUID(), course: course, description: description, dueDate: dueDate)
                    assignmentItems.items.append(item)
                    presintationMode.wrappedValue.dismiss()
                }
            })
        }
    }
}

#Preview {
    AddItemView(assignmentItems: AssignmentList())
}
