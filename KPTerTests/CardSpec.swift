
import RealmSwift
import Quick
import Nimble
@testable import KPTer

// CardViewModelのテストをする際は、BoardSpecのspec()内をコメントアウトしてください。
class CardSpec: QuickSpec {
    override func spec() {
        
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
        }
        var newBoard: Board? = BoardViewModel.create("new board title")
        var newCard: Card? = CardViewModel.create("new card title", detail: "new card detail", type: Card.CardType.Keep)
        BoardViewModel.addTryCard(newBoard!, title: "new card title2", detail: "new card detail2", fromCard: newCard!)
        BoardViewModel.addProblemCard(newBoard!, title: "new card title2", detail: "new card detail2")
        
        describe("新規Cardを作成する") {
            it("新規Cardを作成できること") {
                expect(newCard).toNot(beNil())
            }
            it("Cardのcard_titleが引数に指定した文字列であること") {
                expect(newCard!.card_title).to(equal("new card title"))
            }
            it("Cardのdetailが引数に指定した文字列であること") {
                expect(newCard!.detail).to(equal("new card detail"))
            }
            it("Cardのstatusが'Open'であること") {
                expect(newCard!.status).to(equal("Open"))
            }
            it("Cardのtypeが'Keep'であること") {
                expect(newCard!.type).to(equal("Keep"))
            }
        }
        
        describe("既存のCardを編集する") {
            it("Cardの名前を引数に指定し、Cardの名前を変更できること") {
                sleep(3)
                let eCard = Card()
                eCard.card_title = "edit card title"
                eCard.detail = "edit card detail"
                eCard.type = Card.CardType.Problem.rawValue
                CardViewModel.edit(newCard!, editCard: eCard)
                let editCard: Card? = realm.objects(Card).first
                expect(editCard!.card_title).to(equal("edit card title"))
                expect(editCard!.detail).to(equal("edit card detail"))
                expect(editCard!.type).to(equal("Problem"))
            }
        }
        
        describe("Cardのstatusを編集する") {
            it("CardとCardのstatusを引数に渡すと、cardのstatusがその値になること") {
                sleep(5)
                CardViewModel.changeStatus(newCard!, status: Card.CardStatus.Done)
                let changedStatusCard: Card? = realm.objects(Card).first
                expect(changedStatusCard!.status).to(equal("Done"))
            }
        }

        
        describe("Cardを削除する") {
            
            it("削除されたCardが取得できないこと") {
                sleep(7)
                CardViewModel.deleteCardRelation(BoardViewModel.findTryCard(newBoard!).first!)
                CardViewModel.delete(BoardViewModel.findTryCard(newBoard!).first!)                
                expect(realm.objects(Card).count).to(equal(2))
                expect(realm.objects(CardRelation).count).to(equal(0))
            }
        }
        
    }
}
