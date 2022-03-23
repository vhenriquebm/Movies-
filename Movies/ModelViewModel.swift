//
//  ModelViewModel.swift
//  Movies
//
//  Created by Vitor Henrique Barreiro Marinho on 18/03/22.
//

import Foundation

/*
class ModelViewModel: ObservableObject {
    
    func fetchData (){
        
        
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=7f90c16b1428bbd2961cbdfd637dba99&language=en-US&page=") else {return}
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                
                print ("error \(error.localizedDescription)")
            return
            }
            
            if let data = data {
                
                do {
                    let discover = try JSONDecoder().decode(Result.self, from: data)
                    print (discover.result.count)
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
*/
