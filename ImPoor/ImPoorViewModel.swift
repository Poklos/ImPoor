//
//  ImPoorViewModel.swift
//  ImPoor
//
//  Created by Filip Pokłosiewicz on 02/08/2024.
//

import SwiftUI
import Combine

class ImPoorViewModel: ObservableObject {
    @Published var todaysText: String = ""
    private var results = [Result]()
    
    init() {
        Task {
            await loadData()
        }
    }
    
    func loadData() async {
        guard let url = URL(string: "https://raw.githubusercontent.com/Poklos/impoor/main/impoor.json") else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedResponse = try JSONDecoder().decode([Result].self, from: data)
            await MainActor.run {
                self.results = decodedResponse
                self.updateTodaysText()
            }
        } catch {
            print("Failed to load data: \(error)")
        }
    }
    
    func updateTodaysText() {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        
        let defaults = UserDefaults.standard
        if let lastUpdated = defaults.object(forKey: "lastUpdated") as? Date,
           let savedTextId = defaults.object(forKey: "todaysTextId") as? Int,
           calendar.isDate(today, inSameDayAs: lastUpdated) {
            if let savedText = results.first(where: { $0.id == savedTextId }) {
                todaysText = savedText.text
                return // Already updated today
            }
        }
        
        // Update today's text
        if !results.isEmpty {
            // To select randomly
            let selectedResult = results.randomElement()
            todaysText = selectedResult?.text ?? "No text available"
            defaults.set(selectedResult?.id, forKey: "todaysTextId")
            
            // To select in order
            // let index = calendar.ordinality(of: .day, in: .era, for: today)! % results.count
            // let selectedResult = results[index]
            // todaysText = selectedResult.text
            // defaults.set(selectedResult.id, forKey: "todaysTextId")
            
            defaults.set(today, forKey: "lastUpdated")
        }
    }
}
