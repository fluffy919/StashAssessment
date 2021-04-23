//
//  Persistence.swift
//  StashAssessment
//
//  Created by B on 4/19/21.
//

import Foundation
import Combine

fileprivate struct Envelope: Codable {
    let achievements: [Achievement]
}

class Persistence {
    
    var localFile: URL {
        let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("achievements.json")
        print("In case you need to delete the database: \(fileURL)")
        return fileURL
    }

    var defaultFile: URL {
        return Bundle.main.url(forResource: "achievements", withExtension: "json")!
    }
  
    private func clear() {
        try? FileManager.default.removeItem(at: localFile)
    }

    func load() -> AnyPublisher<[Achievement], Never>  {
        if FileManager.default.fileExists(atPath: localFile.standardizedFileURL.path) {
            return Future<[Achievement], Never> { promise in
                self.load(self.localFile) { achievements in
                    DispatchQueue.main.async {
                        promise(.success(achievements))
                    }
                }
            }.eraseToAnyPublisher()
        } else {
            return loadDefault()
        }
    }


    private func loadSynchronously(_ file: URL) -> [Achievement] {
        do {
            let data = try Data(contentsOf: file)
            let envelope = try JSONDecoder().decode(Envelope.self, from: data)
            return envelope.achievements
        } catch {
            clear()
            return loadSynchronously(defaultFile)
        }
    }

    private func load(_ file: URL, completion: @escaping ([Achievement]) -> Void) {
        DispatchQueue.global(qos: .background).async {
            let achievements = self.loadSynchronously(file)
            completion(achievements)
        }
    }

    func loadDefault(synchronous: Bool = false) -> AnyPublisher<[Achievement], Never> {
        if synchronous {
            return Just<[Achievement]>(loadSynchronously(defaultFile)).eraseToAnyPublisher()
        }
        return Future<[Achievement], Never> { promise in
            self.load(self.defaultFile) { achievements in
                DispatchQueue.main.async {
                    promise(.success(achievements))
                }
            }
        }.eraseToAnyPublisher()
    }
}
