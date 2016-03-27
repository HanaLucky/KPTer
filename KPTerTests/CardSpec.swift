
import RealmSwift
import Quick
import Nimble
@testable import KPTer

// CardViewModelのテストをする際は、BoardSpecのspec()内をコメントアウトしてください。
class CardSpec: QuickSpec {
    override func spec() {
        
        sleep(10)
        let realm = try! Realm()
        var newCard: Card? = CardViewModel.create("new card title", detail: "new card detail")
        
        describe("新規Cardを作成する") {
            it("新規Cardを作成できること") {
                expect(newCard).toNot(beNil())
            }
            it("Cardのcard_titleが引数に指定した文字列であること") {
                expect(newCard!.card_title).to(equal("new card title"))
            }
        }
        
        describe("既存のCardを編集する") {
            sleep(5)
            it("Cardの名前を引数に指定し、Cardの名前を変更できること") {
                CardViewModel.edit(newCard!, title: "edit card title", detail: "edit card title")
                let editCard: Card? = realm.objects(Card).first
                expect(editCard!.card_title).to(equal("edit card title"))
            }
        }
        
        describe("Cardを削除する") {
            
            it("削除されたCardが取得できないこと") {
                sleep(10)
                CardViewModel.delete(newCard!)
                expect(realm.objects(Card).count).to(equal(0)) //削除されたCardが取得できないこと
            }
        }

        
    }
}
