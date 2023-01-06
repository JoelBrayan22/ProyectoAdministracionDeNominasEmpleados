//
//  SeleccionarVacacionesViewController.swift
//  ProyectoNominaEmpleados
//
//  Created by MacBook on 03/01/23.
//

import UIKit

class SeleccionarVacacionesViewController: UIViewController {
    
    @IBOutlet weak var fechaInicioVacacionesLabel: UILabel!
    
    @IBOutlet weak var fechaFinVacacionesLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        NominaController.shared.seleccionarVacacionesDelegate = self
    }
    
    @IBAction func aceptarFechasVacacionesActionButton(_ sender: Any) {
        
        let alert = UIAlertController(title: "Atención", message: "¿ Los datos son correctos ?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("Si", comment: "Default action"), style: .default, handler: { _ in
            NSLog("Saliendo ..."); self.navigationController?.popViewController(animated: true)
        }))
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("Cancelar", comment: "Default action"), style: .cancel, handler: { _ in
            NSLog("Quedarse")
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    @IBAction func inicioVacacionesAction(_ sender: Any) {
        
        NominaController.shared.seleccionarTipoFechaComoInicioVacaciones()
        
    }
    
    @IBAction func finVacacionesAction(_ sender: Any) {
        
        NominaController.shared.seleccionarTipoFechaComoFinVacaciones()
    }
    
    
}

extension SeleccionarVacacionesViewController: SeleccionarVacacionesDelegate {
    
    func empleado(fechaSeleccionada fecha: Date, tipoFecha tipo: TipoFecha) {
        
        //fechaFinVacacionesLabel.text = fecha
        
        //fechaFinVacacionesLabel.text = fecha
        
    }
}
