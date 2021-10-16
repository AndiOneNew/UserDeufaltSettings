//
//  ViewController.swift
//  UserDefaultSettings
//
//  Created by Илья Новиков on 15.10.2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var currentView: UIView!
    @IBOutlet weak var someImage: UIImageView!
    @IBOutlet weak var outletSwitch: UISwitch!
    var userDeafaultsSettings = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        someImage.image = UIImage(named: "lightMain")
        currentView.backgroundColor = UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1)
        loadSavedData()
    }
    
    enum defaultsKey {
        static let image = "image"
        static let outletSwitch = "trueOrFalseSwitch"
        static let mainTheme = "backgroundColor"
        static let red = "red"
        static let green = "green"
        static let blue = "blue"
    }
    
    func saveData(encoded: Data, sender: Bool, colorRed: Double, colorGreen: Double, colorBlue: Double) {
        userDeafaultsSettings.set(encoded, forKey: defaultsKey.image)
        userDeafaultsSettings.set(outletSwitch.isOn, forKey: defaultsKey.outletSwitch)
        userDeafaultsSettings.set(colorRed, forKey: defaultsKey.red)
        userDeafaultsSettings.set(colorGreen, forKey: defaultsKey.green)
        userDeafaultsSettings.set(colorBlue, forKey: defaultsKey.blue)
    }
    
    @IBAction func changeMainThemeAndPic(_ sender: UISwitch) {
        if sender.isOn {
            someImage.image = UIImage(named: "darkMain")
            currentView.backgroundColor = UIColor(red: 60/255.0, green: 60/255.0, blue: 155/255.0, alpha: 1)
            guard let dataImage = UIImage(named: "darkMain")?.jpegData(compressionQuality: 0.5) else { return }
            let encoded = try! PropertyListEncoder().encode(dataImage)
            saveData(encoded: encoded, sender: sender.isOn, colorRed: 60/255.0, colorGreen: 60/255.0, colorBlue: 155/255.0 )
        } else {
            someImage.image = UIImage(named: "lightMain")
            currentView.backgroundColor = UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1)
            guard let dataImage = UIImage(named: "lightMain")?.jpegData(compressionQuality: 0.5) else { return }
            let encoded = try! PropertyListEncoder().encode(dataImage)
            saveData(encoded: encoded, sender: sender.isOn, colorRed: 255/255.0, colorGreen: 255/255.0, colorBlue: 255/255.0 )
        }
    }
    
    func loadSavedData() {
        guard let dataImage = userDeafaultsSettings.data(forKey: defaultsKey.image) else { return }
        let decoded = try! PropertyListDecoder().decode(Data.self, from: dataImage)
        let image = UIImage(data: decoded)
        someImage.image = image
        outletSwitch.isOn = userDeafaultsSettings.bool(forKey: defaultsKey.outletSwitch)
        currentView.backgroundColor = UIColor(red: userDeafaultsSettings.double(forKey: "red"), green: userDeafaultsSettings.double(forKey: "green"), blue: userDeafaultsSettings.double(forKey: "blue"), alpha: 1)
    }
}

