//
//  ViewController.swift
//  App Noticias
//
//  Created by Rogério Júnior on 18/01/23.
//

import UIKit

class ViewController: UITableViewController {
    
    var news: [ResultNews] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadNews()
    }
    
    func loadNews(){
        let fileUrl = Bundle.main.url(forResource: "file", withExtension: "json")!
        let jsonData = try! Data(contentsOf: fileUrl)
        
        do {
            let data = try JSONDecoder().decode(ResponseNews.self, from: jsonData)

              news = data.results
        }catch{
            print("Error => \(error.localizedDescription)")

        }
    }
    
     override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         print("count => \(news.count)")
         return news.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt
                            indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NewYorkTableViewCell
        
        let newsData = news[indexPath.row]
        cell.prepare(with: newsData)
        
        return cell
    }
        
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let url = URL(string: news[indexPath.row].url) {
            UIApplication.shared.open(url)
        }
    }
}
