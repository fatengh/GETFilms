//
//  ViewController.swift
//  GETPeople
//
//  Created by admin on 22/12/2021.
//

import UIKit


class ViewController: UITableViewController {
    
var pepole = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
             
        let url = URL(string: "https://swapi.dev/api/people/?format=json")

               let task = URLSession.shared.dataTask(with: url!, completionHandler: {
                   data, response, error in
                   do{
                       if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary{
                           if let res = jsonResult["results"] as? NSArray{
                               for result in res{
                                   let personDic = result as! NSDictionary
                                   self.pepole.append(personDic["name"]! as! String)
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
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pepole.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = pepole[indexPath.row]
        return cell
    }
}

