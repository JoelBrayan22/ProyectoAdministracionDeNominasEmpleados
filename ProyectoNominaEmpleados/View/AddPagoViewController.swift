//
//  AddPagoViewController.swift
//  ProyectoNominaEmpleados
//
//  Created by MacBook on 03/01/23.
//

import UIKit

class AddPagoViewController: UIViewController {

    
    @IBOutlet weak var nombrePagoTextField: UITextField!
    
    @IBOutlet weak var sueldoPagoTextField: UITextField!
    
    @IBOutlet weak var viaticosPagoTextField: UITextField!
    
    @IBOutlet weak var prestamoPagoTextField: UITextField!
    
    @IBOutlet weak var abonoPrestamoTextField: UITextField!
    
    @IBOutlet weak var NumeroAbonoTextField: UITextField!
    
    @IBOutlet weak var descripcionPrestamoTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    
    @IBAction func generarPagoActionButton(_ sender: Any) {
        
        let alert = UIAlertController(title: "Atención", message: "¿ Los datos del pago son correctos ?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("Si", comment: "Default action"), style: .default, handler: { _ in
            NSLog("Saliendo ..."); self.navigationController?.popViewController(animated: true)
        }))
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("Cancelar", comment: "Default action"), style: .cancel, handler: { _ in
            NSLog("Quedarse")
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func cancelarPagoActionButton(_ sender: Any) {
        
        let alert = UIAlertController(title: "Atención", message: "¿ Desea cancelar el pago ?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("Si", comment: "Default action"), style: .default, handler: { _ in
            NSLog("Saliendo ..."); self.navigationController?.popViewController(animated: true)
        }))
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("Cancelar", comment: "Default action"), style: .cancel, handler: { _ in
            NSLog("Quedarse")
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    

}
