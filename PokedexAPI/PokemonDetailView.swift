
import SwiftUI

struct PokemonDetailView: View {

    let name: String

    // ViewModel que maneja la informacion del Pokemon seleccionado
    @State private var viewModel = PokemonDetailViewModel()

    var body: some View {

        ScrollView {

            VStack(spacing: 20) {

                // muestra la carga o los errores de la API
                if viewModel.isLoading {

                    ProgressView("Loading details...")
                        .padding()

                } else if let error = viewModel.errorMessage {

                    Text(error)
                        .foregroundStyle(.red)
                        .multilineTextAlignment(.center)

                    Button("Try Again") {
                        Task {
                            await viewModel.fetchDetail(name: name)
                        }
                    }

                } else if let pokemon = viewModel.pokemon {

                    // muestra la imagen del Pokemon
                    AsyncImage(url: URL(string: pokemon.sprites.front_default ?? "")) { phase in
                        switch phase {
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()

                        case .failure:
                            Image(systemName: "photo")

                        default:
                            ProgressView()
                        }
                    }
                    .frame(width: 200, height: 200)
                    .accessibilityLabel("\(pokemon.name) image")

                    Text(pokemon.name.capitalized)
                        .font(.largeTitle)
                        .bold()

                    Text("#\(pokemon.id)")
                        .foregroundStyle(.gray)

                    // Clean Code: organiza la informacion del Pokemon
                    VStack(alignment: .leading, spacing: 15) {

                        HStack {
                            Text("Height:")
                                .bold()
                            Spacer()
                            Text(String(format: "%.1f m", Double(pokemon.height) / 10))
                        }

                        HStack {
                            Text("Weight:")
                                .bold()
                            Spacer()
                            Text(String(format: "%.1f kg", Double(pokemon.weight) / 10))
                        }

                        HStack {
                            Text("Type:")
                                .bold()
                            Spacer()
                            Text(pokemon.types.map { $0.type.name.capitalized }.joined(separator: ", "))
                                .multilineTextAlignment(.trailing)
                        }

                        HStack {
                            Text("Abilities:")
                                .bold()
                            Spacer()
                            Text(pokemon.abilities.map { $0.ability.name.capitalized }.joined(separator: ", "))
                                .multilineTextAlignment(.trailing)
                        }
                    }
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(15)
                    .padding(.horizontal)
                }
            }
            .padding(.top, 30)
        }
        .navigationTitle(name.capitalized)
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.fetchDetail(name: name)
        }
    }
}
