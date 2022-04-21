//
//  MovieViewModel.swift
//  Movies
//
//  Created by Vitor Henrique Barreiro Marinho on 07/04/22.
//

import UIKit

let info = InfoViewController ()

class MovieViewModel: ImageDelegate {

    var dataList = [Result]()
    
public func fetchMoviesData () {
    
    guard let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=7f90c16b1428bbd2961cbdfd637dba99&language=pt-US&page=1") else {return}
        
    URLSession.shared.dataTask(with: url) { data, response, error in
        
        if let error = error {
            
            print ("error \(error.localizedDescription)")
            
            return
        }
        
        if let data = data {
            
            do {
                let discover = try JSONDecoder().decode(MovieResult.self, from: data)
                
                DispatchQueue.main.async {
                    self.dataList = discover.results
                }
                
            } catch let error {
                
                print (error)
                return
            }
            
        } else {
            return
        }
        
    } .resume()
}

func fetchMoviesDataPage2 () {
    
    guard let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=7f90c16b1428bbd2961cbdfd637dba99&language=pt-BR&page=2") else {return}
    
    URLSession.shared.dataTask(with: url) { data, response, error in
        
        if let error = error {
            
            print ("error \(error.localizedDescription)")
            
            return
        }
        
        if let data = data {
            
            do {
                let discover = try JSONDecoder().decode(MovieResult.self, from: data)
                
                DispatchQueue.main.async {
                    self.dataList.append(contentsOf: discover.results)
                    self.dataList.append(contentsOf: discover.results)
                }
                
            } catch let error {
                
                print (error)
                return
            }
            
        } else {
            return
        }
        
    } .resume()
}
    
    
    
    func fetchImage (data: Result) {
        
        let urlString = "https://image.tmdb.org/t/p/w342/\(data.poster_path)"
        guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                print ("Failed to fetch data with error:",  error.localizedDescription)
                return
            }
            
            do {
                guard let datas = data else {return}
                DispatchQueue.main.async {
                    let imageData = UIImage(data: datas)
                    info.movieImage.image = imageData
                    info.backgroundImage.image = imageData
                }
            }
            
        } .resume()
    }

}
