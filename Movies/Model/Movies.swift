//
//  StarkModel.swift
//  starkMoviesProject
//
//  Created by Vitor Henrique Barreiro Marinho on 17/03/22.
//

import Foundation
import UIKit

struct MovieResult: Decodable {
    
    let results: [Result]
}

struct Result: Identifiable, Decodable {
    
    let id: Int
    let title: String
    let overview: String
    var poster_path: String
    let vote_average: Float
    let vote_count:Int
    let release_date:String
}












