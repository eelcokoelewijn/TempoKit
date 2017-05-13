import XCTest
@testable import TempoKit

class TempoKitTests: XCTestCase {
    var baseURL: URL!
    var networkService: TempoNetworkService!
    var entitiesStubs: EntitiesStubs!
    var config: JIRAConfig!
    var jsonDic: [String: Any]!

    override func setUp() {
        baseURL = URL(string: "http://atlassian.com")!
        networkService = NetworkServiceStub()
        entitiesStubs = EntitiesStubs()
        config = JIRAConfig(url: baseURL,
                                 credentials: JIRACredentials(username: "henkkrol", password: "lala888#r2d2"))
        jsonDic = ["url": "http://atlassian.com",
                       "username": "henkkrol",
                       "password": "lala888#r2d2"]
    }

    func testSuccessfulLoadingOfWorklogs() {
        let subject = MixinTempoKit(networkService: networkService, config: config)
        subject.worklogs(dateFrom: "2017-02-28") { result in
            XCTAssertEqual(result, [self.entitiesStubs.worklogBean])
        }
    }

    func testConfigIsCreatedCorrect() {
        let subject = JIRAConfig(url: URL(string: "http://atlassian.com")!,
                                 credentials: JIRACredentials(username: "henkkrol", password: "lala888#r2d2"))
        XCTAssertEqual(subject, config)
    }

    func testConvertingJSONDicToJIRAConfig() {
        let subject = JIRAConfig(json: jsonDic)

        XCTAssertEqual(subject, config)
    }

    func testGettingJSONRepresentationFromJIRAConfig() {
        let subject = config.toJSON()
        XCTAssertEqual(subject["url"] as? String, jsonDic["url"] as? String)
        XCTAssertEqual(subject["username"] as? String, jsonDic["username"] as? String)
        XCTAssertEqual(subject["password"] as? String, jsonDic["password"] as? String)
    }

    static var allTests: [(String, (TempoKitTests) -> () throws -> Void)] {
        return [
            ("testSuccessfulLoadingOfWorklogs", testSuccessfulLoadingOfWorklogs),
            ("testConfigIsCreatedCorrect", testConfigIsCreatedCorrect),
            ("testConvertingJSONDicToJIRAConfig", testConvertingJSONDicToJIRAConfig),
            ("testGettingJSONRepresentationFromJIRAConfig", testGettingJSONRepresentationFromJIRAConfig)
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
