import UIKit

class ViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var miVista: UIView!
    @IBOutlet weak var gestoLabel: UILabel!
    
    // MARK: Properties Tamano
    private var vistaTamanoOrigial: CGRect!
    
    // MARK: Ciclo de vida
    override func viewDidLoad() {
        super.viewDidLoad()
        
        vistaTamanoOrigial = miVista.frame
        
        // un toques
        let unTap = UITapGestureRecognizer(target: self, action: #selector(gestoDobleTap(gesture:)))
        unTap.numberOfTapsRequired = 1
        unTap.numberOfTouchesRequired = 1 // numero de dedos que realizaran la accion
        miVista.isUserInteractionEnabled = true
        miVista.addGestureRecognizer(unTap)
        
        // dos toques como el like de instagram
        let dobleTap = UITapGestureRecognizer(target: self, action: #selector(gestoDobleTap(gesture:)))
        dobleTap.numberOfTapsRequired = 2
        dobleTap.numberOfTouchesRequired = 1 // numero de dedos que realizaran la accion
        miVista.isUserInteractionEnabled = true
        miVista.addGestureRecognizer(dobleTap)
        
        // Swipe de izquierda a derecha
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(gestoSwipe(gesture:)))
        swipe.numberOfTouchesRequired = 1
        swipe.direction = .left // cambiar para hacerlo de derecha a izquierda o de arriba hacia abajo o de abajo hacia arriba
        miVista.isUserInteractionEnabled = true
        miVista.addGestureRecognizer(swipe)
        
        // Pinch
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(gestoPinch(gesture:)))
        miVista.isUserInteractionEnabled = true
        miVista.addGestureRecognizer(pinch)
        
        // Rotate
        let rotate = UIRotationGestureRecognizer(target: self, action: #selector(gestoRotate(gesture:)))
        miVista.isUserInteractionEnabled = true
        miVista.addGestureRecognizer(rotate)
    }
    
    // MARK: Taps
    @objc func gestoDobleTap(gesture: UITapGestureRecognizer) {
        self.gestoLabel.text = "Diste \(gesture.numberOfTapsRequired) taps"
        if gesture.numberOfTapsRequired == 1 {
            gesture.view?.backgroundColor = .blue
        } else {
            gesture.view?.backgroundColor = .green
        }
    }
    
    // MARK: Swipe
    @objc func gestoSwipe(gesture: UISwipeGestureRecognizer) {
        self.gestoLabel.text = "Hiciste swipe"
        gesture.view?.backgroundColor = .black
    }

    // MARK: Pinch
    @objc func gestoPinch(gesture: UIPinchGestureRecognizer) {
        self.gestoLabel.text = "Hiciste Pinch"
        gesture.view?.backgroundColor = .gray
        self.miVista.transform = self.miVista.transform.scaledBy(x: gesture.scale, y: gesture.scale)
        gesture.scale = 1
    }
    
    // MARK: Rotate
    @objc func gestoRotate(gesture: UIRotationGestureRecognizer) {
        self.gestoLabel.text = "Hiciste Rotare"
        gesture.view?.backgroundColor = .purple
        self.miVista.transform = self.miVista.transform.rotated(by: gesture.rotation)
        gesture.rotation = 0
    }
    
}

