
import UIKit

class ViewController: UIViewController, UIPageViewControllerDataSource
{
    var TKGArray : [TKGArr] = []

  var pageViewController : UIPageViewController?
    var pageTitles : Array<String> = ["2030 yılından geldiğini iddia eden ve sık sık gelecekte yaşanacağını öne sürdüğü olaylar hakkında insanları videolarla bilgilendiren zaman yolcusu Noah'ın son paylaşımı şaşırttı.", "Noah, 2030'a kadar ABD ve Kuzey Kore arasında savaş başlayacağını, insan benliğinin bilgisayara aktarılabileceğini ve böylece ölümsüzlüğün ilk adımlarının atılmış olacağını öne sürüyor.", "Noah'a göre 2028 yılında İkinci Sanayi Devrimi gerçekleşecek.."]
  var pageImages : Array<String> = ["page1.png", "page2.png", "page3.png"]

  var currentIndex : Int = 0
  
  override func viewDidLoad()
  {
    super.viewDidLoad()

    getData()
    
    
    pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    pageViewController!.dataSource = self
    
    let stsartingViewController: InstructionView = viewControllerAtIndex(index: 0)!
    let viewControllers = [stsartingViewController]
    pageViewController!.setViewControllers(viewControllers , direction: .forward, animated: false, completion: nil)
    pageViewController!.view.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height);
    
    addChildViewController(pageViewController!)
    view.addSubview(pageViewController!.view)
    pageViewController!.didMove(toParentViewController: self)
  }
  
  override func didReceiveMemoryWarning()
  {
    super.didReceiveMemoryWarning()
  }
  
  func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController?
  {
    var index = (viewController as! InstructionView).pageIndex
    
    if (index == 0) || (index == NSNotFound) {
      return nil
    }
    
    index -= 1
    
    return viewControllerAtIndex(index: index)
  }
  
  func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?
  {
    var index = (viewController as! InstructionView).pageIndex
    
    if index == NSNotFound {
      return nil
    }
    
    index += 1
    
    if (index == self.pageTitles.count) {
      return nil
    }
    
    return viewControllerAtIndex(index: index)
  }
    
  
  func viewControllerAtIndex(index: Int) -> InstructionView?
  {
    if self.pageTitles.count == 0 || index >= self.pageTitles.count
    {
      return nil
    }
    
    // Create a new view controller and pass suitable data.
    let pageContentViewController = InstructionView()
    pageContentViewController.imageFile = pageImages[index]
    pageContentViewController.titleText = pageTitles[index]
    pageContentViewController.pageIndex = index
    currentIndex = index
    print(self.pageTitles.count)
    return pageContentViewController
  }
  
  func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int
  {
    return self.pageTitles.count
  }
  
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int
  {
    return 0
  }
 
    func getData(){
       // self.myArray.append("Turkuvaz Medya")//Burada ekleniyor.

        let url = URL(string: "https://api.tmgrup.com.tr/v1/link/149?id=262259")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            do {
                let tkgalery = try JSONDecoder().decode(TKData.self, from: data!)
                let Resp = tkgalery.data.listGalleryHomeAndDetail.Response[0]
                
                for AlbumA in Resp.AlbumMedias {
                    let tkgArr = TKGArr()
                    let replaceone = AlbumA.Description.replacingOccurrences(of: "</p>", with:"")
                    tkgArr.descriptonP = replaceone.replacingOccurrences(of: "<p>", with: "")
                    tkgArr.imgP = AlbumA.Image
                    tkgArr.titleP = AlbumA.Title
             
                    self.pageTitles.append(AlbumA.Description) //Döngümden gelen verileri arrayıma eklemek istiyorum.

                }
                
            }catch{
                print(error)
            }
            
            }.resume()
    }
    
//    func getTotalNews(){
//
//        let url = URL(string: "https://api.tmgrup.com.tr/v1/link/149?id=262259")
//        URLSession.shared.dataTask(with: url!) { (data, response, error) in
//
//            do {
//                let tkgalery = try JSONDecoder().decode(TKData.self, from: data!)
//                if(tkgalery.pagination.next_url?.isEmpty)!{
//                    print("boş")
//                }
//
//
//
//            }catch{
//                print(error)
//            }
//
//            }.resume()
//    }
}
