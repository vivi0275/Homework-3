//
//  ContentView.swift
//  checklist
//
//  Created by Andy Huang on 7/16/23.
//

import SwiftUI

// MARK: - ContentView
struct ContentView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            HeaderView(viewModel: viewModel)
            ListView(viewModel: viewModel)
        }
        .ignoresSafeArea(.keyboard)
    }
}

// MARK: - HeaderView
struct HeaderView: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 15) {
                Image("Victor")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(Color.gray, lineWidth: 2)
                    )
                
                Text("Victor Picart")
                    .font(.title)
                    .fontWeight(.bold)
            }
            .padding()
            
            HStack(spacing: 10) {
                TextField("Enter the Description", text: $viewModel.description)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button(action: {
                    viewModel.addTask()
                }) {
                    Text("Add")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.horizontal, 17)
                        .padding(.vertical, 10)
                        .background(Color.blue)
                        .cornerRadius(20)
                }
                .padding(.trailing)
            }
            .padding(.horizontal)
            .padding(.bottom, 10)
        }
        .background(Color(UIColor.systemBackground))
    }
}

// MARK: - ListView
struct ListView: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        List {
            Section(header: Text("In Progress").font(.headline)) {
                ForEach(viewModel.inProgressTasks, id: \.self) { task in
                    Button(action: {
                        viewModel.completeTask(task)
                    }) {
                        Text(task)
                            .foregroundColor(.primary)
                    }
                }
            }
            
            Section(header: Text("Complete").font(.headline)) {
                ForEach(viewModel.completedTasks, id: \.self) { task in
                    Button(action: {
                        viewModel.uncompleteTask(task)
                    }) {
                        HStack {
                            Image(systemName: "checkmark")
                                .foregroundColor(.green)
                            Text(task)
                                .strikethrough()
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
    }
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
