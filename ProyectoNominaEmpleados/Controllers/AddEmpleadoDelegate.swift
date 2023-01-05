//
//  AddEmpleadoDelegate.swift
//  ProyectoNominaEmpleados
//
//  Created by MacBook on 05/01/23.
//

import Foundation

protocol AddEmpleadoDelegate {

    func empleado(fechaContratado fecha: Date)
    func empleado(empleadoCreado empleado: EmpleadoEntity)
    func empleado(empleadoCreadoError message: String)
}
