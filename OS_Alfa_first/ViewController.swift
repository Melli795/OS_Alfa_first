//
//  ViewController.swift
//  OS_Alfa_first
//
//  Created by Нелли Першина on 09.10.2023.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = . systemPink
        let url: URL = URL(string: "https://api.punkapi.com/v2/beers")! // принудительная распаковка используется только в тестах
        URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            guard 
                let data = data,
                error == nil
            else{
                return
            }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            // Обработка данных
            let model = try! decoder.decode([BeerDTO].self, from: data)
            print(model)
        }).resume()
//         клажуры (лямбда функци, completionHandler) - сохранение функций в переменных и передача функции в качестве аргумента. Нужно для того, чтобы не тормозить код, который будет выполняься после отправки запроса на сервер. Он принимает 3 аргумента из самой системы, ничего не возвращает. // с 16 строки
    }
}

struct BeerDTO: Decodable{
    let id: Int
    let name: String
    let tagline: String
    let imageUrl: URL
    // чекнуть информацию про кодинг кейс, что такое camel и snake case
    
}
