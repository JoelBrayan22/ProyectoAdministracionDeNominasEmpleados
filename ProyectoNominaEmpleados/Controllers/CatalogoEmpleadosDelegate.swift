//
//  CatalogoEmpleadosDelegate.swift
//  ProyectoNominaEmpleados
//
//  Created by MacBook on 05/01/23.
//

import Foundation

protocol CatalogoEmpleadosDelegate {

    func empleado(empleadosCargados empleados: [EmpleadoEntity])
    func empleado(empleadoCreado empleado: EmpleadoEntity)
    func empleado(empleadoCreadoError message: String)
    func empleado(empleadoSeleccionado empleado: EmpleadoEntity, index: Int)
}
