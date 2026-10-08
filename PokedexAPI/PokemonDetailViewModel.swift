
import Foundation
import Observation

@MainActor
@Observable
class PokemonDetailViewModel {

    var pokemon: PokemonDetail?
    var isLoading = false
    var errorMessage: String?

    // responsabilidad unica: obtiene los detalles de un Pokemon
    func fetchDetail(name: String) async {

        isLoading = true
        errorMessage = nil

        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(name)") else {
            errorMessage = "Invalid URL"
            isLoading = false
            return
        }

        do {
            let (data, response) = try await URLSession.shared.data(from: url)

            // verifica el codigo de respuesta de la API
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    pokemon = try JSONDecoder().decode(PokemonDetail.self, from: data)
                } else {
                    errorMessage = "API error: \(httpResponse.statusCode)"
                }
            } else {
                errorMessage = "Invalid server response"
            }

        } catch let error as URLError {
            // maneja los errores de conexion
            if error.code == .notConnectedToInternet {
                errorMessage = "No internet connection. Please try again."
            } else {
                errorMessage = "Network error: \(error.localizedDescription)"
            }

        } catch {
            errorMessage = "Could not load Pokemon details."
        }

        isLoading = false
    }
}
