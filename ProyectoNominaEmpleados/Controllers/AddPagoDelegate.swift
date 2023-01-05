//
//  AddPagoDelegate.swift
//  ProyectoNominaEmpleados
//
//  Created by MacBook on 05/01/23.
//

import Foundation

protocol AddPagoDelegate {

    func salario(salarioCreado salario: PagoEntity)
    func salario(salarioCreadoError message: String)
    func salario(fechaPago fecha: Date, tipoFech tipo: TipoFecha)
}
