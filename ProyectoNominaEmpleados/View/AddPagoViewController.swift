//
//  AddPagoViewController.swift
//  ProyectoNominaEmpleados
//
//  Created by MacBook on 03/01/23.
//

import UIKit

class AddPagoViewController: UIViewController {

    @IBOutlet weak var sueldoPagoTextField: UITextField!
    
    @IBOutlet weak var viaticosPagoTextField: UITextField!
    
    @IBOutlet weak var prestamoPagoTextField: UITextField!
    
    @IBOutlet weak var abonoPrestamoTextField: UITextField!
    
    @IBOutlet weak var NumeroAbonoTextField: UITextField!
    
    @IBOutlet weak var descripcionPrestamoTextField: UITextField!
    
    
    @IBAction func fechaPagoAction(_ sender: Any) {
        NominaController.shared.seleccionarTipoFechaComoFechaPago()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NominaController.shared.addPagoDelegate = self
    }
    
    
    @IBAction func generarPagoActionButton(_ sender: Any) {
        
        let alert = UIAlertController(title: "Atención", message: "¿ Los datos del pago son correctos ?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("Si", comment: "Default action"), style: .default, handler: { _ in
            
            guard let sueldo = self.sueldoPagoTextField.text else {
                return
            }
            
            guard let viaticos = self.viaticosPagoTextField.text else {
                return
            }
            
            guard let prestamo = self.prestamoPagoTextField.text else {
                return
            }
            
            guard let abono = self.abonoPrestamoTextField.text else {
                return
            }
            
            guard let numeroAbono = self.NumeroAbonoTextField.text else {
                return
            }
            
            guard let descripcionPrestamo = self.descripcionPrestamoTextField.text else {
                return
            }
            NominaController.shared.agregarPago(fechaPago: Date.now, sueldo: Double(sueldo) ?? 0.0, viaticos: Double(viaticos) ?? 0.0, prestamo: Double(prestamo) ?? 0.0, descripcionPrestamo: descripcionPrestamo, cantidadRestantePrestamo: Double(abono), numeroAbono: Int(numeroAbono) ?? 0)
            
            self.navigationController?.popViewController(animated: true)
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

extension AddPagoViewController: AddPagoDelegate {
    
    func salario(salarioCreado salario: PagoEntity) {
        print("Salario creado Correctamente \(salario) ")
        self.navigationController?.popViewController(animated: true)
    }
    
    func salario(salarioCreadoError message: String) {
        print("Error")
    }
    
    func salario(fechaPago fecha: Date, tipoFech tipo: TipoFecha) {
        
    }
    
    
}
