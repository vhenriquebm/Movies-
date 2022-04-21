//
//  InfoViewController.swift
//  Movies
//
//  Created by Vitor Henrique Barreiro Marinho on 22/03/22.
//

import UIKit

protocol ImageDelegate {
    
    func fetchImage (data: Result)
}


class InfoViewController: UIViewController {
    
    var dataMovie:Result?
    var popularDataArray = [Result]()
    let model = MovieViewModel ()
    var delegate: ImageDelegate?
    
    // MARK: - Outlets
    
    @IBOutlet weak var backgroundImage: UIImageView!
    
    @IBOutlet weak var movieImage: UIImageView!
    
    @IBOutlet weak var movieTitle: UILabel!
    
    @IBOutlet weak var info: UILabel!
    
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        movieTitle.text = dataMovie?.title
        info.text = dataMovie?.overview
        self.delegate = model
        self.movieImage.layer.cornerRadius = 10
    }
    
    
    

    
    

    
}




