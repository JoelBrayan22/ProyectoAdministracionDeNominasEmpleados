//
//  CatalogosEmpleadosViewController.swift
//  ProyectoNominaEmpleados
//
//  Created by MacBook on 03/01/23.
//

import UIKit

class CatalogoEmpleadosViewController: UIViewController {

    
    @IBOutlet weak var myTableView: UITableView!
    
    // Variable donde se guardara Todos los empleados existentes
    var empleados: [EmpleadoEntity] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // El catalogoEmpleadosDelegate sera esta vista
        NominaController.shared.catalogoEmpleadosDelegate = self
        
        // Esta vista es la proveedora de los datos
        myTableView.dataSource = self
        
        // Le pedimos al controlador que nos brinde todos los empleados existentes
        NominaController.shared.getEmpleados()
        
    }
}

// Extension de CatalogosEmpleadosViewController para implementar CatalogoEmpleadosDelegate
extension CatalogoEmpleadosViewController: CatalogoEmpleadosDelegate {
    
    //
    func empleado(empleadosCargados empleados: [EmpleadoEntity]) {
        self.empleados = empleados
        self.myTableView.reloadData()
    }
    
    func empleado(empleadoCreado empleado: EmpleadoEntity) {
        NominaController.shared.getEmpleados()
    }
    
    func empleado(empleadoCreadoError message: String) {
        
    }
    
    func empleado(empleadoSeleccionado empleado: EmpleadoEntity, index: Int) {
        
    }
    
}

extension CatalogoEmpleadosViewController: UITableViewDataSource {
    
    // Numero de secciones que se requiere pintar en la celda
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Cantidad de elementos que se requieren en la seccion deseada
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return empleados.count
    }
    
    // Titulo deseado en cada seccion
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Empleados"
    }
    
    // Configuracion de la celda
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmpleadoCell")!
        
        print(indexPath.row)
        let empleado = self.empleados[indexPath.row]
        print(empleado)
        
        //print(self.empleados)
        
        if let customCell = cell as? CustomTableViewCell {
            //print(empleado.nombre)
            customCell.nombreLabel.text = empleado.nombre
            customCell.idLabel.text = "\(empleado.id)"
            customCell.puestoLabel.text = empleado.puesto
            customCell.horarioLabel.text = "\(empleado.fechaVacacionesInicio ?? Date.now)"
            customCell.antiguedadLabel.text = "\(empleado.antiguedad)"
        }
        
        return cell
    }
   
}

extension CatalogoEmpleadosViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Presionado")
    }
    
}
