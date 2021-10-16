//
//  ViewController.swift
//  UserDefaultSettings
//
//  Created by Илья Новиков on 15.10.2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var someImage: UIImageView!
    @IBOutlet weak var outletSwitch: UISwitch!
    var userDeafaultsSettings = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSavedData()
    }
    
//    enum defaultsKey {
//        case image
//        case outletSwitch
//        case mainTheme
//    }
    
    @IBAction func changeMainThemeAndPic(_ sender: UISwitch) {
        if sender.isOn {
            userDeafaultsSettings.set(sender.isOn, forKey: "outletSwitch")
            someImage.image = UIImage(named: "darkMain")
            guard let dataImage = UIImage(named: "darkMain")?.jpegData(compressionQuality: 0.5) else { return }
            let encoded = try! PropertyListEncoder().encode(dataImage)
            userDeafaultsSettings.set(encoded, forKey: "Image")
            view.backgroundColor = .darkGray
//            let color = view.backgroundColor
        } else {
            userDeafaultsSettings.set(sender.isOn, forKey: "outletSwitch")
            someImage.image = UIImage(named: "lightMain")
            guard let data = UIImage(named: "lightMain")?.jpegData(compressionQuality: 0.5) else { return }
            let encoded = try! PropertyListEncoder().encode(data)
            view.backgroundColor = .white
            userDeafaultsSettings.set(encoded, forKey: "Image")
        }
    }
    
    func loadSavedData() {
        let trueOrFalseSwitch = userDeafaultsSettings.bool(forKey: "outletSwitch")
        outletSwitch.isOn = trueOrFalseSwitch
        guard let dataImage = userDeafaultsSettings.data(forKey: "Image") else { return }
        let decoded = try! PropertyListDecoder().decode(Data.self, from: dataImage)
        let image = UIImage(data: decoded)
        someImage.image = image
    }
}

