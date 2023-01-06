//
//  HistorialNominaViewController.swift
//  ProyectoNominaEmpleados
//
//  Created by MacBook on 03/01/23.
//

import UIKit

class HistorialNominaViewController: UIViewController {

    
    @IBOutlet weak var myTableView: UITableView!
    
    var pagos: [PagoEntity] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NominaController.shared.historialNominaDelegate = self
        
        myTableView.dataSource = self
        
        NominaController.shared.obtenerHistorialPagos()
    }
}

extension HistorialNominaViewController: HistorialNominaDelegate {
    
    func pago(historialPagos historial: [PagoEntity]) {
        self.pagos = historial
        self.myTableView.reloadData()
    }
    
    func pago(pagoSeleccionado: PagoEntity, index: Int) {
    }
}

extension HistorialNominaViewController: UITableViewDataSource {
    
    // Numero de secciones que se requiere pintar en la celda
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Cantidad de elementos que se requieren en la seccion deseada
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pagos.count
    }
    
    // Titulo deseado en cada seccion
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Pagos"
    }
    
    // Configuracion de la celda
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NominasCell")!
        let pago = self.pagos[indexPath.row]
        
        if let customCell = cell as? NominaCustomTableViewCell {
            //print(empleado.nombre)
            customCell.nombreNominaLabel.text = pago.nombreEmpleado
        }
        
        return cell
    }
}

extension HistorialNominaViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Presionado")
    }
    
}
