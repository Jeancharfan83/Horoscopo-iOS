//
//  DetailViewController.swift
//  Horoscopo
//
//  Created by Tardes on 13/12/24.
//

import UIKit

class DetailViewController: UIViewController {

    var horoscope: Horoscope? = nil
    
    
    @IBOutlet weak var detailTextView: UITextView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var datesLabel: UILabel!
    
    // Crear una instancia del NetworkManager
        private let networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.title = horoscope?.name
        iconImageView.image = horoscope?.icon
        datesLabel.text = horoscope?.dates
        
        // Llamar a la API para obtener el detalle
                fetchHoroscopeDetail()
    }
    
    // Función para llamar al NetworkManager y obtener el detalle del horóscopo
        func fetchHoroscopeDetail() {
            guard let horoscopeName = horoscope?.name else {
                print("No se encontró el nombre del horóscopo.")
                return
            }

            // Enviar el signo y el día (en este caso "TODAY" como ejemplo)
            let day = "TODAY" // O puedes poner una fecha específica si lo prefieres
            networkManager.fetchHoroscopeDetail(for: horoscopeName, onDay: day) { [weak self] result in
                switch result {
                case .success(let horoscopeDetail):
                    // Actualizar la UI en el hilo principal
                    DispatchQueue.main.async {
                        self?.detailTextView.text = horoscopeDetail.data.horoscope_data
                    }
                case .failure(let error):
                    // Manejar el error (por ejemplo, mostrar un mensaje en la UI)
                    DispatchQueue.main.async {
                        self?.detailTextView.text = "Error al cargar el detalle."
                        print("Error al obtener el detalle: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
