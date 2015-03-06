import Quick
import Nimble
import Cached
import UIKit

class FeedViewControllerSpec: QuickSpec {
    override func spec() {
        
        var viewController:CDFeedViewController!
        
        beforeEach {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            viewController = storyboard.instantiateViewControllerWithIdentifier("FeedViewControllerID") as! CDFeedViewController
        }
        
        describe(".viewDidLoad()") {
            beforeEach {
                let _ = viewController.view
            }
            
            it("sets the navigation bar title to 'Cached' ", flags: [:]) {
                expect(viewController.navigationItem.title).to(equal("Cached"))
            }
        }
        

    }
}
