//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
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
}

//MARK: - Picker View Data Source

extension ViewController: UIPickerViewDataSource {
    //Determines the number of columns in pickerView
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //This method asks for how many rows the pickerView will have
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
}

//MARK: - Picker View Delegate

extension ViewController: UIPickerViewDelegate {
    //This method sets the title for each row in the pickerView, so it will be called (numberOfRowsInComponent) times
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    //Gets called every time the user scrolls through the picker. Records the row number that was selected (when the scrolling stops)
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCurrency = (coinManager.currencyArray[row])
        coinManager.getCoinPrice(for: selectedCurrency)
    }
}

//MARK: - Coin Data Delegate

extension ViewController: CoinManagerDelegate {
    func didCurrencyGetSelected(rate: String, currency: String) {
        DispatchQueue.main.async {
            self.bitcoinLabel.text = rate
            self.currencyLabel.text = currency
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}


