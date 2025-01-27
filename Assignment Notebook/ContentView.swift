//
//  ContentView.swift
//  Assignment Notebook
//
//  Created by Raphael Abano on 1/24/25.
//

import SwiftUI

struct ContentView: View {
    @State private var assignmentItems = AssignmentList()
    @State private var showAddItemView = false
    var body: some View {
        NavigationView {
            List {
                ForEach(assignmentItems.items) { item in
                    HStack {
                        VStack(alignment: .leading, content: {
                            Text(item.course)
                                .font(.headline)
                            Text(item.description)
                        })
                        Spacer()
                        Text(item.dueDate, style: .date)
                    }
                    .listRowBackground(colors[item.course]!)
                }
                .onMove(perform: { indices, newOffset in
                    assignmentItems.items.move(fromOffsets: indices, toOffset: newOffset)
                })
                .onDelete(perform: { indexSet in
                    assignmentItems.items.remove(atOffsets: indexSet)
                })
            }
            .navigationBarTitle("Assignments")
            .navigationBarItems(leading: EditButton(),
                                trailing: Button(action: {
                showAddItemView = true
            }, label: {
                Image(systemName: "plus")
            }))
            .sheet(isPresented: $showAddItemView, content: {
                AddItemView(assignmentItems: assignmentItems)
            })
        }
    }
}

#Preview {
    ContentView()
        .preferredColorScheme(.dark)
}
