#tag Class
Protected Class GroqAPI
Inherits URLConnection
	#tag Event
		Sub ContentReceived(URL As String, HTTPStatus As Integer, content As String)
		  // Handle the response based on the HTTP status code.
		  Select Case HTTPStatus
		  Case 200 // The request was successfully executed.
		    Try
		      // Parse the response content into a JSONItem for processing.
		      Var json As New JSONItem(content)
		      
		      // Determine the type of API response based on the "object" field in the JSON.
		      Var type As String = json.Value("object")
		      
		      // Process the response based on its type.
		      Select Case type
		      Case "chat.completion"
		        // Navigate to the "choices" array within the response.
		        Var choices As JSONItem = json.Value("choices")
		        
		        // Extract the first element of the "choices" array.
		        Var firstChoice As JSONItem = choices.ChildAt(0)
		        
		        // Extract the "message" JSONItem from the first choice.
		        Var message As JSONItem = firstChoice.Value("message")
		        
		        // Optionally, store the finish_reason for further development.
		        Var finish_reason As String = firstChoice.Value("finish_reason")
		        
		        // Add the extracted message to the pMessages list.
		        pMessages.Add(message)
		        
		        // Extract role and content from the message for processing or display.
		        Var mRole As String = message.Value("role")
		        Var mContent As String = message.Value("content")
		        
		        // Trigger the ResponseReceived event with the updated messages.
		        ResponseReceived("chat.completion", pMessages)
		        
		        // Extract and process usage information from the response.
		        Var usage As JSONItem = json.Value("usage")
		        Var total_tokens As Integer = usage.Value("total_tokens")
		        
		        // Check the context window usage based on the total tokens used.
		        CheckContextWindowUsage(total_tokens)
		        
		      Case "list"
		        // Handle responses that list available models.
		        Var data As JSONItem = json.Value("data")
		        
		        // Trigger the ResponseReceived event with the model list data.
		        ResponseReceived("available.models", data)
		      End Select
		      
		    Catch e As JSONException
		      // Handle JSON parsing errors here
		      System.DebugLog("JSON Parsing Error: " + e.Message)
		      ErrorReceived(URL, HTTPStatus, content)
		    End Try
		    
		  Else
		    // Handle non-200 HTTP status codes, which likely indicate an error.
		    ErrorReceived(URL, HTTPStatus, content)
		  End Select
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub AddMessage(role As String = "user", content As String)
		  // Validate the role parameter to ensure it's an expected value.
		  Select Case role
		  Case "user", "assistant", "system"
		    // Valid roles, continue processing
		  Else
		    // Handle invalid role
		    System.DebugLog("Invalid role provided: " + role)
		    Return
		  End Select
		  
		  // Validate the content parameter to ensure it's not empty.
		  If content.Trim.IsEmpty Then
		    System.DebugLog("Content cannot be empty.")
		    Return
		  End If
		  
		  // Check the Memory property to determine if previous messages should be retained.
		  // If Memory is False, clear the current messages to start a new conversation context.
		  If Memory = False Then
		    pMessages.RemoveAll
		  End If
		  
		  // Create a new JSONItem to represent a message.
		  // Each message consists of a role and corresponding content.
		  Var message As New JSONItem
		  message.Value("role") = role
		  message.Value("content") = content
		  
		  // Add the constructed message to the pMessages JSON array.
		  // pMessages holds the conversation history or the messages to be sent in the next API request.
		  pMessages.Add(message)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub CheckContextWindowUsage(total_tokens As Integer)
		  // Calculate the percentage of the context window that has been used.
		  // This is based on the total_tokens provided by the API response and the maximum context window size.
		  Var percentageUsed As Double = (total_tokens / max_context_tokens) * 100
		  
		  // Log the percentage of the context window that has been used.
		  // This information is useful for debugging and ensuring that the model's token usage stays within acceptable limits.
		  System.DebugLog(CurrentMethodName + ": Percentage Used: " + percentageUsed.ToString + "%")
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  // Initialize the pMessages property as a new JSONItem.
		  // This will be used to store the messages that form the body of the chat completion request.
		  pMessages = New JSONItem
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ConstructRequestBody() As String
		  // Create a new JSONItem to construct the request body.
		  Var json As New JSONItem
		  
		  // Retrieve the messages stored in pMessages.
		  // These represent the dialogue history or context for the chat completion request.
		  Var m As JSONItem = pMessages
		  
		  // Add the messages to the JSON request body.
		  json.Value("messages") = m
		  
		  // Set the model to be used for the chat completion based on the Model property.
		  json.Value("model") = Model
		  
		  // Set the temperature for the response generation.
		  // Higher values indicate more randomness in the responses.
		  json.Value("temperature") = Temperature
		  
		  // Set the maximum number of tokens to generate in the response.
		  json.Value("max_tokens") = MaxTokens
		  
		  // Set the top_p parameter to control the diversity of the response.
		  json.Value("top_p") = TopP
		  
		  // Set any stop conditions for the response generation.
		  // These can be used to truncate the response at specific tokens or sequences.
		  json.Value("stop") = Stop
		  
		  // Convert the constructed JSONItem to a string representation for sending in the request.
		  Return json.ToString
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub GetAvailableModels()
		  // Check if the API key is provided before making the request.
		  // The API key is required for authenticating the request with the Groq API.
		  If ApiKey.IsEmpty = False Then
		    // Define the URL endpoint for retrieving available models.
		    Var url As String = "https://api.groq.com/openai/v1/models"
		    
		    // Set the necessary headers for the HTTP request.
		    // 'Content-Type' specifies that the request expects JSON data.
		    Self.RequestHeader("Content-Type") = "application/json"
		    // 'Authorization' uses the Bearer token method to authenticate with the API.
		    Self.RequestHeader("Authorization") = "Bearer " + ApiKey
		    
		    // Send the GET request to the API endpoint.
		    // This request retrieves a list of available models from the API.
		    Self.Send("GET", url)
		  Else
		    // Raise an exception if no API key is provided.
		    // This prevents unauthorized requests from being sent.
		    Var e As New NilObjectException
		    e.Message = "No API key was provided."
		    Raise e
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SendChatCompletionRequest()
		  // Check if the API key is provided before proceeding.
		  // The API key is essential for authenticating the request with the server.
		  If ApiKey.IsEmpty = False Then
		    // Define the URL endpoint for the chat completion request.
		    Var url As String = "https://api.groq.com/openai/v1/chat/completions"
		    
		    // Construct the request body using the ConstructRequestBody method.
		    // This includes the messages and other parameters needed by the API.
		    Var requestBody As String = ConstructRequestBody()
		    
		    // Set the necessary headers for the HTTP request.
		    // 'Content-Type' specifies that the request body is in JSON format.
		    Self.RequestHeader("Content-Type") = "application/json"
		    // 'Authorization' uses the Bearer token method to authenticate with the API.
		    Self.RequestHeader("Authorization") = "Bearer " + ApiKey
		    
		    // Attach the constructed JSON request body to the request.
		    Self.SetRequestContent(requestBody, "application/json")
		    
		    // Send the POST request to the API endpoint.
		    // This triggers the API to process the chat completion request.
		    Self.Send("POST", url)
		  Else
		    // Raise an exception if no API key is provided.
		    // This prevents the request from being sent without proper authentication.
		    Var e As New NilObjectException
		    e.Message = "No API key was provided."
		    Raise e
		  End If
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0, Description = 507572706F73653A2054686973206576656E7420697320747269676765726564207768656E20616E206572726F72206F636375727320647572696E6720616E2041504920726571756573742E0D0A506172616D65746572733A0D0A2D2055524C3A204120737472696E6720726570726573656E74696E67207468652055524C206F662074686520726571756573742074686174206661696C65642E0D0A2D20485454505374617475733A20416E20696E746567657220726570726573656E74696E672074686520485454502073746174757320636F64652072657475726E656420627920746865207365727665722E0D0A2D20636F6E74656E743A204120737472696E6720636F6E7461696E696E6720616E79206572726F72206D657373616765206F72206164646974696F6E616C20696E666F726D6174696F6E2070726F766964656420627920746865207365727665722E0D0A0D0A446576656C6F706572732073686F756C6420696D706C656D656E742074686973206576656E7420746F2068616E646C65206572726F727320677261636566756C6C7920696E207468656972206170706C69636174696F6E2E0D0A54686973206D6967687420696E636C75646520646973706C6179696E6720616E206572726F72206D65737361676520746F2074686520757365722C206C6F6767696E6720746865206572726F7220666F7220646562756767696E6720707572706F7365732C206F722074616B696E6720636F727265637469766520616374696F6E73206261736564206F6E20746865207370656369666963206572726F7220656E636F756E74657265642E
		Event ErrorReceived(URL As String, HTTPStatus As Integer, content As String)
	#tag EndHook

	#tag Hook, Flags = &h0, Description = 507572706F73653A2054686973206576656E7420697320747269676765726564207768656E2061207375636365737366756C2041504920726573706F6E736520697320726563656976656420616E642070726F6365737365642E0D0A506172616D65746572733A0D0A2D20526573706F6E7365547970653A204120737472696E6720696E6469636174696E67207468652074797065206F6620726573706F6E73652C20737563682061732022636861742E636F6D706C6574696F6E22206F722022617661696C61626C652E6D6F64656C73222E0D0A2D20417661696C61626C65446174613A2041204A534F4E4974656D20636F6E7461696E696E67207468652064617461206578747261637465642066726F6D207468652041504920726573706F6E73652E0D0A0D0A446576656C6F706572732073686F756C6420696D706C656D656E742074686973206576656E7420696E207468656972206170706C69636174696F6E20746F2068616E646C6520616E6420646973706C617920746865206461746120617070726F7072696174656C792E0D0A466F72206578616D706C652C20796F75206D696768742075706461746520746865207573657220696E74657266616365207769746820746865206368617420636F6D706C6574696F6E20726573756C7473206F72206C69737420617661696C61626C65206D6F64656C732E
		Event ResponseReceived(ResponseType As String, AvailableData As JSONItem)
	#tag EndHook


	#tag Note, Name = About
		# GroqAPI Xojo Class
		Official GitHub repository at: https://github.com/xojo/GroqAPI
		
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
		   - **ApiKey**: Enter your API key obtained from Groq.com at [https://console.groq.com/keys](https://console.groq.com/keys)
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
		
	#tag EndNote


	#tag Property, Flags = &h0
		ApiKey As String
	#tag EndProperty

	#tag Property, Flags = &h0
		MaxTokens As Integer = 1024
	#tag EndProperty

	#tag Property, Flags = &h0
		max_context_tokens As Integer = 8192
	#tag EndProperty

	#tag Property, Flags = &h0
		Memory As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h0
		Model As String = "llama-3.1-70b-versatile"
	#tag EndProperty

	#tag Property, Flags = &h21
		Private pMessages As JSONItem
	#tag EndProperty

	#tag Property, Flags = &h0
		Stop As Variant = Nil
	#tag EndProperty

	#tag Property, Flags = &h0
		Temperature As Double = 1.0
	#tag EndProperty

	#tag Property, Flags = &h0
		TopP As Double = 1.0
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ApiKey"
			Visible=true
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Model"
			Visible=true
			Group="Behavior"
			InitialValue="llama-3.1-70b-versatile"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Memory"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="MaxTokens"
			Visible=true
			Group="Behavior"
			InitialValue="1024"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Temperature"
			Visible=true
			Group="Behavior"
			InitialValue="1.0"
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TopP"
			Visible=true
			Group="Behavior"
			InitialValue="1.0"
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowCertificateValidation"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HTTPStatusCode"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="max_context_tokens"
			Visible=false
			Group="Behavior"
			InitialValue="8192"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
