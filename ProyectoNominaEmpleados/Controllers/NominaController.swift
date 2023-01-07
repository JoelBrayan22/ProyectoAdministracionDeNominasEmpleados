//
//  NominaController.swift
//  ProyectoNominaEmpleados
//
//  Created by MacBook on 05/01/23.
//

import Foundation


// Enum que brinda la ayuda para elegir el tipo de fecha que seleccionamos
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
    
    // MARK: Delegados para hacer notificaciones a las vistas
    
    var viewControllerDelegate: ViewControllerDelegate?
    var catalogoEmpleadosDelegate: CatalogoEmpleadosDelegate?
    var addEmpleadoDelegate: AddEmpleadoDelegate?
    var calendarioDelegate: CalendarioDelegate?
    var detallesEmpleadoDelegate: DetallesEmpleadoDelegate?
    var seleccionarVacacionesDelegate: SeleccionarVacacionesDelegate?
    var historialNominaDelegate: HistorialNominaDelegate?
    var detallePagoDelegate: DetallePagoDelegate?
    var addPagoDelegate: AddPagoDelegate?
    
    // MARK: Funciones
    
    // Loguea un empleado
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
    func addEmpleado(id: Int, nombre: String, area: String, departamento: String, puesto: String, fechaContratacion: Date, salario: Double) {
        
        //print("Agregando empleado \(id) \(nombre)")
        
        if let empleado = self.model.addEmpleado(id: Int(Int32.random(in: 1...Int32.max)), nombre: nombre, area: area, departamento: departamento, puesto: puesto, fechaContratacion: fechaContratacion, salario: salario) {
            
            addEmpleadoDelegate?.empleado(empleadoCreado: empleado)
            catalogoEmpleadosDelegate?.empleado(empleadoCreado: empleado)
            
        }
    }
    
    // Selecciona el tipo de fecha de contratacion.
    func seleccionarTipoFechaComoContratacion() {
        
        self.model.tipoFecha = .fechaContratacion
        
    }
    
    // Selecciona el tipo de fecha de inicio de vacaciones
    func seleccionarTipoFechaComoInicioVacaciones() {
        
        self.model.tipoFecha = .inicioVacaciones
        
    }
    
    // Selecciona el tipo de fecha de fin de vacacciones
    func seleccionarTipoFechaComoFinVacaciones() {
        
        self.model.tipoFecha = .finVacaciones
        
    }
    
    // Selecciona el tipo de fecha de pago.
    func seleccionarTipoFechaComoFechaPago() {
        
        self.model.tipoFecha = .fechaPago
        
    }
    
    func guardarFechasEmpleadoSeleccionado() {
        self.model.guardarEmpleadoSeleccionado()
    }
    
    func updateEmpleado(fecha: Date) {
        
        if let empleadoSelected = self.model.empleadoSeleccionado {
            
            if let empleado = self.model.addFechaContratacion(fecha: fecha) {
                
                catalogoEmpleadosDelegate?.empleado(empleadosCargados: self.model.empleados)
                detallesEmpleadoDelegate?.empleado(empleadoSeleccionado: empleado)
            }
        }
    }
    
    func addFechaInicioVacaciones(fecha: Date) {
        
        if let empleadoSelected = self.model.empleadoSeleccionado {
            
            if let empleado = self.model.addFechaInicioVacaciones(fecha: fecha) {
                
                catalogoEmpleadosDelegate?.empleado(empleadosCargados: self.model.empleados)
                detallesEmpleadoDelegate?.empleado(empleadoSeleccionado: empleado)
            }
        }
    }
    
    func addFechaFinVacaciones(fecha: Date) {
        
        if let empleadoSelected = self.model.empleadoSeleccionado {
            
            if let empleado = self.model.addFechaFinVacaciones(fecha: fecha) {
                
                catalogoEmpleadosDelegate?.empleado(empleadosCargados: self.model.empleados)
                detallesEmpleadoDelegate?.empleado(empleadoSeleccionado: empleado)
            }
        }
    }
    
    func addFechaPago(fecha: Date) {
        
        if let empleadoSelected = self.model.empleadoSeleccionado {
            
            if let _ = self.model.addFechaFinVacaciones(fecha: fecha) {
                
                catalogoEmpleadosDelegate?.empleado(empleadosCargados: self.model.empleados)
                detallesEmpleadoDelegate?.empleado(empleadoSeleccionado: empleadoSelected)
            }
        }
    }
    
    // Empleado seleccionado en CatalogoEmpleadosVC
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
    
    func getEmpleadoSeleccionadoFechasVacaciones() {
        print("OBTENIENDO FECHAS VACACIONES")
        if let empleadoSeleccionado = self.model.empleadoSeleccionado {
            print(empleadoSeleccionado)
            if let fechaVacacionesInicio = empleadoSeleccionado.fechaVacacionesInicio {
                seleccionarVacacionesDelegate?.empleado(fechaSeleccionada: fechaVacacionesInicio, tipoFecha: .inicioVacaciones)
            }
            if let fechaVacacionesFin = empleadoSeleccionado.fechaVacacionesFin {
                seleccionarVacacionesDelegate?.empleado(fechaSeleccionada: fechaVacacionesFin, tipoFecha: .finVacaciones)
            }
        }
    }
    
    // Obtener todo el historial de pagos del empleado
    func obtenerHistorialPagos() {
        print("Empleado seleccionado: \(self.model.empleadoSeleccionado?.id ?? -1)")
        historialNominaDelegate?.pago(historialPagos: self.model.pagos.filter({
            pago in
            pago.empleado == self.model.empleadoSeleccionado
        }))
        
    }
    
    // Evalua el tipo de fecha deseada, despues de determinar el tipo de fecha, le aignamos la fecha(date) seleccionada.
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
            self.seleccionarVacacionesDelegate?.empleado(fechaSeleccionada: fechaSeleccionada, tipoFecha: .finVacaciones)
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

