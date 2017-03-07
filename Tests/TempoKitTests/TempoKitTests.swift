import XCTest
@testable import TempoKit

class TempoKitTests: XCTestCase {
    var baseURL: URL!
    var networkService: TempoNetworkService!
    var entitiesStubs: EntitiesStubs!
    
    override func setUp() {
        baseURL = URL(string: "http://atlassian.com")!
        networkService = NetworkServiceStub()
        entitiesStubs = EntitiesStubs()
    }
    
    func testSuccessfulLoadingOfWorklogs() {
        let subject = MixinTempoKit(baseURL: baseURL, networkService: networkService)
        subject.worklogs(dateFrom: "2017-02-28") { result in
            XCTAssertEqual(result, [entitiesStubs.worklogBean])
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
    fileprivate func load(worklog: TempoRequest, completion: (([[String : Any]]) -> Void)) {
        _ = worklog.params
        completion([entitiesStubs.worklogBeanDic])
    }
}
