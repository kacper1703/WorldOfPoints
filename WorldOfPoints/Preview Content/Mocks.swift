//
//  Mocks.swift
//  WorldOfPoints
//
//  Created by Kacper Czapp on 30/03/2024.
//

import Foundation
import Combine
import Reachability

final class NetworkServiceMock: NetworkServiceProtocol {

    enum CustomError: Swift.Error, LocalizedError {
        case randomError

        var errorDescription: String? {
            "This is a mocked error."
        }
    }

    var networkReachablePublisher: AnyPublisher<Bool, Never> {
        $isNetworkReachable.eraseToAnyPublisher()
    }

    @Published var isNetworkReachable: Bool
    private var cancellables: Set<AnyCancellable> = []

    init(networkReachable: Bool = true) {
        if isRunningForPreviews {
            self.isNetworkReachable = networkReachable
        } else {
            self.isNetworkReachable = Reachability.shared.currentPath.isReachable
            setUpNetworkObserver()
        }
    }

    func getTransactions() async throws -> [Transaction] {
        try await Task.sleep(for: .seconds(Int.random(in: 1...3)))

        return if Int.random(in: 0...3) != 0 {
            TransactionsResponse.mock.items
        } else {
            throw CustomError.randomError
        }
    }

    private func setUpNetworkObserver() {
        Reachability.shared.$currentPath
            .map { $0.isReachable }
            .weakAssign(to: \.isNetworkReachable, on: self)
            .store(in: &cancellables)
    }
}

extension Transaction {
    static var mock: Self {
        let jsonString: String = """
{
    "partnerDisplayName" : "REWE Group",
    "alias" : {
        "reference" : "795357452000810"
    },
    "category" : 1,
    "transactionDetail" : {
        "description" : "Punkte sammeln",
        "bookingDate" : "2022-07-24T10:59:05+0200",
        "value" : {
            "amount" : 12345,
            "currency" : "PPP"
        }
    }
}
"""
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return try! decoder.decode(Self.self,
                                   from: jsonString.data(using: .utf8)!)
    }

    static var mockNoDescription: Self {
        let jsonString: String = """
{
    "partnerDisplayName" : "H&M",
    "alias" : {
        "reference" : "795357452000810"
    },
    "category" : 1,
    "transactionDetail" : {
        "bookingDate" : "2022-07-24T10:59:05+0200",
        "value" : {
            "amount" : 12345,
            "currency" : "PPP"
        }
    }
}
"""
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return try! decoder.decode(Self.self,
                                   from: jsonString.data(using: .utf8)!)
    }

    static var mockLongDescription: Self {
        let jsonString: String = """
{
    "partnerDisplayName" : "OTTO Group",
    "alias" : {
        "reference" : "795357452000810"
    },
    "category" : 1,
    "transactionDetail" : {
        "description" : "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
        "bookingDate" : "2022-07-24T10:59:05+0200",
        "value" : {
            "amount" : 12345,
            "currency" : "PPP"
        }
    }
}
"""
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return try! decoder.decode(Self.self,
                                   from: jsonString.data(using: .utf8)!)
    }
}

