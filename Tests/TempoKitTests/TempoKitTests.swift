import XCTest
@testable import TempoKit

class TempoKitTests: XCTestCase {
    var baseURL: URL!
    var networkService: TempoNetworkService!
    var entitiesStubs: EntitiesStubs!
    var credentials: JIRACredentials!
    
    override func setUp() {
        baseURL = URL(string: "http://atlassian.com")!
        networkService = NetworkServiceStub()
        entitiesStubs = EntitiesStubs()
        credentials = JIRACredentials(username: "henkkrol", password: "lala888#r2d2")
    }
    
    func testSuccessfulLoadingOfWorklogs() {
        let subject = MixinTempoKit(baseURL: baseURL, networkService: networkService, credentials: credentials)
        subject.worklogs(dateFrom: "2017-02-28") { result in
            XCTAssertEqual(result, [self.entitiesStubs.worklogBean])
        }
    }

    static var allTests : [(String, (TempoKitTests) -> () throws -> Void)] {
        return [
            ("testSuccessfulLoadingOfWorklogs", testSuccessfulLoadingOfWorklogs),
        ]
    }
}


private class NetworkServiceStub: TempoNetworkService {
    private let entitiesStubs = EntitiesStubs()
    fileprivate func load(worklog: TempoRequest, completion: @escaping ([[String : Any]]) -> Void) {
        _ = worklog.params
        completion([entitiesStubs.worklogBeanDic])
    }
}
