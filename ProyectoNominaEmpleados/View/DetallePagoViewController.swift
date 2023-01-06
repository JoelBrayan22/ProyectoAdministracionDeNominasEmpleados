//
//  DetallePagoViewController.swift
//  ProyectoNominaEmpleados
//
//  Created by MacBook on 03/01/23.
//

import UIKit

class DetallePagoViewController: UIViewController {

    
    @IBOutlet weak var nombrePagoLabel: UILabel!
    
    @IBOutlet weak var fechaPagoLabel: UILabel!
    
    @IBOutlet weak var sueldoLabel: UILabel!
    
    @IBOutlet weak var viaticosLabel: UILabel!
    
    @IBOutlet weak var prestamoPagoLabel: UILabel!
    
    @IBOutlet weak var abonoPrestamoLabel: UILabel!
    
    @IBOutlet weak var cantidadAbonosLabel: UILabel!
    
    @IBOutlet weak var descripcionPrestamoLabel: UILabel!
    
    @IBOutlet weak var DeudaRestanteLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NominaController.shared.detallePagoDelegate = self
        
    }

    override func viewWillAppear(_ animated: Bool) {
        NominaController.shared.getPagoSeleccionado()
    }
    
}

extension DetallePagoViewController: DetallePagoDelegate {
    func salario(pagoSeleccionado pago: PagoEntity) {
        
        nombrePagoLabel.text = pago.nombreEmpleado
        
        if let fechaPago = pago.fechaPago {
            fechaPagoLabel.text = fechaPago.toString
        }
        
        sueldoLabel.text = pago.sueldo.toString
        viaticosLabel.text = pago.viaticos.toString
        prestamoPagoLabel.text = pago.prestamo.toString
        abonoPrestamoLabel.text = pago.numeroAbono.toString
        cantidadAbonosLabel.text = pago.cantidadRestantePrestamo.toString
        descripcionPrestamoLabel.text = pago.descripcionPrestamo
        DeudaRestanteLabel.text = pago.cantidadRestantePrestamo.toString
        
    }
    
    
}
