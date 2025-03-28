//
//  jsonEncoder.swift
//  Serena-Backend
//
//  Created by Angel Escalante Garza on 28/03/25.
//
// Funciones para guardar y cargar JSON
import Foundation

class ReadJsonData: ObservableObject {
    @Published var appDatas = [AppData]()
    
    init() {
        loadData()
    }
    
    func loadData() {
        guard let url = Bundle.main.url(forResource: "data", withExtension: "json") else {
            print("JSON not found")
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            var appDatas = try JSONDecoder().decode([AppData].self, from: data)
            self.appDatas = appDatas
        } catch {
            print("Error loading or decoding JSON: \(error)")
        }
    }
}
