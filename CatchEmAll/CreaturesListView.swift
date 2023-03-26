//
//  CreaturesListView.swift
//  CatchEmAll
//
//  Created by Jonathan Wheeler Jr. on 3/13/23.
//

import SwiftUI

struct CreaturesListView: View {
    var creatures = ["Pikachu", "Squirtle", "Charizard", "Snorlax"]
    @StateObject var creaturesVM = CreaturesViewModel()
    var body: some View {
        NavigationStack {
            ZStack {
                List(0..<creaturesVM.creaturesArray.count , id: \.self) { index in
                    
                    LazyVStack {
                        NavigationLink {
                            DetailView(creature: creaturesVM.creaturesArray[index])
                        } label: {
                            Text("\(index+1). \(creaturesVM.creaturesArray[index].name.capitalized)")
                                .font(.title2)
                        }
                    }
                    .onAppear {
                        if let lastcreature = creaturesVM.creaturesArray.last {
                            if creaturesVM.creaturesArray[index].name == lastcreature.name && creaturesVM.urlString.hasPrefix("http") {
                                Task {
                                    await creaturesVM.getData()
                                }
                            }
                        }
                    }
                }
                .listStyle(.plain)
                .navigationTitle("Pokemon")
                .toolbar {
                    ToolbarItem (placement: .bottomBar){
                        Text("\(creaturesVM.creaturesArray.count) of \(creaturesVM.count)")
                    }
                }
                if creaturesVM.isLoading {
                    ProgressView()
                        .tint(.red)
                        .scaleEffect(4)
                } 
            }
        }
        .task {
            await creaturesVM.getData()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CreaturesListView()
    }
}
