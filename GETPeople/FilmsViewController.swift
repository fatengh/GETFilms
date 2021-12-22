//
//  FilmsViewController.swift
//  GETPeople
//
//  Created by admin on 22/12/2021.
//

import UIKit

class FilmsViewController: UITableViewController {
    var films = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "https://swapi.dev/api/films/?format=json")
             
        let task = URLSession.shared.dataTask(with: url!, completionHandler: {
            data, response, error in
            do{
                if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary{
                    if let res = jsonResult["results"] as? NSArray{
                        for result in res{
                            let filmsDic = result as! NSDictionary
                            self.films.append(filmsDic["title"]! as! String)
                        }
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                }
            }catch{
                print(error)
            }
        })
        task.resume()
        tableView.dataSource = self
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }

        
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return films.count
        }
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FilmsCell", for: indexPath)
            
            cell.textLabel?.text = films[indexPath.row]

            return cell
        }}
