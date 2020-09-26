//
//  CountryDetailDisplayViewController.swift
//  countries
//
//  Created by user163874 on 4/16/20.
//  Copyright © 2020 Rania Arbash. All rights reserved.
//

import UIKit

class CountryDetailDisplayViewController: UIViewController {

    @IBOutlet weak var flagLogo: UIImageView!
   
            
    @IBOutlet weak var subReg: UILabel!
    
    @IBOutlet weak var area: UILabel!
    @IBOutlet weak var regionName: UILabel!
    @IBOutlet weak var capitalName: UILabel!
    @IBOutlet weak var countryName: UILabel!
            var dbManager : CoreDataManager?
            
            var country: CountryData!
    @IBOutlet weak var population: UILabel!
    
            override func viewDidLoad() {
                super.viewDidLoad()
                let uiImage: UIImage = UIImage(data: country.flagImage!)!
                flagLogo.image = uiImage
                countryName.text = country.name
                regionName.text = country.region
                capitalName.text = country.capital
                area.text = "\(country.area)"
                population.text = "\(country.population)"
                subReg.text = country.subRegion
                
          }
    }
    

