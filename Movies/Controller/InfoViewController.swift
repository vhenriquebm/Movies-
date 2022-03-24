//
//  InfoViewController.swift
//  Movies
//
//  Created by Vitor Henrique Barreiro Marinho on 22/03/22.
//

import UIKit

class InfoViewController: UIViewController {
    
    var dataMovie:Result?
    var popularDataArray = [Result]()
    
    // MARK: - Outlets
    
    @IBOutlet weak var backgroundImage: UIImageView!
    
    @IBOutlet weak var movieImage: UIImageView!
    
    @IBOutlet weak var movieTitle: UILabel!
    
    @IBOutlet weak var info: UILabel!
    
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        movieTitle.text = dataMovie?.title
        info.text = dataMovie?.overview
        movieImage.layer.cornerRadius = 10
        fetchImage(data: dataMovie!)
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
                    self.movieImage.image = UIImage(data: datas)
                    self.backgroundImage.image = UIImage(data: datas)
                    self.movieImage.layer.cornerRadius = 10
                }
            }
            
        } .resume()
    }
    
}




