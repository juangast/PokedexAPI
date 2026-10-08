
import SwiftUI

struct ContentView: View {

    // ViewModel que maneja la lista de Pokemon
    @State private var viewModel = PokemonViewModel()

    var body: some View {

        // navegacion entre la lista de Pokemon y sus detalles
        NavigationStack {

            VStack {

                // muestra un indicador mientras cargan los datos
                if viewModel.isLoading {
                    ProgressView("Loading Pokemon...")

                } else if let error = viewModel.errorMessage {

                    Text(error)
                        .foregroundStyle(.red)
                        .multilineTextAlignment(.center)
                        .padding()

                    Button("Try Again") {
                        Task {
                            await viewModel.fetchPokemon()
                        }
                    }

                } else {

                    // muestra la lista de Pokemon
                    List(viewModel.pokemonList) { pokemon in

                        NavigationLink {
                            PokemonDetailView(name: pokemon.name)
                        } label: {

                            HStack(spacing: 15) {

                                // muestra la imagen o un indicador de carga
                                AsyncImage(url: pokemon.imageURL) { phase in
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
                                .frame(width: 65, height: 65)
                                .accessibilityHidden(true)

                                VStack(alignment: .leading) {

                                    Text(pokemon.name.capitalized)
                                        .font(.headline)

                                    Text("#\(pokemon.id)")
                                        .foregroundStyle(.gray)
                                }
                            }
                            .padding(5)
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Pokedex")
            .task {
                await viewModel.fetchPokemon()
            }
        }
    }
}

#Preview {
    ContentView()
}
