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
    
    func loadData() { //Comentario se debe usar la primera vez, sino no hay información
        guard let url = getDocumentsURL() /*Bundle.main.url(forResource: "data", withExtension: "json")*/ else {
            print("JSON not found")
            return
        }
        do {
            let data = try Data(contentsOf: url)
            let appData = try JSONDecoder().decode(AppData.self, from: data)
            self.appDatas = [appData] 
        } catch {
            print("Error loading or decoding JSON: \(error)")
        }
        
    }
    
    func saveData() {
        guard let url = getDocumentsURL() else {
            print("Error obteniendo la URL del documento")
            return
        }
        
        do {
            let data = try JSONEncoder().encode(appDatas.first)
            try data.write(to: url)
            print("✅ Datos guardados en JSON")
        } catch {
            print("❌ Error guardando JSON: \(error)")
        }
    }
    
    private func getDocumentsURL() -> URL? {
        let fileManager = FileManager.default
        guard let docsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        let fileURL = docsURL.appendingPathComponent("data.json")
            print("📂 JSON guardado en: \(fileURL.path)")
        return docsURL.appendingPathComponent("data.json")
    }


}
