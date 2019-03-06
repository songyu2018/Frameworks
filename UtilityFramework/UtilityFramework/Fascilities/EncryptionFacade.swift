//
//  KeychainFacade.swift
//  AsymmetricCrypto
//
//

import Foundation
import Security

public enum EncryptionFacadeError: Error {
    case keyGenerationError
    case failure(status: OSStatus)
    case noPublicKey
    case noPrivateKey
    case unsupported(algorithm: SecKeyAlgorithm)
    case unsupportedInput
    case forwarded(Error)
    case unknown
}


public class EncryptionFacade {
    lazy var privateKey: SecKey? = {
        guard let key = try? retrievePrivateKey(),
            key != nil else {
                return try? generatePrivateKey()
        }
        return key
    }()
    
    
    lazy var publicKey: SecKey? = {
        guard let key = privateKey else {
            return nil
        }

        return SecKeyCopyPublicKey(key)
    }()
    
    private static let tagData = "com.asymmetricCrypto.keys.mykey".data(using: String.Encoding.utf8)!
    private let keyAttributes: [String: Any] = [kSecAttrType as String: kSecAttrKeyTypeRSA,
                                                kSecAttrKeySizeInBits as String: 2048,
                                                kSecAttrApplicationTag as String: tagData,
                                                kSecPrivateKeyAttrs as String: [kSecAttrIsPermanent as String: true]]
    
    private func generatePrivateKey() throws -> SecKey {
        guard let privateKey = SecKeyCreateRandomKey(keyAttributes as CFDictionary, nil) else {
            throw EncryptionFacadeError.keyGenerationError
        }
        
        return privateKey
    }
    
    private func retrievePrivateKey() throws -> SecKey? {
        let privateKeyQuery: [String: Any] = [kSecClass as String: kSecClassKey,
                                              kSecAttrApplicationTag as String: EncryptionFacade.tagData,
                                              kSecAttrKeyType as String: kSecAttrKeyTypeRSA,
                                              kSecReturnRef as String: true]
        
        var privateKeyRef: CFTypeRef?
        let status = SecItemCopyMatching(privateKeyQuery as CFDictionary, &privateKeyRef)
        guard status == errSecSuccess else {
            if status == errSecItemNotFound {
                return nil
            } else {
                throw KeychainFacadeError.failure(status: status)
            }
        }
        
        return privateKeyRef != nil ? (privateKeyRef as! SecKey) : nil
    }
    
    public func encrypt(text: String) throws -> Data? {
        guard let secKey = publicKey else {
            throw EncryptionFacadeError.noPublicKey
        }
        
        let algorithm = SecKeyAlgorithm.rsaEncryptionOAEPSHA512
        
        guard SecKeyIsAlgorithmSupported(secKey, .encrypt, algorithm) else {
            throw EncryptionFacadeError.unsupported(algorithm: algorithm)
        }
        
        guard let textData = text.data(using: .utf8) else {
            throw EncryptionFacadeError.unsupportedInput
        }
        
        var error: Unmanaged<CFError>?
        guard let encryptedTextData = SecKeyCreateEncryptedData(secKey, algorithm, textData as CFData, &error) as Data? else {
            if let encryptionError = error {
                throw EncryptionFacadeError.forwarded(encryptionError.takeRetainedValue() as Error)
            } else {
                throw EncryptionFacadeError.unknown
            }
        }
        
        return encryptedTextData
    }
    
    public func decrypt(data: Data) throws -> Data? {
        guard let secKey = privateKey else {
            throw EncryptionFacadeError.noPrivateKey
        }
        
        let algorithm = SecKeyAlgorithm.rsaEncryptionOAEPSHA512
        
        guard SecKeyIsAlgorithmSupported(secKey, .decrypt, algorithm) else {
            throw EncryptionFacadeError.unsupported(algorithm: algorithm)
        }

        var error: Unmanaged<CFError>?
        guard let decryptedData = SecKeyCreateDecryptedData(secKey, algorithm, data as CFData, &error) as Data? else {
            if let decryptionError = error {
                throw EncryptionFacadeError.forwarded(decryptionError.takeRetainedValue() as Error)
            } else {
                throw EncryptionFacadeError.unknown
            }
        }
        return decryptedData
    }
    
    
    public func exportPublicKey() -> String {
        var error:Unmanaged<CFError>?
        if let key = self.publicKey {
            if let cfdata = SecKeyCopyExternalRepresentation(key, &error) {
                let data:Data = cfdata as Data
                let b64Key = data.base64EncodedString()
                //print(b64Key)
                
                return b64Key
            }
        }
        return ""
    }
    
    
    public func importPublicKey(b64Key: String) {
        guard let data = Data.init(base64Encoded: b64Key) else {
            return
        }
        
        let keyAttributes:[NSObject:NSObject] = [kSecAttrKeyType: kSecAttrKeyTypeRSA,
                                                 kSecAttrKeyClass: kSecAttrKeyClassPublic,
                                                 kSecAttrKeySizeInBits: NSNumber(value: 2048),
                                                 kSecReturnPersistentRef: true as NSObject
        ]
        
        guard let publicKey = SecKeyCreateWithData(data as CFData, keyAttributes as CFDictionary, nil) else {
            return
        }
        print(publicKey)
        self.publicKey = publicKey;
    }
    
}












