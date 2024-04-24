import Foundation

private typealias resultType = (data: Data, urlResponse: URLResponse)

final class ApiProvider {

    static let shared = ApiProvider()

    func request<T: Decodable>(
        _ api: Api
    ) async throws -> T {
        guard let url = api.path else {
            throw NetworkError.invalidUrl
        }

        let result: resultType = try await URLSession.shared.data(from: url)

        guard let response = result.urlResponse as? HTTPURLResponse else {
            throw NetworkError.badResponse
        }

        let statusCode = StatusCodeHandler.getResult(response.statusCode)

        switch statusCode {
        case .success:
            return try JSONDecoder().decode(
                T.self,
                from: result.data
            )
        case .failure:
            throw NetworkError.httpError(
                code: response.statusCode
            )
        }
    }
}

extension ApiProvider {
    enum NetworkError: LocalizedError {

        case httpError(code: Int)
        case invalidUrl
        case badResponse
        var errorDescription: String? {

            switch self {
            case.httpError(let code):
                return "HTTP Error code: \(code)"
            case .invalidUrl:
                return "The URL is invalid"
            case .badResponse:
                return "Not expected response from server"
            }
        }
    }

    enum StatusCodeHandler {
        case success
        case failure

        static func getResult(_ code: Int) -> Self {
            let successRange = 200...299

            if successRange.contains(code) {
                return .success
            } else {
                return .failure
            }
        }
    }
}
