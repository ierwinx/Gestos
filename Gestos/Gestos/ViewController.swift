import UIKit

class ViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var documento: UIImageView!
    @IBOutlet weak var recycleBin: UIImageView!
    @IBOutlet weak var arrastraLabel: UILabel!
    
    // MARK: Properties
    var documentoViewOrigen: CGPoint!

    // MARK: Ciclo de vida
    override func viewDidLoad() {
        super.viewDidLoad()
        
        agregaGestosDocumento(view: documento)
        agregaGestosVote(view: recycleBin)
        documentoViewOrigen = documento.frame.origin
    }
    
    // MARK: Arrastrar
    func agregaGestosDocumento(view: UIView) -> Void {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(ViewController.handlePan(sender:)))
        view.addGestureRecognizer(pan)
    }
    
    @objc func handlePan(sender: UIPanGestureRecognizer) -> Void {
        let documentoView = sender.view!
        let translation = sender.translation(in: view)
        
        switch sender.state {
        case .began, .changed:
            documentoView.center = CGPoint(x: documentoView.center.x + translation.x, y: documentoView.center.y + translation.y)
            sender.setTranslation(CGPoint.zero, in: view)
            print("Inicia Cambia")
        case .ended:
            if documentoView.frame.intersects(recycleBin.frame) {
                UIView.animate(withDuration: 0.3) {
                    self.documento.alpha = 0.0
                    self.recycleBin.image = UIImage(named: "trash2")
                    self.arrastraLabel.text = "Saca de la papelera"
                }
            } else {
                UIView.animate(withDuration: 0.3) {
                    self.documento.frame.origin = self.documentoViewOrigen
                }
            }
            print("Finalizo")
        case .possible:
            print("Posible")
        case .cancelled:
            print("Cancelado")
        case .failed:
            print("Fallo")
        @unknown default:
            print("Desconocido")
        }
        
    }
    
    // MARK: Vaciar
    func agregaGestosVote(view: UIView) {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.voteTocado(sender:)))
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func voteTocado(sender: UITapGestureRecognizer) {
        //let basura = sender.view as! UIImageView
        if self.recycleBin.image == UIImage(named: "trash2") {
            let alerta = UIAlertController(title: "¿Deseas Limpiar la papelera de reciclaje?", message: nil, preferredStyle: .actionSheet)
            
            let aceptar = UIAlertAction(title: "Aceptar", style: .default) { accion in
                UIView.animate(withDuration: 0.3) {
                    self.recycleBin.image = UIImage(named: "trash1")
                    self.arrastraLabel.text = "Ya no hay documentos"
                }
            }
            let restaurar = UIAlertAction(title: "Restaurar", style: .default) { accion in
                UIView.animate(withDuration: 0.3) {
                    self.recycleBin.image = UIImage(named: "trash1")
                    self.arrastraLabel.text = "Arrastra a la papelera"
                    self.documento.alpha = 1.0
                }
            }
            
            alerta.addAction(aceptar)
            alerta.addAction(restaurar)
            alerta.addAction(UIAlertAction(title: "Cancelar", style: .destructive, handler: nil))
            
            present(alerta, animated: true, completion: nil)
        }
        
    }

}

