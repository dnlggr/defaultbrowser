import Foundation
import ArgumentParser
import DefaultBrowserCore

struct CommandLineTool: ParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "default-browser",
        abstract: "Manages the system's default web browser.",
        subcommands: [Set.self, List.self, Current.self]
    )
}

extension CommandLineTool {
    struct Set: ParsableCommand {
        static let configuration = CommandConfiguration(abstract: "Sets the default browser.")

        @Argument(help: "The browser to set as default. Common choices are 'firefox', 'safari', or 'chrome'.")
        var browser: String

        func validate() throws {
            guard !browser.isEmpty else {
                throw ValidationError("'<browser>' must not be empty.")
            }
        }

        func run() throws {
            guard
                let newDefaultBrowser = DefaultBrowser.all.first(where: { $0.bundleId.contains(browser.lowercased()) })
            else {
                print("Error: Could not find a browser '\(browser)'.")
                throw ExitCode.failure
            }

            guard let currentDefault = DefaultBrowser.current, currentDefault != newDefaultBrowser else {
                throw CleanExit.message("'\(browser)' is already the default browser.")
            }

            do {
                try newDefaultBrowser.makeDefault()
            } catch {
                print("Error: Could not set '\(browser)' as default browser. \(error.localizedDescription)")
            }
        }
    }
}

extension CommandLineTool {
    struct List: ParsableCommand {
        static let configuration = CommandConfiguration(abstract: "Lists the available browsers.")

        @Flag(name: .shortAndLong, help: """
            Verbose mode. List the available browsers' names, bundle ids, and paths as comma-separated-values.
            """)
        var verbose: Bool

        func run() {
            DefaultBrowser.all.forEach {
                if verbose {
                    print("\($0.name),\($0.bundleId),\($0.url?.path ?? "")")
                } else {
                    print($0.name)
                }
            }
        }
    }
}

extension CommandLineTool {
    struct Current: ParsableCommand {
        static let configuration = CommandConfiguration(abstract: "Lists the current default browser.")

        func run() throws {
            guard let currentDefault = DefaultBrowser.current else {
                print("Error: Could not get the current default browser.")
                throw ExitCode.failure
            }

            print(currentDefault.name)
        }
    }
}

CommandLineTool.main()
