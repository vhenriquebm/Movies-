//
//  PopularMovieTableViewCell.swift
//  Movies
//
//  Created by Vitor Henrique Barreiro Marinho on 22/03/22.
//


import UIKit

class MovieTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var movieImage: UIImageView!
    
    @IBOutlet weak var movieTitle: UILabel!
    
    @IBOutlet weak var voteAverage: UILabel!
    
    @IBOutlet weak var year: UILabel!
    
    @IBOutlet weak var overview: UILabel!
    
    @IBOutlet weak var voteCount: UILabel!
    
    
    // MARK: - Methods
    
    func fetchInfo (data: Result) {
        
        movieTitle.text = data.title
        voteAverage.text = String(data.vote_average)
        voteCount.text = String(data.vote_count)
        year.text = data.release_date
        overview.text = data.overview
        
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
                    self.movieImage.layer.cornerRadius = 10
                }
            }
            
        } .resume()
    }
}


