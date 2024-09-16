# GroqAPI Xojo Class

The `GroqAPI` class is designed to facilitate interaction with the Groq API for AI model requests. It provides methods to send chat completion requests and retrieve a list of available models, handling the necessary HTTP communication under the hood.

## Features

- **SendChatCompletionRequest:** Sends a POST request to generate chat completions based on provided messages and parameters.
- **GetAvailableModels:** Sends a GET request to retrieve a list of available AI models from the Groq API.
- **AddMessage:** Allows adding user or assistant messages to the request payload, supporting conversation context.
- **CheckContextWindowUsage:** Monitors the usage of the model's context window to ensure efficient token management.

## Installation

To use the `GroqAPI` class in your Xojo project:

1. Download or clone this repository.
2. Open your Xojo project.
3. Drag the `GroqAPI` class file into your Xojo project navigator.
4. Get an API key from Groq.com at [https://console.groq.com/keys](https://console.groq.com/keys)

## Usage

### Drag and Drop the GroqAPI Class

1. **Open your Xojo Project**: Launch Xojo and open your existing project or create a new one.
2. **Import the GroqAPI Class**: Drag the `GroqAPI` class file from your file explorer into the Xojo project navigator on the left side of the Xojo IDE.
3. **Add to a Window**: Drag the `GroqAPI` class from the project navigator onto a window in your project. This creates an instance of `GroqAPI` in that window.

### Set Properties in the Xojo Inspector panel

1. **Select the GroqAPI Instance**: Click on the `GroqAPI` instance in your window to select it.
2. **Open the Inspector Panel**: If the Inspector panel is not already open, you can open it by selecting `View -> Inspector` from the menu.
3. **Set Properties**: In the Inspector panel, you can set the following properties for the `GroqAPI` instance:
   - **ApiKey**: Enter your API key obtained from Groq.com.
   - **Model**: Specify the AI model to use (e.g., `llama-3.1-70b-versatile`).
   - **Temperature**: Set the temperature value to control response randomness.
   - **MaxTokens**: Define the maximum number of tokens for the response.
   - **TopP**: Adjust this to control response diversity.
   - **Memory**: Enable or disable memory to retain previous messages.

### Example Code

```xojo
// Create an instance of the GroqAPI class
Var groqAPI As New GroqAPI

// Set the API key for authentication
groqAPI.ApiKey = "YOUR_API_KEY"

// Set additional parameters if needed
groqAPI.Model = "llama-3.1-70b-versatile"
groqAPI.Temperature = 0.7
groqAPI.MaxTokens = 500

// Attach the event handlers to the events
AddHandler groqAPI.ResponseReceived, AddressOf HandleResponseReceived
AddHandler groqAPI.ErrorReceived, AddressOf HandleErrorReceived

// Send a chat completion request
groqAPI.AddMessage("user", "Hello, can you tell me about the weather today?")
groqAPI.SendChatCompletionRequest

// Retrieve available models
groqAPI.GetAvailableModels

// Define the event handlers
Sub HandleResponseReceived(sender As GroqAPI, ResponseType As String, AvailableData As JSONItem)
  // Process the response
End Sub

Sub HandleErrorReceived(sender As GroqAPI, URL As String, HTTPStatus As Integer, content As String)
  // Handle any errors
End Sub
```

## Properties
- ApiKey: String - Your API key for authentication.
- Model: String - The AI model to use for requests.
- Temperature: Double - Controls randomness in responses.
- MaxTokens: Integer - Maximum number of tokens to generate in the response.
- TopP: Double - Controls diversity of the response.
- Memory: Boolean - Determines if previous messages should be retained.

## Event Hooks
- ResponseReceived: Triggered when a successful API response is received.
- ErrorReceived: Triggered when an error occurs during an API request.

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contributing
Contributions are welcome! Please submit a pull request or open an issue to discuss potential changes.
