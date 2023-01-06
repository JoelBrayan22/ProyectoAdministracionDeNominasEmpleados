//
//  CatalogosEmpleadosViewController.swift
//  ProyectoNominaEmpleados
//
//  Created by MacBook on 03/01/23.
//

import UIKit

class CatalogosEmpleadosViewController: UIViewController {

    
    @IBOutlet weak var myTableView: UITableView!
    
    var empleados: [EmpleadoEntity] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NominaController.shared.catalogoEmpleadosDelegate = self
        
        myTableView.dataSource = self
        
        NominaController.shared.getEmpleados()
        
    }
    

}

extension CatalogosEmpleadosViewController: CatalogoEmpleadosDelegate {
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

extension CatalogosEmpleadosViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return empleados.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmpleadoCell")!
        
        print(indexPath.row)
        let empleado = self.empleados[indexPath.row]
        print(empleado)
        
        //print(self.empleados)
        
        if let customCell = cell as? CustomTableViewCell {
            print(empleado.nombre)
            customCell.nombreLabel.text = empleado.nombre
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Empleados"
    }
    
    
    
    
}

extension CatalogosEmpleadosViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Presionado")
    }
    
}
