//
//  ViewController.swift
//  ProyectoNominaEmpleados
//
//  Created by MacBook on 03/01/23.
//

import UIKit

class ViewController: UIViewController {

    
    
    @IBOutlet weak var usuarioTextField: UITextField!
    
    @IBOutlet weak var contraseñaTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NominaController.shared.viewControllerDelegate = self
    }

    @IBAction func loginActionButton(_ sender: Any) {
        
        guard let correo = usuarioTextField.text else { return }
        guard let contraseña = contraseñaTextField.text else { return }
        
        NominaController.shared.empleadoLogin(correo: correo, password: contraseña)
        
    }
    
}

extension ViewController: ViewControllerDelegate {
    func empleado(empleadoLogin empleado: EmpleadoEntity) {
        self.performSegue(withIdentifier: "GoCatalogoEmpleadosVC", sender: nil)
    }
    
    func empleado(empleadoLoginError message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "ok", style: .default))
        
        self.present(alert, animated: true)
    }
    
    
}

