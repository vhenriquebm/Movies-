//
//  ApiService.swift
//  Movies
//
//  Created by Vitor Henrique Barreiro Marinho on 18/03/22.
//

import Foundation
import UIKit


class Service {
    
    enum ImageSize: String {
           case original
           case w780
           case w500
           case w300
           case w200
       }
    
    
    
    

func fetchData (){
    
    var popularMovies:[Result]?
    
    guard let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=7f90c16b1428bbd2961cbdfd637dba99&language=pt-US&page=") else {return}
    
    
    URLSession.shared.dataTask(with: url) { data, response, error in
        
        if let error = error {
            
            print ("error \(error.localizedDescription)")
            
        return
            
        }
        
        if let data = data {
            
            do {
                let discover = try JSONDecoder().decode(MovieResult.self, from: data)
               // print (discover.results.count)

                popularMovies = discover.results
               // print (discover.results.count)
            
                
            } catch let error {
                
                print (error)
                return
            }
            
            
        } else {
            return
        }
    
    } .resume()
    
    
}
    
    
    
 
    
    


}
