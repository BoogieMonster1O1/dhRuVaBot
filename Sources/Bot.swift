
import Foundation
import DiscordKitBot

@main
public struct Bot {
    
    static let bot = Client(intents: [.unprivileged, .messageContent, .guildMembers])
    static let token = try! String(contentsOfFile: "token.txt")

    public static func main() {
        print("Hello world!")
    }
}
