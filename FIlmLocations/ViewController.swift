//
//  ViewController.swift
//  FIlmLocations
//
//  Created by Henry Calderon on 4/13/20.
//  Copyright © 2020 Henry Calderon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var films:[FilmEntry] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getDataFromFile("locations")
    }
    
    //method name suggestion
    func getDataFromFile(_ fileName:String){
        let path = Bundle.main.path(forResource: fileName, ofType: ".json")
        if let path = path {
          let url = URL(fileURLWithPath: path)
          print(url)
            //STuff-----------------
            let contents = try? Data(contentsOf: url)
            do {
              if let data = contents,
              let jsonResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [[String:Any]] {
                print(jsonResult)
                for film in jsonResult{
                    let firstActor = film["actor_1"] as? String ?? ""
                    let locations = film["locations"] as? String  ?? ""
                    let releaseYear = film["release_year"] as? String  ?? ""
                    let title = film["title"] as? String  ?? ""
                    let movie = FilmEntry(firstActor: firstActor, locations: locations, releaseYear: releaseYear, title: title)
                    films.append(movie)
                }
              }
            } catch {
              print("Error deserializing JSON: \(error)")
            }
            
        }
        
    }


}

