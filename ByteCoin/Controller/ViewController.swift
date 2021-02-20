//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, CoinManagerDelegate {
    
    

    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    var coinManager = CoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        coinManager.delegate = self
    }
    
    //DataSource method
    //Determines the number of columns in pickerView
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //DataSource method
    //This method asks for how many rows the pickerView will have
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    
    //Delegate method
    //This method asks for the the title of each row in the pickerView, so it will be called (numberOfRowsInComponent) times
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    //Delegate method
    //Gets called every time the user scrolls the picker. Records the row number that was selected (when the scrolling stops)
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCurrency = (coinManager.currencyArray[row])
        coinManager.getCoinPrice(for: selectedCurrency)
    }
    
    func didCurrencyGetSelected(_ coinManager: CoinManager, rate: Double) {
        DispatchQueue.main.async {
            self.bitcoinLabel.text = String(format: "%.2f", rate)
            
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

