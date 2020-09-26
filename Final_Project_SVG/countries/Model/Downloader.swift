//
//  Downloader.swift
//  countries
//
//  Created by user163874 on 4/16/20.
//  Copyright © 2020 Rania Arbash. All rights reserved.
//

import Foundation

class Downloader
{
    
    func download(complition: @escaping ([Country])->Void)  {
        
    let url = URL(string: "https://restcountries.eu/rest/v2/all")!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                    
                    return
            }
            if let mimeType = httpResponse.mimeType,
                let data = data
            {
                
                do {
                    print(data)
                    let decoder = JSONDecoder()
                    let countryList = try  decoder.decode([Country].self, from: data)
                    complition(countryList)
                }catch{
                    
                }
                
            }
        }
        task.resume()
       //return data from datatask function
        
    }
}
