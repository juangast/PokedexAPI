
# PokedexAPI

## Descripcion
Aplicacion de Pokemon desarrollada con SwiftUI.
Muestra una lista de 30 Pokemon y permite ver los detalles de cada uno.

## API utilizada
PokeAPI: https://pokeapi.co/

Endpoints:
- https://pokeapi.co/api/v2/pokemon?limit=30
- https://pokeapi.co/api/v2/pokemon/{name}

## Funciones
- Lista de Pokemon con nombre e imagen
- Pantalla de detalles
- Navegacion con NavigationStack
- Indicadores de carga
- Manejo de errores de conexion y API
- Arquitectura MVVM

## Tecnologias
- Swift
- SwiftUI
- URLSession
- JSONDecoder

## Como ejecutar
- Xcode 16 o superior
- iOS 17.0 o superior

1. Descargar el repositorio.
2. Abrir PokedexAPI.xcodeproj en Xcode.
3. Seleccionar un simulador de iPhone.
4. Presionar Run para iniciar la aplicacion.

## Arquitectura
- Model: Pokemon.swift
- ViewModels: PokemonViewModel.swift y PokemonDetailViewModel.swift
- Views: ContentView.swift y PokemonDetailView.swift

## Autor
Juan de Dios Gastelum Gaxiola
