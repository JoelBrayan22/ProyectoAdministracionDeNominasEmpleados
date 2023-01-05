//
//  NominaController.swift
//  ProyectoNominaEmpleados
//
//  Created by MacBook on 05/01/23.
//

import Foundation

enum TipoFecha {
        case inicioVacaciones
        case finVacaciones
        case fechaContratacion
        case fechaPago
    }

class NominaController {
    
    // Singleton
    static let shared = NominaController()
    
    // Instancia a NominaModel
    let model = NominaModel()
    
    // Delegados para hacer notificaciones a las vistas
    var viewControllerDelegate: ViewControllerDelegate?
    var catalogoEmpleadosDelegate: CatalogoEmpleadosDelegate?
    var addEmpleadoDelegate: AddEmpleadoDelegate?
    var calendarioDelegate: CalendarioDelegate?
    var detallesEmpleadoDelegate: DetallesEmpleadoDelegate?
    var seleccionarVacacionesDelegate: SeleccionarVacacionesDelegate?
    var historialNominaDelegate: HistorialNominaDelegate?
    var detallePagoDelegate: DetallePagoDelegate?
    var addPagoDelegate: AddPagoDelegate?
    
    // Funciones
    func empleadoLogin(correo: String, password: String) {
        
    }
    
    // Obtener todos los empleados existentes
    func getEmpleados () {
        
        self.model.getEmpleados()
        catalogoEmpleadosDelegate?.empleado(empleadosCargados: self.model.empleados)
        
    }
    
    // Crear un empleado nuevo en AddEmpleadoVC
    func addEmpleado(id: Int, nombre: String, area: String, departamento: String, puesto: String, fechaContratacion: Date, antiguedad: Int, salario: Double, fechaVacacionesInicio: Date, fechaVacacionesFin: Date, estaVacaciones: Bool, tienePrestamo: Bool) {
        
        if let empleado = self.model.addEmpleado(nombre: nombre, area: area, departamento: departamento, puesto: puesto, salario: salario, fechaContratacion: fechaContratacion) {
            
            addEmpleadoDelegate?.empleado(empleadoCreado: empleado)
            catalogoEmpleadosDelegate?.empleado(empleadoCreado: empleado)
            
        }
    }
    
    func seleccionarFechaContratacion() {
        
        if let fecha = model.fechaSeleccionada {
            addEmpleadoDelegate?.empleado(fechaContratado: fecha)
        }
        
    }
    
    // Empleo seleccionado en CatalogoEmpleadosVC
    func seleccionarEmpleado(index: Int, empleado: EmpleadoEntity) {
        if let empleado = model.seleccionarEmpleado(index: index, empleado: empleado) {
            catalogoEmpleadosDelegate?.empleado(empleadoSeleccionado: empleado, index: index)
        }
        
    }
    
    // Empleado seleccionado que necesita DetallesEmpleadoVC para mostrarlo
    func getEmpleadoSeleccionado() {
        detallesEmpleadoDelegate?.empleado(empleadoSeleccionado: model.empleadoSeleccionado)
    }
    
    func obtenerHistorialPagos() {
        historialNominaDelegate?.salario(historialSalario: <#T##<<error type>>#>)
    }
    
    // Selecciona una fecha
    func seleccionarFecha(fechaSeleccionada: Date, tipoFecha: TipoFecha) {
        
    }

    

    func seleccionarPago(index: Int) {
        
    }

    func agregarPago(nombreEmpleado: String, fechaPago: Date, sueldo: Double, viaticos: Double?, prestamo: Double?, descripcionPrestamo: String?, cantidadRestantePrestamo: Double?, numeroAbono: Int?) {
        
    }
}
