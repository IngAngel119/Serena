//
//  jsonEncoder.swift
//  Serena-Backend
//
//  Created by Angel Escalante Garza on 28/03/25.
//
// Funciones para guardar y cargar JSON
import Foundation
import MapKit

/*class ReadJsonData: ObservableObject {
    @Published var appDatas = AppData()
    
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
            var gasStations = try JSONDecoder().decode([GasStation].self, from: data)
            
            // Geocodificar direcciones y actualizar coordenadas en las estaciones
            let dispatchGroup = DispatchGroup() // Usado para esperar que todos los geocodificados terminen

            for index in gasStations.indices {
                            // Verificar que las coordenadas existan y sean válidas
                if let latString = gasStations[index].Coordenadas?["lat"],
                   let lonString = gasStations[index].Coordenadas?["lon"],
                let lat = Double(latString),
                let lon = Double(lonString) {
                    // Asignar el nuevo CLLocationCoordinate2D
                    gasStations[index].coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                }
            }
            
            // Esperar a que todas las tareas de geocodificación terminen antes de filtrar
            dispatchGroup.notify(queue: .main) {
                // Filtrar solo las estaciones con coordenadas válidas
                self.gasStations = gasStations.filter { $0.coordinate != nil }
            }
            
        } catch {
            print("Error loading or decoding JSON: \(error)")
        }
    }
}
*/
