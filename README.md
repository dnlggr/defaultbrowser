# defaultbrowser 💻 🚀 🌍

Swift script and Alfred workflow to change the default browser on macOS.

## Swift

To run the Swift script: 

1. 🚧 Make it executable: `chmod +x defaultbrowser.swift`
2. 🚀 Run it: `./defaultbrowser <browser>
3. 👍 Acknowledge the system popup asking you if you're sure what you're doing.

### Examples

Change the default browser to *Chrome*:

``` bash
./defaultbrowser.swift chrome
``` 

Change the dfault browser to *Safari*:

``` bash
./defaultbrowser.swift safari
``` 

You get the point.

## Alfred Workflow

Download the repository and open the `defaultbrowser.alfredworkflow` file. The keyword is `db` and expects the browser you want to set as default as an argument.

At the moment, the workflow is very basic. Nice features would be:

- Showing the matching available browsers while typing such as [this](https://github.com/ngreenstein/alfred-process-killer) workflow that shows matching processes while typing.
- A cool icon.
- Anything more you might like.

## Contributing

🤓 Feel free to share ideas, criticism and open pull requests.