extension TransactionsResponse {
    static var mock: Self {
        let jsonString: String = """
{
    "items" : [
        {
            "partnerDisplayName" : "REWE Group",
            "alias" : {
                "reference" : "795357452000810"
            },
            "category" : 1,
            "transactionDetail" : {
                "description" : "Punkte sammeln",
                "bookingDate" : "2022-07-24T10:59:05+0200",
                "value" : {
                    "amount" : 124,
                    "currency" : "PPP"
                }
            }
        },
        {
            "partnerDisplayName" : "dm-dogerie markt",
            "alias" : {
                "reference" : "098193809705561"
            },
            "category" : 1,
            "transactionDetail" : {
                "description" : "Punkte sammeln",
                "bookingDate" : "2022-06-23T10:59:05+0200",
                "value" : {
                    "amount" : 1240,
                    "currency" : "PPP"
                }
            }
        },
        {
            "partnerDisplayName" : "OTTO Group",
            "alias" : {
                "reference" : "094844835601044"
            },
            "category" : 2,
            "transactionDetail" : {
                "bookingDate" : "2022-07-22T10:59:05+0200",
                "value" : {
                    "amount" : 53,
                    "currency" : "PPP"
                }
            }
        },
        {
            "partnerDisplayName" : "OTTO Group",
            "alias" : {
                "reference" : "554854339484901"
            },
            "category" : 1,
            "transactionDetail" : {
                "description" : "Punkte sammeln",
                "bookingDate" : "2022-04-10T10:59:05+0200",
                "value" : {
                    "amount" : 353,
                    "currency" : "PPP"
                }
            }
        },
        {
            "partnerDisplayName" : "H&M",
            "alias" : {
                "reference" : "260531375362238"
            },
            "category" : 1,
            "transactionDetail" : {
                "description" : "Punkte sammeln",
                "bookingDate" : "2022-03-25T10:59:05+0200",
                "value" : {
                    "amount" : 43,
                    "currency" : "PPP"
                }
            }
        },
        {
            "partnerDisplayName" : "DEPOT",
            "alias" : {
                "reference" : "112676189944193"
            },
            "category" : 2,
            "transactionDetail" : {
                "description" : "Punkte sammeln",
                "bookingDate" : "2022-09-22T10:59:05+0200",
                "value" : {
                    "amount" : 75,
                    "currency" : "PPP"
                }
            }
        },
        {
            "partnerDisplayName" : "Tchibo",
            "alias" : {
                "reference" : "623838250608671"
            },
            "category" : 1,
            "transactionDetail" : {
                "description" : "Punkte sammeln",
                "bookingDate" : "2022-10-24T10:59:05+0200",
                "value" : {
                    "amount" : 12,
                    "currency" : "PPP"
                }
            }
        },
        {
            "partnerDisplayName" : "REWE Group",
            "alias" : {
                "reference" : "075903074248681"
            },
            "category" : 3,
            "transactionDetail" : {
                "description" : "Punkte sammeln",
                "bookingDate" : "2022-11-11T10:59:05+0200",
                "value" : {
                    "amount" : 86,
                    "currency" : "PPP"
                }
            }
        },
        {
            "partnerDisplayName" : "Fressnapf",
            "alias" : {
                "reference" : "468385434897236"
            },
            "category" : 1,
            "transactionDetail" : {
                "bookingDate" : "2022-02-27T10:59:05+0200",
                "value" : {
                    "amount" : 49,
                    "currency" : "PPP"
                }
            }
        },
        {
            "partnerDisplayName" : "dm-dogerie markt",
            "alias" : {
                "reference" : "581595945092529"
            },
            "category" : 1,
            "transactionDetail" : {
                "description" : "Punkte sammeln",
                "bookingDate" : "2022-03-06T10:59:05+0200",
                "value" : {
                    "amount" : 95,
                    "currency" : "PPP"
                }
            }
        },
        {
            "partnerDisplayName" : "Points",
            "alias" : {
                "reference" : "825499612815986"
            },
            "category" : 1,
            "transactionDetail" : {
                "description" : "Punkte sammeln",
                "bookingDate" : "2022-05-19T10:59:05+0200",
                "value" : {
                    "amount" : 83,
                    "currency" : "PPP"
                }
            }
        },
        {
            "partnerDisplayName" : "Tchibo",
            "alias" : {
                "reference" : "451403498102114"
            },
            "category" : 2,
            "transactionDetail" : {
                "description" : "Punkte sammeln",
                "bookingDate" : "2022-08-11T10:59:05+0200",
                "value" : {
                    "amount" : 435,
                    "currency" : "PPP"
                }
            }
        },
        {
            "partnerDisplayName" : "dm-dogerie markt",
            "alias" : {
                "reference" : "951205206244244"
            },
            "category" : 1,
            "transactionDetail" : {
                "description" : "Punkte sammeln",
                "bookingDate" : "2022-03-16T10:59:05+0200",
                "value" : {
                    "amount" : 72,
                    "currency" : "PPP"
                }
            }
        },
        {
            "partnerDisplayName" : "Lieferando",
            "alias" : {
                "reference" : "702978458627351"
            },
            "category" : 1,
            "transactionDetail" : {
                "description" : "Punkte sammeln",
                "bookingDate" : "2022-04-17T10:59:05+0200",
                "value" : {
                    "amount" : 33,
                    "currency" : "PPP"
                }
            }
        },
        {
            "partnerDisplayName" : "OTTO Group",
            "alias" : {
                "reference" : "804558808058663"
            },
            "category" : 1,
            "transactionDetail" : {
                "description" : "Punkte sammeln",
                "bookingDate" : "2022-01-18T10:59:05+0200",
                "value" : {
                    "amount" : 28,
                    "currency" : "PPP"
                }
            }
        },
        {
            "partnerDisplayName" : "OTTO Group",
            "alias" : {
                "reference" : "197908405614495"
            },
            "category" : 2,
            "transactionDetail" : {
                "description" : "Punkte sammeln",
                "bookingDate" : "2022-03-23T10:59:05+0200",
                "value" : {
                    "amount" : 64,
                    "currency" : "PPP"
                }
            }
        },
        {
            "partnerDisplayName" : "Aral",
            "alias" : {
                "reference" : "256857199837641"
            },
            "category" : 1,
            "transactionDetail" : {
                "description" : "Punkte sammeln",
                "bookingDate" : "2022-01-22T10:59:05+0200",
                "value" : {
                    "amount" : 123,
                    "currency" : "PPP"
                }
            }
        },
        {
            "partnerDisplayName" : "REWE Group",
            "alias" : {
                "reference" : "066586128163195"
            },
            "category" : 1,
            "transactionDetail" : {
                "description" : "Punkte sammeln",
                "bookingDate" : "2022-10-24T10:59:05+0200",
                "value" : {
                    "amount" : 456,
                    "currency" : "PPP"
                }
            }
        },
        {
            "partnerDisplayName" : "Aral",
            "alias" : {
                "reference" : "491779356655580"
            },
            "category" : 2,
            "transactionDetail" : {
                "description" : "Punkte sammeln",
                "bookingDate" : "2022-12-24T11:59:05+0200",
                "value" : {
                    "amount" : 74,
                    "currency" : "PPP"
                }
            }
        },
        {
            "partnerDisplayName" : "Penny-Markt",
            "alias" : {
                "reference" : "053297453069759"
            },
            "category" : 2,
            "transactionDetail" : {
                "description" : "Punkte sammeln",
                "bookingDate" : "2022-02-04T10:59:05+0200",
                "value" : {
                    "amount" : 2143,
                    "currency" : "PPP"
                }
            }
        },
        {
            "partnerDisplayName" : "Saturn",
            "alias" : {
                "reference" : "3083421587504918"
            },
            "category" : 2,
            "transactionDetail" : {
                "description" : "Punkte sammeln",
                "bookingDate" : "2022-12-01T10:59:05+0200",
                "value" : {
                    "amount" : 129,
                    "currency" : "PPP"
                }
            }
        }
    ]
}
"""
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return try! decoder.decode(Self.self,
                                   from: jsonString.data(using: .utf8)!)
    }
}

