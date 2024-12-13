import Foundation

// Definir un modelo para la respuesta de la API (ajustar según la respuesta de la API)
struct HoroscopeDetail: Decodable {
    let data: HoroscopeData
}
struct HoroscopeData: Decodable {
    let horoscope_data: String
}

class NetworkManager {

    // URL base de la API
    private let baseURL = "https://horoscope-app-api.vercel.app/api/v1/get-horoscope/"

    // Función para obtener el detalle del horóscopo (modificada para usar los parámetros)
    func fetchHoroscopeDetail(for sign: String, onDay day: String, completion: @escaping (Result<HoroscopeDetail, Error>) -> Void) {
        // Construir la URL con los parámetros de consulta (sign y day)
        var urlComponents = URLComponents(string: "\(baseURL)daily")
        urlComponents?.queryItems = [
            URLQueryItem(name: "sign", value: sign.lowercased()),
            URLQueryItem(name: "day", value: day)
        ]
        
        guard let url = urlComponents?.url else {
            print("URL no válida")
            return
        }

        // Realizar la solicitud GET a la API
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            // Manejo de errores
            if let error = error {
                completion(.failure(error))
                return
            }

            // Verificar que se recibieron datos
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                return
            }

            // Intentar parsear los datos como JSON
            do {
                let decoder = JSONDecoder()
                let horoscopeDetail = try decoder.decode(HoroscopeDetail.self, from: data)
                completion(.success(horoscopeDetail))
            } catch {
                completion(.failure(error))
            }
        }

        // Iniciar la solicitud
        task.resume()
    }
}
