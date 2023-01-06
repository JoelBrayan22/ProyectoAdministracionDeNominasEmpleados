//
//  CalendarioViewController.swift
//  ProyectoNominaEmpleados
//
//  Created by MacBook on 03/01/23.
//

import UIKit

class CalendarioViewController: UIViewController {

    
    @IBOutlet weak var calendarioDatePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    @IBAction func guardarDateCalendario(_ sender: Any) {
        
        let alert = UIAlertController(title: "Atención", message: "¿ Desea guardar la fecha ?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("Si", comment: "Default action"), style: .default, handler: { _ in
            NSLog("Saliendo ..."); self.navigationController?.popViewController(animated: true)
        }))
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("Cancelar", comment: "Default action"), style: .cancel, handler: { _ in
            NSLog("Quedarse")
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func cancelarAction(_ sender: Any) {
        
        let alert = UIAlertController(title: "Atención", message: "¿ Desea salir de la pantalla ?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("Si", comment: "Default action"), style: .default, handler: { _ in
            NSLog("Saliendo ..."); self.navigationController?.popViewController(animated: true)
        }))
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("Cancelar", comment: "Default action"), style: .cancel, handler: { _ in
            NSLog("Quedarse")
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    

}
