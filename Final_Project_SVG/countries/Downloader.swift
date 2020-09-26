//
//  Downloader.swift
//  countries
//
//  Created by Rania Arbash on 2019-08-08.
//  Copyright © 2019 Rania Arbash. All rights reserved.
//

import Foundation


protocol DownloaderDelegate {
    
    func DownloaderDIdFinishtWIthCountries(allcountries : [Country])
    
}

class Downloader {
    
    var delegate : DownloaderDelegate?
    func getCountries()  {
        
        let urlString = "https://restcountries.eu/rest/v2/all"
        let urlObj = URL(string: urlString)
        let task = URLSession.shared.dataTask(with: urlObj!) { (data, respons, error) in
            
            if let myData = data {
                do {
              let allCountries = try  JSONDecoder().decode([Country].self, from: myData)
                  
                    DispatchQueue.main.async {
                    
                    if let  mydelegate = self.delegate {
                        mydelegate.DownloaderDIdFinishtWIthCountries(allcountries: allCountries)
                        
                    }
                    }
                }catch{
                    print(error)
                }
                    
            }
            
            
            
        }
        task.resume()
    }
    
}
