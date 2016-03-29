
import RealmSwift
import Quick
import Nimble
@testable import KPTer

// CardViewModelのテストをする際は、BoardSpecのspec()内をコメントアウトしてください。
class CardSpec: QuickSpec {
//    override func spec() {
//        
//        let realm = try! Realm()
//        var newCard: Card? = CardViewModel.create("new card title", detail: "new card detail", type: Card.CardType.Keep)
//        
//        describe("新規Cardを作成する") {
//            it("新規Cardを作成できること") {
//                expect(newCard).toNot(beNil())
//            }
//            it("Cardのcard_titleが引数に指定した文字列であること") {
//                expect(newCard!.card_title).to(equal("new card title"))
//            }
//            it("Cardのdetailが引数に指定した文字列であること") {
//                expect(newCard!.detail).to(equal("new card detail"))
//            }
//            it("Cardのstatusが'Open'であること") {
//                expect(newCard!.status).to(equal("Open"))
//            }
//            it("Cardのtypeが'Keep'であること") {
//                expect(newCard!.type).to(equal("Keep"))
//            }
//        }
//        
//        describe("既存のCardを編集する") {
//            it("Cardの名前を引数に指定し、Cardの名前を変更できること") {
//                sleep(5)
//                CardViewModel.edit(newCard!, title: "edit card title", detail: "edit card detail")
//                let editCard: Card? = realm.objects(Card).first
//                expect(editCard!.card_title).to(equal("edit card title"))
//            }
//        }
//        
//        describe("Cardを削除する") {
//            
//            it("削除されたCardが取得できないこと") {
//                sleep(10)
//                CardViewModel.delete(newCard!)
//                expect(realm.objects(Card).count).to(equal(0)) 
//            }
//        }
//        
//    }
}
