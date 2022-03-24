//
//  MovieViewController.swift
//  Movies
//
//  Created by Vitor Henrique Barreiro Marinho on 21/03/22.
//

import UIKit

let reuseIdentifier = "cell"

class MovieViewController: UIViewController, UISearchBarDelegate {
    
    var dataList = [Result]()
    var filteredData: [Result] = []
 
    //MARK: - OUTLETS
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        configuraTableView()
        searchBar.delegate = self
        filteredData = dataList
        fetchMoviesData()
        fetchMoviesDataPage2 ()
    }
    
    // MARK: - UITableView Registration
    
    func configuraTableView () {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
    }
}


     // MARK: - Setting Up the UItableView

extension MovieViewController: UITableViewDelegate, UITableViewDataSource {
    
    // transfering information between controllers
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "infoView", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! InfoViewController
        guard let row = tableView.indexPathForSelectedRow?.row else {return}
        let movie = filteredData[row]
        vc.dataMovie = movie
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return filteredData.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MovieTableViewCell
        
        cell.fetchInfo(data: filteredData[indexPath.row])
        
        return cell
    }
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        450
    }
    
    
    
    
    //MARK: - SearchBar Methods
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filteredData = []
        
        if searchText.isEmpty {
            filteredData = dataList
        } else {
            
            for test in dataList {
                
                if test.title.uppercased().contains(searchText.uppercased()) {
                    
                    filteredData.append(test)
                }
            }
        }
        
        self.tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
    }
    
    
    
    //MARK: - Fetch Movies Data
    
    func fetchMoviesData () {
        
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
                        self.filteredData = discover.results
                        self.tableView.reloadData()
                        
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
                        self.filteredData.append(contentsOf: discover.results)
                        self.filteredData.append(contentsOf: discover.results)
                        self.tableView.reloadData()
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
}





