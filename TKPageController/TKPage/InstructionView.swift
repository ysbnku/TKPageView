
import UIKit

class InstructionView: UIViewController
{
  
  var pageIndex : Int = 0
  var titleText : String = ""
  var imageFile : String = ""
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    
    //view.backgroundColor = UIColor(patternImage: UIImage(named: imageFile)!)
    
    let image = UIImageView(frame: CGRect(x: 0, y: 124, width: 350, height: 255))
    image.contentMode = .scaleAspectFill
    image.image = UIImage(named: imageFile)
    view.addSubview(image)
    
    let label = UILabel(frame: CGRect(x: 8, y: 523, width: view.frame.width - 20, height: 135))
    label.textColor = .white
    label.text = titleText
    label.textAlignment = .left
    label.numberOfLines = 5
    
    view.addSubview(label)
    
    }
  
  override func didReceiveMemoryWarning()
  {
    super.didReceiveMemoryWarning()
  }
    
  
}
