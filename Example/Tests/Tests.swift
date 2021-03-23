import XCTest
@testable import DrunkenBishop

class Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testShortString() {
        let bishop = DrunkenBishop()
        let text = "308204BC020100300DeF7aaaa787899"
        print(bishop.representation(from: text))
    }
    
    func testLongString() {
        let bishop = DrunkenBishop()
        let text = "308204BC020100300DeF7aaaa787899aaaaaaaaa"
        print(bishop.representation(from: text))
    }
    
    func testPublicKey() {
        let bishop = DrunkenBishop()
        let key = """
-----BEGIN PUBLIC KEY-----\nMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAunbwbK9yvJWbd6XS1b9a\nzjpiqZwB0Nt5Xcg2freCfI4aMl0iJyl0OAqMJpeUPNDs9S3I2gYqsX6NMCmEMnIX\nTB7BYSLtZTKuUpycF6jrBRSDRoWOkKJ6Tob8fKsy8VI1MWhp8K3Whg0R0lP0ut57\nOzAbcuAPhCIpCgOUr7gKlG9r5GFjof2Y63w05izZahvUuREPr6V2l/sG70xwJUiO\nyVlH23oVm/dQjE+jmlvDknGakKj3+jV63jgpeshbzU13RbfwRmwDIBKOS/NnvmIj\n47H0LchDdG8m2ttZUPGF01bydbvKVKz7m1nA/5iQoIuVSc0MbxZE20kIpNhyKAsn\n5ujKYG1i+SQHD8UrRF7bm0T33QCDzTxFS9tmRc4Curai4U0HX715WcOWdhPFM4IY\nH4qR0kbMCLbMbXJKo8WT6GuQr0ezlxeskgv0isODlIgCZ0SUB27qRZu/L/3xUyBY\nyIBQwVJV2ROC34En4RnbRmWHt6gb7gi3AqVSuM1skc3qiEtOrwnjtjUIKomA88UG\nXjY3tx9pCw0dUoi7Pze5V9U4RQnUMl28iDVFXCeKGd7rhIQrbXNua/+2ayQfdfYC\n7c36+4Lxj0yzabWIe8jLGh/d/oegfvwcVJ6wPJbZV0i7MInN5nVvQ/ohY1ZsjJvt\nQFnGM8+fIQY5opqLlA+91ukCAwEAAQ==\n-----END PUBLIC KEY-----
"""
        print(bishop.representation(with: key))
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure() {
            // Put the code you want to measure the time of here.
        }
    }
    
}
