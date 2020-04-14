//
//  ViewController.swift
//  FIlmLocations
//
//  Created by Henry Calderon on 4/13/20.
//  Copyright © 2020 Henry Calderon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let table: UITableView = {
       let table = UITableView()
       table.translatesAutoresizingMaskIntoConstraints = false
       table.rowHeight = 100
       return table
    }()
    
    var films:[FilmEntryCodable] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getDataFromFile("locations")
        table.dataSource = self
        table.delegate = self
        //Setting up the table
        table.register(TableCell.self, forCellReuseIdentifier: TableCell.identifier)
        self.view.addSubview(table)
        NSLayoutConstraint.activate([
            table.topAnchor.constraint(equalTo: self.view.topAnchor),
            table.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            table.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            table.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
    
    //method name suggestion
    func getDataFromFile(_ fileName:String){
        let path = Bundle.main.path(forResource: fileName, ofType: ".json")
        if let path = path {
            let url = URL(fileURLWithPath: path)
            let contents = try? Data(contentsOf: url)
            if let data = contents{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                do {
                    let filmsFromJSON = try decoder.decode([FilmEntryCodable].self, from: data)
                    films = filmsFromJSON
                    table.reloadData()
                } catch {
                    print("Parsing Failed")
                }
            }
        }
    }
//    func getDataFromFile(_ fileName:String){
//        let path = Bundle.main.path(forResource: fileName, ofType: ".json")
//        if let path = path {
//          let url = URL(fileURLWithPath: path)
//          print(url)
//            //STuff-----------------
//            let contents = try? Data(contentsOf: url)
//            do {
//              if let data = contents,
//              let jsonResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [[String:Any]] {
//                print(jsonResult)
//                for film in jsonResult{
////                    let firstActor = film["actor_1"] as? String ?? ""
////                    let locations = film["locations"] as? String  ?? ""
////                    let releaseYear = film["release_year"] as? String  ?? ""
////                    let title = film["title"] as? String  ?? ""
////                    let movie = FilmEntry(firstActor: film["actor_1"], locations: film["locations"], releaseYear: film["release_year"], title: film["title"])
//                    guard let film = FilmEntry(json: film) else { continue }
//                    films.append(film)
//                }
//                table.reloadData()
//              }
//            } catch {
//              print("Error deserializing JSON: \(error)")
//            }
//
//        }
//
//    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return films.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableCell.identifier, for: indexPath) as! TableCell
        cell.textLabel?.text = "\(films[indexPath.row].locations)  \(films[indexPath.row].releaseYear.value)"
//        cell.textLabel?.text = films[indexPath.row].locations

        return cell
    }
}


