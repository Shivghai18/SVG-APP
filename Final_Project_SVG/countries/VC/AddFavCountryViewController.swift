//
//  AddFavCountryViewController.swift
//  countries
//
//  Created by user163874 on 4/16/20.
//  Copyright © 2020 Rania Arbash. All rights reserved.
//

import UIKit
import SVGKit
import CoreData

class AddFavCountryViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    var downloader = Downloader()
    var countryArray :[Country]?
    
        
    var CDManager : CoreDataManager?
    
    var flagUrl : String = ""
    var countryName: String = ""
    var selectedRow: Int?
    	
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var flagImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        downloader.download { (fetchedList) in
              DispatchQueue.main.async {
                  self.countryArray = fetchedList
                debugPrint(fetchedList)
                  self.pickerView.reloadAllComponents()
        
                  
              }
        }
        
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
    }
    @IBAction func saveCountry(_ sender: Any) {
    
        let alert = UIAlertController(title: "Add New Country", message: "Save \(countryName) details in DB?", preferredStyle: .alert)
        
        let action = UIAlertAction.init(title: "Save", style: .default){
            (action) in
            
            self.CDManager!.addNewCountry(country: self.countryArray![self.selectedRow!])
            _ = self.navigationController?.popToRootViewController(animated: true)
            
        }
        
        alert.addAction(action)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countryArray?.count ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(countryArray![row].name ?? "name"), \(countryArray![row].region ??  "region")"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedRow = row
        downloadFlagImage(flagURL: countryArray![row].flag!)
        
        countryName = countryArray![row].name!
        
    }
    
    func downloadFlagImage (flagURL: String){
        
        let queue = DispatchQueue(label: "queue")
        queue.sync {
            let flagURLObj = URL(string: flagURL)
            let mySVGImage = SVGKImage.init(contentsOf:flagURLObj)
            DispatchQueue.main.async {
                self.flagImage.image = mySVGImage?.uiImage
                self.countryArray?[self.selectedRow!].flagImage = self.flagImage.image?.pngData()
                
            }
        }
       
               
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
