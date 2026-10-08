
import Foundation
import Observation

@MainActor
@Observable
class PokemonViewModel {

    var pokemonList: [Pokemon] = []
    var isLoading = false
    var errorMessage: String?

    // responsabilidad unica: obtiene la lista de Pokemon de la API
    func fetchPokemon() async {

        isLoading = true
        errorMessage = nil

        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=30") else {
            errorMessage = "Invalid URL"
            isLoading = false
            return
        }

        do {
            let (data, response) = try await URLSession.shared.data(from: url)

            // verifica que la respuesta de la API sea correcta
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    let result = try JSONDecoder().decode(PokemonResponse.self, from: data)
                    pokemonList = result.results
                } else {
                    errorMessage = "API error: \(httpResponse.statusCode)"
                }
            } else {
                errorMessage = "Invalid server response"
            }

        } catch let error as URLError {
            // muestra un mensaje si no hay internet
            if error.code == .notConnectedToInternet {
                errorMessage = "No internet connection. Please try again."
            } else {
                errorMessage = "Network error: \(error.localizedDescription)"
            }

        } catch {
            errorMessage = "Could not load Pokemon."
        }

        isLoading = false
    }
}
