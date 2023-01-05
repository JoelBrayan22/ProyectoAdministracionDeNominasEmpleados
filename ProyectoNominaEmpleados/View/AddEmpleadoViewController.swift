//
//  AddEmpleadoViewController.swift
//  ProyectoNominaEmpleados
//
//  Created by MacBook on 03/01/23.
//

import UIKit

class AddEmpleadoViewController: UIViewController {

    
    @IBOutlet weak var imagenPerfilEmpleado: UIImageView!
    
    @IBOutlet weak var nombreTextField: UITextField!
    
    @IBOutlet weak var idTextField: UITextField!
    
    @IBOutlet weak var areaTextField: UITextField!
    
    @IBOutlet weak var departamentoTextField: UITextField!
    
    @IBOutlet weak var puestoTextField: UITextField!
    
    @IBOutlet weak var salarioTextField: UITextField!
    
    @IBAction func addFechaContratacionActionButton(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagenPerfilEmpleado.layer.cornerRadius = imagenPerfilEmpleado.bounds.size.width / 2.0
        
    }
    
    @IBAction func guardarActionButton(_ sender: Any) {
        let alert = UIAlertController(title: "Atención", message: "¿ Desea guardar al empleado ?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("Empleado Guardado")
        }))
        self.present(alert, animated: true, completion: nil)
    }
        
    @IBAction func cancelarActionButton(_ sender: Any) {
        
    }
    
}
