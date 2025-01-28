//
//  AddItemView.swift
//  Assignment Nodebook
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
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        NavigationView {
            Form {
                TextField("Description", text: $description)
                    .listRowBackground(colors[course] ?? (colorScheme == .dark ? Color.gray.opacity(0.2) : Color.white))
                DatePicker("Due Date", selection: $dueDate)
                    .listRowBackground(colors[course] ?? (colorScheme == .dark ? Color.gray.opacity(0.2) : Color.white))
                Picker("Course", selection: $course) {
                    ForEach(Self.courses, id: \.self) { course in
                        Text(course)
                    }
                }
                .listRowBackground(colors[course] ?? (colorScheme == .dark ? Color.gray.opacity(0.2) : Color.white))
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
        .preferredColorScheme(.dark)
}
