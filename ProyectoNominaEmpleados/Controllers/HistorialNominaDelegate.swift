//
//  HistorialNominaDelegate.swift
//  ProyectoNominaEmpleados
//
//  Created by MacBook on 05/01/23.
//

import Foundation

protocol HistorialNominaDelegate {

    func pago(historialPagos historial: [PagoEntity])
    
    func pago(pagoSeleccionado: PagoEntity, index: Int)
}
