//
//  MockUrlSession.swift
//  ResultSportTests
//
//  Created by Samy Boussair on 12/08/2023.
//

import Foundation

class MockURLProtocol: URLProtocol {
    static var mockData: [String: Data] = [:]

    override class func canInit(with task: URLSessionTask) -> Bool {
        return true
    }

    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {
        guard let url = request.url else {
            print("URL is nil")
            client?.urlProtocol(self, didFailWithError: NSError(domain: "MockURLProtocol", code: 1, userInfo: nil))
            return
        }

        print("Attempting to load URL:", url)

        guard let data = MockURLProtocol.mockData[url.absoluteString] else {
            print("No mock data found for URL:", url)
            client?.urlProtocol(self, didFailWithError: NSError(domain: "MockURLProtocol", code: 2, userInfo: nil))
            return
        }

        print("Mock data found for URL:", url)

        client?.urlProtocol(self, didLoad: data)
        client?.urlProtocol(self, didReceive: HTTPURLResponse(), cacheStoragePolicy: .allowed)
        client?.urlProtocolDidFinishLoading(self)
    }

    override func stopLoading() {}

    static func loadJSONData(filename: String) -> Data? {
        if let path = Bundle(for: MockURLProtocol.self).path(forResource: filename, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                return data
            } catch {
                print("Error file not found : \(error)")
            }
        }
        return nil
    }
}
