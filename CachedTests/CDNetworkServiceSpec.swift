import Quick
import Nimble
import Cached

class CDNetworkServiceSpec: QuickSpec {
    override func spec() {
        
        var networkService:CDNetworkService!
        
        beforeEach {
            networkService = CDNetworkService()
        }
        
        it("returns an array of the top 20 stories") {
            
//            let storiesArray:[AnyObject]? = networkService.fetchTopStories(20)
//            expect({storiesArray?.count}).toEventually(equal(20), timeout:3)
        }
        
        
    }
}
