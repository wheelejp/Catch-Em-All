//
//  CreaturesViewModel.swift
//  CatchEmAll
//
//  Created by Jonathan Wheeler Jr. on 3/13/23.
//

import Foundation

@MainActor
class CreaturesViewModel: ObservableObject {
    
    private struct Returned: Codable {
        var count: Int
        var next: String
        var results: [Creature]
    }
    
    
    
    @Published var urlString = "https://pokeapi.co/api/v2/pokemon/"
    @Published var count = 0
    @Published var creaturesArray: [Creature] = []
    
    func getData() async {
        print("We are accessing the url \(urlString)")
        
        guard let url = URL(string: urlString) else {
            print("error: we could not create a url from \(urlString)")
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            guard let returned = try? JSONDecoder().decode(Returned.self, from: data) else {
                return
            }
            self.count = returned.count
            self.urlString = returned.next ?? ""
            self.creaturesArray = self.creaturesArray + returned.results
        } catch {
            print("error: we could not use data from \(urlString) to get data and response")
        }
    }
}
