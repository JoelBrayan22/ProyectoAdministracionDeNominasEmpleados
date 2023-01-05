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
    
    var empleadoLogueado: EmpleadoEntity?
    
    // Variable global que almacenara al empleado seleccionado
    var empleadoSeleccionado: EmpleadoEntity?
    
    // Variable global que almacenara todos los empleadosz
    var empleados: [EmpleadoEntity] = []
    
    // Variable global que almacenara el pago seleccionado
    var pagoSeleccionado: PagoEntity?
    
    // Variable global que almacenara todos los pagos
    var pagos: [PagoEntity] = []
    
    // Variable seleccionado que almacena una fecha seleccionada
    var fechaContratacion: Date?
    var fechaInicioVacaciones: Date?
    var fechaFinVacaciones: Date?
    var fechaPago: Date?
    
    // Variable global que retiene el tipo de fecha seleccionada
    var tipoFecha: TipoFecha?
    
    let logIn: [(correo: String, password: String)] =
                [("heber@gs.com","1234"),
                 ("joel@gs.com","1234"),
                 ("brian@gs.com", "1234")]
    
    func instalarEmpleados() {
        print("Instalando empleados")
        
        guard let _ = self.addEmpleado(id: 1, nombre: "Admin Ejemplo", area: "Pruebas", departamento: "Desarrollo", puesto: "Testing", fechaContratacion: Date.now, salario: 15000) else {
            return
        }
        guard let _ = self.addEmpleado(id: 2, nombre: "Ana Paola", area: "Contabilidad", departamento: "Recursos Financieros", puesto: "Secretaria", fechaContratacion: Date.now, salario: 10000) else {
            return
        }
        guard let _ = self.addEmpleado(id: 3, nombre: "Pedro Soto", area: "Administración", departamento: "Titulación", puesto: "Gerente", fechaContratacion: Date.now, salario: 17500) else {
            return
        }
    }
    
    func loadEmpleados() {
        
        let context = self.persistentContainer.viewContext
        
        let requestEmpleados = EmpleadoEntity.fetchRequest()
        
        let requestPagos = PagoEntity.fetchRequest()
        
        if let empleados = try? context.fetch(requestEmpleados) {
            
            self.empleados = empleados
        }
        
        if self.empleados.isEmpty {
            self.instalarEmpleados()
        }
        
        if let pagos = try? context.fetch(requestPagos) {
            
            self.pagos = pagos
        }
    }
    
    func empleadoLogIn(correo: String, password: String) -> EmpleadoEntity? {
        
        self.loadEmpleados()
        
        if let empleado = self.empleados.filter({ empleado in
            empleado.correo == correo && empleado.password == password
        }).first {
            self.empleadoLogueado = empleado
            return empleado
        }
        
        return nil
    }
    
    func getEmpleados() -> [EmpleadoEntity] {
        
        self.loadEmpleados()
        return self.empleados
    }
    
    func addEmpleado(id: Int, nombre: String, area: String, departamento: String, puesto: String, fechaContratacion: Date, salario: Double) -> EmpleadoEntity? {
        
        let context = persistentContainer.viewContext
        
        let empleado = EmpleadoEntity(context: context)
        
        empleado.id = Int32(id)
        empleado.nombre = nombre
        empleado.area = area
        empleado.departamento = departamento
        empleado.puesto = puesto
        empleado.fechaContratacion = fechaContratacion
        empleado.antiguedad = Int32(0)
        empleado.salario = salario
        empleado.fechaVacacionesInicio = nil
        empleado.fechaVacacionesFin = nil
        empleado.estaVacaciones = false
        empleado.tienePrestamo = false
        empleado.correo = "empleado_\(empleado.id)@empresa.com"
        empleado.password = "empleado_\(empleado.id)"
        
        do {
            try context.save()
            
            self.loadEmpleados()
            
            return empleado
        } catch {
            context.rollback()
            return nil
        }
    }
    
    func seleccionarEmpleado(index: Int, empleado: EmpleadoEntity) -> EmpleadoEntity? {
        
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
    
    func seleccionarPago(index: Int, pago: PagoEntity) -> PagoEntity? {
        
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
        if let empleadoSeleccionado = self.empleadoSeleccionado {
            pago.empleado = empleadoSeleccionado
        }
        
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
