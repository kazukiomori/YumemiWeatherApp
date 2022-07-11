//
//  ViewController.swift
//  YumemiWeatherApp
//
//  Created by Kazuki Omori on 2022/07/10.
//

import UIKit
import YumemiWeather

class ViewController: UIViewController {

    @IBOutlet weak var weatherImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func closeBtnTapped(_ sender: UIButton) {
    }
    
    @IBAction func reloadBtnTapped(_ sender: UIButton) {
        var weather: String = YumemiWeather.fetchWeatherCondition()
        switch weather {
        case "sunny" :
            weatherImageView.image = #imageLiteral(resourceName: "iconmonstr-weather-1.pdf")
        case "cloudy" :
            weatherImageView.image = #imageLiteral(resourceName: "iconmonstr-weather-11.pdf")
        case "rainy":
            weatherImageView.image = #imageLiteral(resourceName: "iconmonstr-umbrella-1.pdf")
        default: break
        }
    }
}

