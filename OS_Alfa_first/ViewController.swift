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
                let response,
                error == nil
            else{
                return
            }
         //   let decoder = JSONDecoder()
            // Обработка данных
            let str = String(data: data, encoding: .utf8)
            print("Полученные данные : \(str ?? "")")
        }).resume()
        // клажуры (лямбда функци, completionHandler) - сохранение функций в переменных и передача функции в качестве аргумента. Нужно для того, чтобы не тормозить код, который будет выполняься после отправки запроса на сервер. Он принимает 3 аргумента из самой системы, ничего не возвращает. // с 16 строки
    }
}

