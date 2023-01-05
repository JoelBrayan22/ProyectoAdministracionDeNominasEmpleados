//
//  NominaModel.swift
//  ProyectoNominaEmpleados
//
//  Created by User on 05/01/23.
//

import Foundation
import CoreData

class NominaModel {
    
    let persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "NominApp")
        
        container.loadPersistentStores {
            _, error in
            if let error = error {
                fatalError("No existe el contenedor... \(error)")
            }
        }
        
        return container
    }()
    
    var empleados: [EmpleadoEntity] = []
    
    var empleadoSeleccionado = EmpleadoEntity()
    
    var pagos: [PagoEntity] = []
    
    var pagoSeleccionado = PagoEntity()
    
    let logIn: [(correo: String, password: String)] =
                [("heber@gs.com","1234"),
                 ("joel@gs.com","1234"),
                 ("brian@gs.com", "1234")]
    
    func loadEmpleados() {
        
        let context = self.persistentContainer.viewContext
        
        let requestEmpleados = EmpleadoEntity.fetchRequest()
        
        let requestPagos = PagoEntity.fetchRequest()
        
        if let empleados = try? context.fetch(requestEmpleados) {
            
            self.empleados = empleados
        }
        
        if let pagos = try? context.fetch(requestPagos) {
            
            self.pagos = pagos
        }
    }
    
    func empleadoLogIn(correo: String, password: String) -> Bool {
        
        var logInResponse = false
        
        for logIn in self.logIn {
            if correo == logIn.correo && password == logIn.password {
                
                logInResponse = true
                break
            }
        }
        
        return logInResponse
    }
    
    func getEmpleados() -> [EmpleadoEntity] {
        
        self.loadEmpleados()
        return self.empleados
    }
    
    func addEmpleado(id: Int, nombre: String, area: String, departamento: String, puesto: String, fechaContratacion: Date, antiguedad: Int, salario: Double, fechaVacacionesInicio: Date, fechaVacacionesFin: Date, estaVacaciones: Bool, tienePrestamo: Bool) -> EmpleadoEntity? {
        
        let context = persistentContainer.viewContext
        
        let empleado = EmpleadoEntity(context: context)
        
        empleado.id = Int32(id)
        empleado.nombre = nombre
        empleado.area = area
        empleado.departamento = departamento
        empleado.puesto = puesto
        empleado.fechaContratacion = fechaContratacion
        empleado.antiguedad = Int32(antiguedad)
        empleado.salario = salario
        empleado.fechaVacacionesInicio = fechaVacacionesInicio
        empleado.fechaVacacionesFin = fechaVacacionesFin
        empleado.estaVacaciones = estaVacaciones
        empleado.tienePrestamo = tienePrestamo
        
        do {
            try context.save()
            
            self.loadEmpleados()
            
            return empleado
        } catch {
            context.rollback()
            return nil
        }
    }
    
    func seleccionarEmpleado(index: Int) -> EmpleadoEntity? {
        
        guard index >= 0 && index < self.empleados.count
        else { return nil }
        
        self.empleadoSeleccionado = self.empleados[index]
        
        return self.empleadoSeleccionado
    }
    
    /*func seleccionarFecha(fechaSeleccionada: Date, tipoFecha: TipoFecha) -> Date {
        
        switch tipoFecha {
        case inicioVacaciones: return self.empleadoSeleccionado.fechaVacacionesInicio ?? Date().self
        case finVacaciones: return self.empleadoSeleccionado.fechaVacacionesFin ?? Date.self
        case fechaContratacion: return self.empleadoSeleccionado.fechaContratacion ?? Date.self
        case fechaPago: return self.pagoSeleccionado.fechaPago ?? Date().self
        default: return Date().self
        }
    }*/

    func obtenerHistorialPagos() -> [PagoEntity] {
        
        self.loadEmpleados()
        return self.pagos
    }
    
    func seleccionarPago(index: Int) -> PagoEntity? {
        
        guard index >= 0 && index < self.pagos.count
        else { return nil }
        
        self.pagoSeleccionado = self.pagos[index]
        
        return self.pagoSeleccionado
    }
    
    func agregarPago(nombreEmpleado: String, fechaPago: Date, sueldo: Double, viaticos: Double?, prestamo: Double?, descripcionPrestamo: String?, cantidadRestantePrestamo: Double?, numeroAbono: Int?) -> PagoEntity? {
        
        let context = persistentContainer.viewContext
        
        let pago = PagoEntity(context: context)
        
        pago.nombreEmpleado = nombreEmpleado
        pago.fechaPago = fechaPago
        pago.sueldo = sueldo
        pago.viaticos = viaticos ?? 0.0
        pago.prestamo = prestamo ?? 0.0
        pago.descripcionPrestamo = descripcionPrestamo ?? ""
        pago.cantidadRestantePrestamo = cantidadRestantePrestamo ?? 0.0
        pago.numeroAbono = Int32(numeroAbono ?? 0)
        
        do {
            try context.save()
            
            self.loadEmpleados()
            
            return pago
        } catch {
            context.rollback()
            return nil
        }
    }
}
