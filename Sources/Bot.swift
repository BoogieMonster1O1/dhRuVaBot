
import Foundation
import DiscordKitBot
import Alamofire

@main
public struct Bot {
    
    static let bot = Client(intents: [.unprivileged])
    static let guildId = "1199414187387015249"
    static let NASA_API_KEY = "GIbfW1AsGt0rFtrvbczg" + "9PSee9UxxfHATc5Lb4hJ"

    public static func main() {
        bot.login()
        
        bot.ready.listen {
//            print("Successfully logged in as \(bot.user!.username)#\(bot.user!.discriminator)!")
            do {
                try await registerSlashCommands()
            } catch {
                print("Failed to register slash commands")
                return
            }
        }
        
        RunLoop.main.run()
    }
    
    private static func registerSlashCommands() async throws {
        try await bot.registerApplicationCommands(guild: guildId) {
            NewAppCommand("apod", description: "Fetch the Astronomy Picture Of the Day") { interaction in
                guard let _ = try? await interaction.deferReply() else {
                    return
                }
                
                let response: ApodModel
                
                do {
                    response = try await AF.request("https://api.nasa.gov/planetary/apod", parameters: ["api_key" : NASA_API_KEY])
                        .cacheResponse(using: .cache)
                        .redirect(using: .follow)
                        .validate()
                        .serializingDecodable(ApodModel.self)
                        .response
                        .result.get()
                } catch {
                    print("Could not fetch APOD \(error.localizedDescription)")
                    return
                }
                

                try? await interaction.reply({
                    BotEmbed()
                        .color(0x0099FF)
                        .description(response.explanation)
                        .title(response.title)
                        .footer(response.date)
                        .timestamp(Date.now)
                        .image(response.url)
                })
            }
        }
    }
}
