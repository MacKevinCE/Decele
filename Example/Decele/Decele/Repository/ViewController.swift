//
//  ViewController.swift
//  Decele
//
//  Created by Hermes Mac Kevin Cabanillas Encarnación on 01/10/2023.
//  Copyright (c) 2023 Hermes Mac Kevin Cabanillas Encarnación. All rights reserved.
//

import Combine
import CoreDecele
import UIKit

class ViewController: UIViewController {
    var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        VersionRequest().resolve(receiveCompletion: { completion in
            switch completion {
            case .finished:
                print("Request completed successfully.")
            case let .failure(error):
                print("Request failed with error: \(error)")
            }
        }, receiveValue: { data in
            // Aquí puedes trabajar con los datos recibidos
            print("Received data: \(data)")
        }).store(in: &cancellables)

        LoginRequest().resolve(receiveCompletion: { completion in
            switch completion {
            case .finished:
                print("Request completed successfully.")
            case let .failure(error):
                print("Request failed with error: \(error)")
            }
        }, receiveValue: { data, message in
            // Aquí puedes trabajar con los datos recibidos
            print("Received data: \(data)")
            if let msg = message {
                print("Received message: \(msg)")
            }
        }).store(in: &cancellables)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
