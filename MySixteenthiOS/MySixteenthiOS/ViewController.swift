import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cityNameTextField: UITextField!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var weatherStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func searchWeatherBTN(_ sender: UIButton) {
        if let cityName = cityNameTextField.text {
            getCurrentWeahter(cityName: cityName)
            view.endEditing(true)
        }
    }
    
    func configureView(weatherInformation: WeatherInformation) {
        cityNameLabel.text = weatherInformation.name
        if let weahter = weatherInformation.weather.first {
            weatherDescriptionLabel.text = weahter.description
        }
        tempLabel.text = "\(Int(weatherInformation.temp.temp - 273.15))°C"
        maxTempLabel.text = "MAX: \(Int(weatherInformation.temp.maxTemp - 273.15))°C"
        minTempLabel.text = "MIN: \(Int(weatherInformation.temp.minTemp - 273.15))°C"
    }
    
    func showAlert(msg: String) {
        let alert = UIAlertController(title: "Error", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func getCurrentWeahter(cityName: String) {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q={city name}&appid={API key}") else { return }
        let session = URLSession(configuration: .default)
        session.dataTask(with: url) { [weak self] data, response, error in
            let successRange = (200..<300)
            guard let data = data, error == nil else { return }
            let decoder = JSONDecoder()
            if let response = response as? HTTPURLResponse, successRange.contains(response.statusCode) {
                guard let weatherInformation = try? decoder.decode(WeatherInformation.self, from: data) else { return }
                DispatchQueue.main.async {
                    self?.weatherStackView.isHidden = false
                    self?.configureView(weatherInformation: weatherInformation)
                }
            } else {
                guard let errorMsg = try? decoder.decode(ErrorMsg.self, from: data) else { return }
                DispatchQueue.main.async {
                    self?.showAlert(msg: errorMsg.message)
                }
            }
        }.resume()
    }
}

