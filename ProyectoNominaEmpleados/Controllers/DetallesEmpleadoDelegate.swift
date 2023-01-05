//
//  DetallesEmpleadoDelegate.swift
//  ProyectoNominaEmpleados
//
//  Created by MacBook on 05/01/23.
//

import Foundation

protocol DetallesEmpleadoDelegate {

    func empleado(empleadoSeleccionado empleado: EmpleadoEntity)
    func empleado(vacacionesSeleccionadas vacaciones: Date, tipoFecha tipo: TipoFecha)
}
