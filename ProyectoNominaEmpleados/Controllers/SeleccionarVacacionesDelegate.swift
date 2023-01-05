//
//  SeleccionarVacacionesDelegate.swift
//  ProyectoNominaEmpleados
//
//  Created by MacBook on 05/01/23.
//

import Foundation

protocol SeleccionarVacacionesDelegate {

    func empleado(fechaSeleccionada fecha: Date, tipoFecha tipo: TipoFecha)
}
