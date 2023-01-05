//
//  ViewControllerDelegate.swift
//  ProyectoNominaEmpleados
//
//  Created by MacBook on 05/01/23.
//

import Foundation

protocol ViewControllerDelegate {

    func empleado(empleadoLogin empleado: EmpleadoEntity)
    func empleado(empleadoLoginError message: String)
}
