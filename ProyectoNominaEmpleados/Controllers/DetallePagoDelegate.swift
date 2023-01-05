//
//  DetallePagoDelegate.swift
//  ProyectoNominaEmpleados
//
//  Created by MacBook on 05/01/23.
//

import Foundation
import CoreData

protocol DetallePagoDelegate {

    func salario(pagoSeleccionado pago: PagoEntity)
}
