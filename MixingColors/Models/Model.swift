//
//  Model.swift
//  MixingColors
//
//  Created by Natalia on 23.05.2024.
//

struct Color: Decodable {
    let name: ColorName
}

struct ColorName: Decodable {
    let value: String
}
