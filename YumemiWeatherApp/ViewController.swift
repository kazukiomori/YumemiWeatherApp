//
//  ViewController.swift
//  YumemiWeatherApp
//
//  Created by Kazuki Omori on 2022/07/10.
//

import UIKit
import YumemiWeather

public class ViewController: UIViewController, WeatherModel {

    @IBOutlet weak var weatherImageView: UIImageView!
    
    @IBOutlet weak var minTemperatureLabel: UILabel!
    @IBOutlet weak var maxTemperatureLabel: UILabel!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadWether), name: .notifyName, object: nil)
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
        reloadWether()
    }
    
    @objc func reloadWether() {
        let parameter = AreaAndDate(area: "tokyo", date: "2020-04-01T12:00:00+09:00")
        var stringJson = encodeToJson(parameter: parameter)
        var result: String
        do {
            try result = YumemiWeather.fetchWeather(stringJson)
            let jsonData = result.data(using: .utf8)
            if jsonData == nil {
                return
            }
            let jsonResult = try! JSONDecoder().decode(Result.self, from: jsonData!)

            switch jsonResult.weather_condition {
            case "sunny" :
                weatherImageView.image = #imageLiteral(resourceName: "iconmonstr-weather-1.pdf")
            case "cloudy" :
                weatherImageView.image = #imageLiteral(resourceName: "iconmonstr-weather-11.pdf")
            case "rainy":
                weatherImageView.image = #imageLiteral(resourceName: "iconmonstr-umbrella-1.pdf")
            default: break
            }
            
            DispatchQueue.main.async {
                self.minTemperatureLabel.text = String(jsonResult.min_temperature)
                self.maxTemperatureLabel.text = String(jsonResult.max_temperature)
            }
        } catch YumemiWeatherError.invalidParameterError {
            ViewController.showError(title: "不正なパラメータエラー", message: "パラメータが不正です。", self)
        } catch YumemiWeatherError.unknownError {
            ViewController.showError(title: "不明なエラー", message: "不明なエラーです。", self)
        } catch {
            ViewController.showError(title: "エラー", message: "エラーが発生しました。", self)
        }
    }
    
    func encodeToJson(parameter: AreaAndDate) -> String {
        var jsonString:String? = ""
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = [.prettyPrinted, .withoutEscapingSlashes]
            let jsonData = try encoder.encode(parameter)
            jsonString = String(data: jsonData, encoding: .utf8)
        } catch {
            print(error.localizedDescription)
        }
        return jsonString!
    }
}

extension Notification.Name {
    static let notifyName = Notification.Name("notifyName")
}
