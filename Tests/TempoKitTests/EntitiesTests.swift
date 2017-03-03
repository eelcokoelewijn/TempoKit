import Foundation
import XCTest

@testable import TempoKit

class EntitiesTests: XCTestCase {
    var authorDic: [String: Any]!
    var author: Author!
    var issueType: IssueType!
    var issueTypeDic: [String: Any]!
    var issueDic: [String: Any]!
    var issue: Issue!
    var worklogBeanDic: [String: Any]!
    var worklogBean: WorklogBean!
    var entitiesStubs: EntitiesStubs!
    
    override func setUp() {
        super.setUp()
        entitiesStubs = EntitiesStubs()
    }
    
    func testIfAuthorIsEqual() {
        let subject = Author(json: entitiesStubs.authorDic)
        XCTAssertEqual(subject, entitiesStubs.author)
    }
    
    func testIfIssueTypeIsEqual() {
        let subject = IssueType(json: entitiesStubs.issueTypeDic)
        XCTAssertEqual(subject, entitiesStubs.issueType)
    }
    
    func testIfIssueIsEqual() {
        let subject = Issue(json: entitiesStubs.issueDic)
        XCTAssertEqual(subject, entitiesStubs.issue)
    }
    
    func testIfWorklogBeanIsEqual() {
        let subject = WorklogBean(json: entitiesStubs.worklogBeanDic)
        XCTAssertEqual(subject, entitiesStubs.worklogBean)
    }
    
    static var allTests : [(String, (EntitiesTests) -> () throws -> Void)] {
        return [
            ("testIfAuthorIsEqual", testIfAuthorIsEqual),
            ("testIfIssueTypeIsEqual", testIfIssueTypeIsEqual),
            ("testIfIssueIsEqual",testIfIssueIsEqual),
            ("testIfWorklogBeanIsEqual", testIfWorklogBeanIsEqual)
        ]
    }
}
