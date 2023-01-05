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
        
        if let empleado = self.model.empleadoLogIn(correo: correo, password: password) {
            self.viewControllerDelegate?.empleado(empleadoLogin: empleado)
        } else {
            self.viewControllerDelegate?.empleado(empleadoLoginError: "Error al iniciar sesión con \(correo)")
        }
        
    }
    
    // Obtener todos los empleados existentes
    func getEmpleados () {
        
        let empleados = self.model.getEmpleados()
        
        catalogoEmpleadosDelegate?.empleado(empleadosCargados: empleados)
        
    }
    
    // Crear un empleado nuevo en AddEmpleadoVC
    func addEmpleado(id: Int, nombre: String, area: String, departamento: String, puesto: String, fechaContratacion: Date, antiguedad: Int, salario: Double, fechaVacacionesInicio: Date, fechaVacacionesFin: Date, estaVacaciones: Bool, tienePrestamo: Bool) {
        
        if let empleado = self.model.addEmpleado(id: Int(Int32.random(in: 1...Int32.max)), nombre: nombre, area: area, departamento: departamento, puesto: puesto, fechaContratacion: fechaContratacion, salario: salario) {
            
            addEmpleadoDelegate?.empleado(empleadoCreado: empleado)
            catalogoEmpleadosDelegate?.empleado(empleadoCreado: empleado)
            
        }
        // TODO: como seleccionar la fechaContratacion
    }
    
    func seleccionarTipoFechaComoContratacion() {
        
        self.model.tipoFecha = .fechaContratacion
        
    }
    
    func seleccionarTipoFechaComoInicioVacaciones() {
        
        self.model.tipoFecha = .inicioVacaciones
        
    }
    
    func seleccionarTipoFechaComoFinVacaciones() {
        
        self.model.tipoFecha = .finVacaciones
        
    }
    
    func seleccionarTipoFechaComoFechaPago() {
        
        self.model.tipoFecha = .fechaPago
        
    }
    
    // Empleo seleccionado en CatalogoEmpleadosVC
    func seleccionarEmpleado(index: Int, empleado: EmpleadoEntity) {
        
        if let empleado = model.seleccionarEmpleado(index: index, empleado: empleado) {
            
            catalogoEmpleadosDelegate?.empleado(empleadoSeleccionado: empleado, index: index)
        }
    }
    
    // Empleado seleccionado que necesita DetallesEmpleadoVC para mostrarlo
    func getEmpleadoSeleccionado() {
        if let empleadoSeleccionado = self.model.empleadoSeleccionado {
            detallesEmpleadoDelegate?.empleado(empleadoSeleccionado: empleadoSeleccionado)
        }
    }
    
    // Obtener todo el historial de pagos del empleado
    func obtenerHistorialPagos() {
        
        historialNominaDelegate?.pago(historialPagos: self.model.pagos.filter({
            pago in
            pago.empleado == self.model.empleadoSeleccionado
        }))
        
    }
    
    // Selecciona una fecha
    func seleccionarFecha(fechaSeleccionada: Date) {
        switch self.model.tipoFecha {
        case .fechaContratacion:
            self.model.fechaContratacion = fechaSeleccionada
            self.addEmpleadoDelegate?.empleado(fechaContratado: fechaSeleccionada)
        case .inicioVacaciones:
            self.model.fechaInicioVacaciones = fechaSeleccionada
            self.seleccionarVacacionesDelegate?.empleado(fechaSeleccionada: fechaSeleccionada, tipoFecha: .inicioVacaciones)
        case .finVacaciones:
            self.model.fechaFinVacaciones = fechaSeleccionada
            self.seleccionarVacacionesDelegate?.empleado(fechaSeleccionada: fechaSeleccionada, tipoFecha: .inicioVacaciones)
        case .fechaPago:
            self.model.fechaPago = fechaSeleccionada
            self.addPagoDelegate?.salario(fechaPago: fechaSeleccionada, tipoFech: .fechaPago)
        default:
            print("Tipo de fecha no válido")
        }
    }

    
    // Selecciona un pago desde HistorialNominaVC
    func seleccionarPago(index: Int, pago: PagoEntity) {
        
        if let pago = model.seleccionarPago(index: index, pago: pago) {
            
            historialNominaDelegate?.pago(pagoSeleccionado: pago, index: index)
        }
        
    }
    
    // Pago seleccionado que necesita DetallePagoVC
    func getPagoSeleccionado() {
        if let pagoSeleccionado = self.model.pagoSeleccionado {
            detallePagoDelegate?.salario(pagoSeleccionado: pagoSeleccionado)
        }
    }

    // Generar un nuevo pago
    func agregarPago(fechaPago: Date, sueldo: Double, viaticos: Double?, prestamo: Double?, descripcionPrestamo: String?, cantidadRestantePrestamo: Double?, numeroAbono: Int?) {
        
        if let pago = self.model.agregarPago(nombreEmpleado: self.model.empleadoSeleccionado?.nombre ?? "DESCONOCIDO", fechaPago: fechaPago, sueldo: sueldo, viaticos: viaticos, prestamo: prestamo, descripcionPrestamo: descripcionPrestamo, cantidadRestantePrestamo: cantidadRestantePrestamo, numeroAbono: numeroAbono) {
            
            addPagoDelegate?.salario(salarioCreado: pago)
            
        } else {
            addPagoDelegate?.salario(salarioCreadoError: "No se pudo crear el pago.")
        }
    }
}

