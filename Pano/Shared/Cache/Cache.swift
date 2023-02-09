//
//  Cache.swift
//  Pano
//
//  Created by AliReza on 2023-02-08.
//

import Foundation

final class Cache<Key: Hashable, Value> {
    // MARK: - Wrapper
    private let wrapper = NSCache<WrappedKey, Entry>()
    private let dateProvider: () -> Date
    private let entryLifetime: TimeInterval
    private let keyPublisher: KeyPublisher = KeyPublisher()
    // MARK: - Initializer
    init(dateProvider: @escaping () -> Date = Date.init,
         entryLifetime: TimeInterval = 4*60*60,
         maximumEntryCount: Int = 50) {
        self.dateProvider = dateProvider
        self.entryLifetime = entryLifetime
        wrapper.countLimit = maximumEntryCount
        wrapper.delegate = keyPublisher
    }
    // MARK: - Methods
    func insert(_ value: Value, forKey key: Key) {
        let date = dateProvider().addingTimeInterval(entryLifetime)
        let entry = Entry(key: key, value: value, expirationDate: date)
        insert(entry)
    }
    func value(forKey key: Key) -> Value? {
        guard let entry = entry(forKey: key) else {
            return nil
        }
        return entry.value
    }
    func removeValue(forKey key: Key) {
        wrapper.removeObject(forKey: WrappedKey(key: key))
    }
}

private extension Cache {
    func entry(forKey key: Key) -> Entry? {
        guard let entry = wrapper.object(forKey: WrappedKey(key: key)) else {
            return nil
        }
        
        guard dateProvider() < entry.expirationDate else {
            removeValue(forKey: key)
            return nil
        }
        
        return entry
    }
    
    func insert(_ entry: Entry) {
        wrapper.setObject(entry, forKey: WrappedKey(key: entry.key))
        keyPublisher.keys.insert(entry.key)
    }
}

extension Cache {
    subscript(key: Key) -> Value? {
        get { return value(forKey: key)}
        set {
            guard let value = newValue else {
                removeValue(forKey: key)
                return
            }
            insert(value, forKey: key)
        }
    }
}

private extension Cache {
    final class WrappedKey: NSObject {
        let key: Key
        init(key: Key) {
            self.key = key
        }
        override var hash: Int {
            return key.hashValue
        }
        override func isEqual(_ object: Any?) -> Bool {
            guard let value = object as? WrappedKey else {
                return false
            }
            return value.key == key
        }
    }
}

private extension Cache {
    final class Entry {
        let key: Key
        let value: Value
        let expirationDate: Date
        init(key: Key, value: Value, expirationDate: Date) {
            self.key = key
            self.value = value
            self.expirationDate = expirationDate
        }
    }
}

private extension Cache {
    final class KeyPublisher: NSObject, NSCacheDelegate {
        var keys: Set<Key> = Set()
        func cache(_ cache: NSCache<AnyObject, AnyObject>, willEvictObject obj: Any) {
            guard let entry = obj as? Entry else { return }
            keys.remove(entry.key)
        }
    }
}

extension Cache.Entry: Codable where Key: Codable, Value: Codable {
    
}

extension Cache: Codable where Key: Codable, Value: Codable {
    convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.singleValueContainer()
        let entries = try container.decode([Entry].self)
        entries.forEach(insert)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(keyPublisher.keys.compactMap(entry))
    }
}
