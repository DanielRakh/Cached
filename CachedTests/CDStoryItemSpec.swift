import Quick
import Nimble
import Cached

class CDStoryItemSpec: QuickSpec {
    override func spec() {
        
        describe("A Story Item") {
            
            var story:CDStoryItem!
            
            beforeEach {
                story = CDStoryItem(id:"000000",
                    title:"Dummy Title",
                    url:"http://dummy.com",
                    text:"Dummy Text")
            }
    
            it("Has an ID") {
                expect(story._id) != nil
            }
            it("Has a title") {
                expect(story._title) != nil
            }
            it("Has a URL") {
                expect(story._url) != nil
            }
            it("Has text") {
                expect(story._text) != nil
            }
        }
    }
}
