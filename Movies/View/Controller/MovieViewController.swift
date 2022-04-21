//
//  MovieViewController.swift
//  Movies
//
//  Created by Vitor Henrique Barreiro Marinho on 21/03/22.
//

import UIKit

let reuseIdentifier = "cell"

class MovieViewController: UIViewController, UISearchBarDelegate {
    
 let modelo = MovieViewModel()
    
    var filteredData: [Result] = []
 
    //MARK: - OUTLETS
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        updateView()
        configuraTableView()
        searchBar.delegate = self
       // filteredData = modelo.dataList
        
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        updateView()
    }
    
    
    // MARK: - UITableView Registration
    
    func updateView () {
        modelo.fetchMoviesData()
        modelo.fetchMoviesDataPage2()
        filteredData = modelo.dataList
        tableView.reloadData()
        print ( "A TableView foi atualizada")
        print (filteredData)
        print(modelo.dataList)
    }
    
    
    
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
            filteredData = modelo.dataList
        } else {
            
            for test in modelo.dataList {
                
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
    
    
    

}





