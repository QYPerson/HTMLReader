//: HTMLReader – A WHATWG-compliant HTML parser
import HTMLReader
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

let homepage = "https://github.com/nolanw/HTMLReader"
URLSession.shared.dataTask(with: URL(string: homepage)!) {
    (data, response, error) in
    var contentType: String? = nil
    if let response = response as? HTTPURLResponse {
        contentType = response.allHeaderFields["Content-Type"] as? String
    }
    if let data = data {
        let home = HTMLDocument(data: data, contentTypeHeader:contentType)
        if let div = home.firstNode(matchingSelector: ".repository-meta-content") {
            print(div.textContent.trimmingCharacters(in: .whitespacesAndNewlines))
        } else {
            print("Failed to match .repository-meta-content, maybe the HTML changed?")
        }
    } else {
        print("No data received, sorry.")
    }
    PlaygroundPage.finishExecution(PlaygroundPage.current)
}.resume()
