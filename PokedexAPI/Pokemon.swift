
import Foundation

// modelos para guardar los datos de la API de Pokemon

struct PokemonResponse: Codable {
    let results: [Pokemon]
}

struct Pokemon: Codable, Identifiable {
    let name: String
    let url: String

    var id: Int {
        Int(URL(string: url)?.lastPathComponent ?? "") ?? 0
    }

    var imageURL: URL? {
        URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png")
    }
}

struct PokemonDetail: Codable {
    let id: Int
    let name: String
    let height: Int
    let weight: Int
    let types: [PokemonType]
    let abilities: [PokemonAbility]
    let sprites: PokemonSprites
}

struct PokemonType: Codable {
    let type: PokemonInfo
}

struct PokemonAbility: Codable {
    let ability: PokemonInfo
}

struct PokemonInfo: Codable {
    let name: String
}

struct PokemonSprites: Codable {
    let front_default: String?
}
