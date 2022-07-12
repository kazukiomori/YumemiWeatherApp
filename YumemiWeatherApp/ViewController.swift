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
    
    static func showError (title: String, message: String, _ viewController: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default) { (action) in
                    alert.dismiss(animated: true, completion: nil)
                }
        alert.addAction(action)
        viewController.present(alert, animated: true, completion: nil)
    }

    @IBAction func closeBtnTapped(_ sender: UIButton) {
    }
    
    @IBAction func reloadBtnTapped(_ sender: UIButton) {
        var weather: String
        do {
            try weather = YumemiWeather.fetchWeatherCondition(at:"tokyo")
            switch weather {
            case "sunny" :
                weatherImageView.image = #imageLiteral(resourceName: "iconmonstr-weather-1.pdf")
            case "cloudy" :
                weatherImageView.image = #imageLiteral(resourceName: "iconmonstr-weather-11.pdf")
            case "rainy":
                weatherImageView.image = #imageLiteral(resourceName: "iconmonstr-umbrella-1.pdf")
            default: break
            }
        } catch YumemiWeatherError.invalidParameterError {
            ViewController.showError(title: "不正なパラメータエラー", message: "パラメータが不正です。", self)
        } catch YumemiWeatherError.unknownError {
            ViewController.showError(title: "不明なエラー", message: "不明なエラーです。", self)
        }
    }
}

