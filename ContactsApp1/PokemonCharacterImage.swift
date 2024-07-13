//
//  PokemonCharacterImage.swift
//  ContactsApp
//
//  Created by pc on 7/11/24.
//

import Foundation

struct PokemonCharacterImage: Codable {
  let sprites: Sprites
}
struct Sprites: Codable {
  let frontDefault: String
  
  enum CodingKeys: String, CodingKey {
    case frontDefault = "front_default"
  }
}

