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
            List(creaturesVM.creaturesArray , id: \.self) { creature in
                Text(creature.name)
                    .font(.title2)
            }
            .listStyle(.plain)
            .navigationTitle("Pokemon")
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
