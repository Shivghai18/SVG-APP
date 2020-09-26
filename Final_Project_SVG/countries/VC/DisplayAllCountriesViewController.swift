//
//  DisplayAllCountriesViewController.swift
//  countries
//
//  Created by user163874 on 4/16/20.
//  Copyright © 2020 Rania Arbash. All rights reserved.
//

import UIKit
import CoreData

class DisplayAllCountriesViewController: UITableViewController {

    var CDManager = CoreDataManager()
    var countryRef = NSFetchedResultsController<CountryData>()
    override func viewDidLoad() {
        super.viewDidLoad()

       	 countryRef = CDManager.createFetchedResultsControllerForEntityNamed("CountryData", withPredicateFormat: nil, predicateObject: nil, sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)], andSectionNameKeyPath: nil)
        countryRef.delegate = self;
        do {
            try countryRef.performFetch()
        } catch let error {
            print(error.localizedDescription)
        }

    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return (countryRef.sections?.count)!
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return countryRef.sections?[section].numberOfObjects ?? 0
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.countryName.text = countryRef.object(at: indexPath).name
        cell.countrySubRegion.text = countryRef.object(at: indexPath).subRegion
        let uiImage: UIImage = UIImage(data: countryRef.object(at: indexPath).flagImage!)!
        cell.countryLogo.image = uiImage
        return cell

    }
    
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Add" {
            let AddCountry = segue.destination as! AddFavCountryViewController
            AddCountry.CDManager = CDManager
        }else {
            let CountryDetails = segue.destination as! CountryDetailDisplayViewController
            CountryDetails.country = countryRef.object(at: tableView!.indexPathForSelectedRow!)
            CountryDetails.title = "\(countryRef.object(at: tableView!.indexPathForSelectedRow!).name ?? "")'s details"

        }
    }

}
