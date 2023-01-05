//
//  CalendarioDelegate.swift
//  ProyectoNominaEmpleados
//
//  Created by MacBook on 05/01/23.
//

import Foundation

protocol CalendarioDelegate {

    func empleado(fechaSeleccionada fecha: Date)
    func empleado(fechaSeleccionadaError message: String)
}
