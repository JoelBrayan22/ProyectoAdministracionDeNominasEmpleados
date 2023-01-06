//
//  DetallesEmpleadoViewController.swift
//  ProyectoNominaEmpleados
//
//  Created by MacBook on 03/01/23.
//

import UIKit

class DetallesEmpleadoViewController: UIViewController {

    @IBOutlet weak var empleadoImageView: UIImageView!
    
    @IBOutlet weak var nombreEmpleadoLabel: UILabel!
    
    @IBOutlet weak var idEmpleadoLabel: UILabel!
    
    @IBOutlet weak var empleadoVacacionesLabel: UILabel!
    
    @IBOutlet weak var areaEmpleadoLabel: UILabel!
    
    @IBOutlet weak var departamentoEmpleadoLabel: UILabel!
    
    @IBOutlet weak var prestamoEmpleadoLabel: UILabel!
    
    @IBOutlet weak var antiguedadEmpleadoLabel: UILabel!
    
    @IBOutlet weak var salarioEmpleadoLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        empleadoImageView.layer.cornerRadius = empleadoImageView.bounds.size.width / 2.0
        
        // Creamos un formatter para representar datos tipo Date en forma de String
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        
        // Desengrapamos la variable tienePrestamos del empleado seleccionamos
        var tienePrestamo: Bool
        
        if let unwrapTienePrestamo = NominaController.shared.model.empleadoSeleccionado?.tienePrestamo {
            
            tienePrestamo = unwrapTienePrestamo
        } else {
            
            tienePrestamo = false
        }
        
        // Actualiza la Vista con los datos que recibimos del empleado seleccionado (Controller)
        nombreEmpleadoLabel.text = NominaController.shared.model.empleadoSeleccionado?.nombre
        
        idEmpleadoLabel.text = String(Int(NominaController.shared.model.empleadoSeleccionado?.id ?? 0))
        
        empleadoVacacionesLabel.text = "\(formatter.string(from: NominaController.shared.model.empleadoSeleccionado?.fechaVacacionesInicio ?? Date.now)) - \(formatter.string(from: NominaController.shared.model.empleadoSeleccionado?.fechaVacacionesFin ?? Date.now))"
        
        areaEmpleadoLabel.text = NominaController.shared.model.empleadoSeleccionado?.area
        
        departamentoEmpleadoLabel.text = NominaController.shared.model.empleadoSeleccionado?.departamento
        
        if tienePrestamo {
            
            prestamoEmpleadoLabel.text = "Sí"
        } else {
            
            prestamoEmpleadoLabel.text = "No"
        }
        antiguedadEmpleadoLabel.text = String(Int(NominaController.shared.model.empleadoSeleccionado?.antiguedad ?? 0))
        
        salarioEmpleadoLabel.text = String(NominaController.shared.model.empleadoSeleccionado?.salario ?? 0.0)
        
    }
    
    @IBAction func vacacionesEmpleadoActionButton(_ sender: Any) {
    }
    
    @IBAction func generarPagoEmpleadoActionButton(_ sender: Any) {
    }
    
    @IBAction func nominaEmpleadoActionButton(_ sender: Any) {
    }
    

}
