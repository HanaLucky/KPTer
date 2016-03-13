import Quick
import Nimble
@testable import KPTer

class CardSpec: QuickSpec {
    override func spec() {
        
        Card.MR_truncateAll()
        var newCard: Card? = Card.create("new card title", detail: "new card detail")
        var title = newCard!.card_title
        
        describe("新規Cardを作成する") {
            it("新規Cardを作成できること") {
                expect(newCard).toNot(beNil())
            }
            it("Cardのcard_titleが引数に指定した文字列であること") {
                expect(title).to(equal("new card title"))
            }
        }
        
        describe("既存のCardを編集する") {
            sleep(5)
            it("Cardの名前を引数に指定し、Cardの名前を変更できること") {
                newCard!.edit("edit card title")
                let editCard: Card? = Card.MR_findFirst()
                expect(editCard!.card_title).to(equal("edit card title"))
            }
        }
        
    }
}
