#tag DesktopWindow
Begin DesktopWindow wndConversation
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF
   Composite       =   False
   DefaultLocation =   2
   FullScreen      =   False
   HasBackgroundColor=   False
   HasCloseButton  =   True
   HasFullScreenButton=   False
   HasMaximizeButton=   False
   HasMinimizeButton=   True
   Height          =   260
   ImplicitInstance=   True
   MacProcID       =   0
   MaximumHeight   =   32000
   MaximumWidth    =   32000
   MenuBar         =   446451711
   MenuBarVisible  =   False
   MinimumHeight   =   260
   MinimumWidth    =   388
   Resizeable      =   True
   Title           =   "Groq API"
   Type            =   0
   Visible         =   True
   Width           =   388
   Begin GroqAPI Groq
      AllowCertificateValidation=   False
      ApiKey          =   ""
      HTTPStatusCode  =   0
      Index           =   -2147483648
      LockedInPosition=   False
      MaxTokens       =   1024
      max_context_tokens=   8192
      Memory          =   True
      Model           =   "llama-3.1-8b-instant"
      Scope           =   0
      TabPanelIndex   =   "0"
      Temperature     =   1.0
      TopP            =   1.0
   End
   Begin DesktopRectangle ContentWrapper
      AllowAutoDeactivate=   True
      BorderColor     =   &cC8C8C800
      BorderThickness =   1.0
      CornerSize      =   16.0
      Enabled         =   True
      FillColor       =   &cFFFFFF
      Height          =   239
      Index           =   -2147483648
      Left            =   10
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   0
      TabIndex        =   0
      TabPanelIndex   =   0
      Tooltip         =   ""
      Top             =   11
      Transparent     =   False
      Visible         =   True
      Width           =   370
      Begin DesktopTextArea ResponsesTextArea
         AllowAutoDeactivate=   True
         AllowFocusRing  =   False
         AllowSpellChecking=   True
         AllowStyledText =   True
         AllowTabs       =   False
         BackgroundColor =   &cFFFFFF
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Format          =   ""
         HasBorder       =   False
         HasHorizontalScrollbar=   False
         HasVerticalScrollbar=   True
         Height          =   152
         HideSelection   =   True
         Index           =   -2147483648
         InitialParent   =   "ContentWrapper"
         Italic          =   False
         Left            =   30
         LineHeight      =   0.0
         LineSpacing     =   1.0
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         MaximumCharactersAllowed=   0
         Multiline       =   True
         ReadOnly        =   True
         Scope           =   0
         TabIndex        =   3
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   ""
         TextAlignment   =   0
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   45
         Transparent     =   False
         Underline       =   False
         UnicodeMode     =   1
         ValidationMask  =   ""
         Visible         =   True
         Width           =   330
      End
      Begin DesktopTextField UserMessageTextField
         AllowAutoDeactivate=   True
         AllowFocusRing  =   False
         AllowSpellChecking=   False
         AllowTabs       =   False
         BackgroundColor =   &cFFFFFF
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Format          =   ""
         HasBorder       =   True
         Height          =   30
         Hint            =   ""
         Index           =   -2147483648
         InitialParent   =   "ContentWrapper"
         Italic          =   False
         Left            =   30
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   False
         MaximumCharactersAllowed=   0
         Password        =   False
         ReadOnly        =   False
         Scope           =   0
         TabIndex        =   0
         TabPanelIndex   =   0
         TabStop         =   True
         Text            =   ""
         TextAlignment   =   0
         TextColor       =   &c000000
         Tooltip         =   ""
         Top             =   209
         Transparent     =   False
         Underline       =   False
         ValidationMask  =   ""
         Visible         =   True
         Width           =   272
      End
      Begin DesktopButton SendButton
         AllowAutoDeactivate=   True
         Bold            =   False
         Cancel          =   False
         Caption         =   "OK"
         Default         =   True
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   30
         Index           =   -2147483648
         InitialParent   =   "ContentWrapper"
         Italic          =   False
         Left            =   305
         LockBottom      =   True
         LockedInPosition=   False
         LockLeft        =   False
         LockRight       =   True
         LockTop         =   False
         MacButtonStyle  =   0
         Scope           =   0
         TabIndex        =   1
         TabPanelIndex   =   0
         TabStop         =   True
         Tooltip         =   ""
         Top             =   209
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   55
      End
      Begin DesktopPopupMenu ModelsPopupMenu
         AllowAutoDeactivate=   True
         Bold            =   False
         Enabled         =   True
         FontName        =   "System"
         FontSize        =   0.0
         FontUnit        =   0
         Height          =   22
         Index           =   -2147483648
         InitialParent   =   "ContentWrapper"
         InitialValue    =   ""
         Italic          =   False
         Left            =   10
         LockBottom      =   False
         LockedInPosition=   False
         LockLeft        =   True
         LockRight       =   True
         LockTop         =   True
         Scope           =   0
         SelectedRowIndex=   0
         TabIndex        =   4
         TabPanelIndex   =   0
         TabStop         =   True
         Tooltip         =   ""
         Top             =   11
         Transparent     =   False
         Underline       =   False
         Visible         =   True
         Width           =   370
      End
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Opening()
		  Groq.GetAvailableModels
		End Sub
	#tag EndEvent


#tag EndWindowCode

#tag Events Groq
	#tag Event , Description = 507572706F73653A2054686973206576656E7420697320747269676765726564207768656E2061207375636365737366756C2041504920726573706F6E736520697320726563656976656420616E642070726F6365737365642E0D0A506172616D65746572733A0D0A2D20526573706F6E7365547970653A204120737472696E6720696E6469636174696E67207468652074797065206F6620726573706F6E73652C20737563682061732022636861742E636F6D706C6574696F6E22206F722022617661696C61626C652E6D6F64656C73222E0D0A2D20417661696C61626C65446174613A2041204A534F4E4974656D20636F6E7461696E696E67207468652064617461206578747261637465642066726F6D207468652041504920726573706F6E73652E0D0A0D0A446576656C6F706572732073686F756C6420696D706C656D656E742074686973206576656E7420696E207468656972206170706C69636174696F6E20746F2068616E646C6520616E6420646973706C617920746865206461746120617070726F7072696174656C792E0D0A466F72206578616D706C652C20796F75206D696768742075706461746520746865207573657220696E74657266616365207769746820746865206368617420636F6D706C6574696F6E20726573756C7473206F72206C69737420617661696C61626C65206D6F64656C732E
		Sub ResponseReceived(ResponseType As String, AvailableData As JSONItem)
		  Select Case ResponseType
		  Case "chat.completion"
		    ResponsesTextArea.Text = ""
		    
		    // Iterate over each item in the JSON array
		    For i As Integer = 0 To AvailableData.Count - 1
		      // Get the current JSON object
		      Var message As JSONItem = AvailableData.ChildAt(i)
		      
		      // Extract role and content
		      Var role As String = message.Value("role")
		      Var content As String = message.Value("content")
		      
		      // Add the message to the text area
		      ResponsesTextArea.SelectionBold = True
		      ResponsesTextArea.SelectionTextColor = Color.RGB(103, 174, 46)
		      ResponsesTextArea.AddText(role.Uppercase + ":" + EndOfLine)
		      ResponsesTextArea.SelectionTextColor= Color.RGB(0, 0, 0)
		      ResponsesTextArea.SelectionBold = False
		      ResponsesTextArea.AddText(content + EndOfLine)
		    Next
		    
		    // Prepare the front end of the app
		    UserMessageTextField.Text = ""
		    UserMessageTextField.Visible = True
		    UserMessageTextField.SetFocus
		    
		  Case "available.models"
		    ModelsPopupMenu.RemoveAllRows
		    For i As Integer = 0 To AvailableData.Count - 1
		      Var id As String = AvailableData.ChildAt(i).Value("id")
		      Var context_window As Integer = AvailableData.ChildAt(i).Value("context_window").IntegerValue
		      Var dmi As New DesktopMenuItem
		      dmi.Text = id
		      dmi.Tag = context_window
		      ModelsPopupMenu.AddRow(dmi)
		    Next
		  End Select
		End Sub
	#tag EndEvent
	#tag Event , Description = 507572706F73653A2054686973206576656E7420697320747269676765726564207768656E20616E206572726F72206F636375727320647572696E6720616E2041504920726571756573742E0D0A506172616D65746572733A0D0A2D2055524C3A204120737472696E6720726570726573656E74696E67207468652055524C206F662074686520726571756573742074686174206661696C65642E0D0A2D20485454505374617475733A20416E20696E746567657220726570726573656E74696E672074686520485454502073746174757320636F64652072657475726E656420627920746865207365727665722E0D0A2D20636F6E74656E743A204120737472696E6720636F6E7461696E696E6720616E79206572726F72206D657373616765206F72206164646974696F6E616C20696E666F726D6174696F6E2070726F766964656420627920746865207365727665722E0D0A0D0A446576656C6F706572732073686F756C6420696D706C656D656E742074686973206576656E7420746F2068616E646C65206572726F727320677261636566756C6C7920696E207468656972206170706C69636174696F6E2E0D0A54686973206D6967687420696E636C75646520646973706C6179696E6720616E206572726F72206D65737361676520746F2074686520757365722C206C6F6767696E6720746865206572726F7220666F7220646562756767696E6720707572706F7365732C206F722074616B696E6720636F727265637469766520616374696F6E73206261736564206F6E20746865207370656369666963206572726F7220656E636F756E74657265642E
		Sub ErrorReceived(URL As String, HTTPStatus As Integer, content As String)
		  UserMessageTextField.Visible = True
		  
		  Var json As New JSONItem(content)
		  Var error As JSONItem = json.Child("error")
		  Var message As String = error.Value("message")
		  
		  
		  MessageBox("Error code: " + HTTPStatus.ToString + EndOfLine + message)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events SendButton
	#tag Event
		Sub Pressed()
		  If UserMessageTextField.Text.IsEmpty = False Then
		    Try
		      Groq.AddMessage(UserMessageTextField.Text.Trim)
		      Groq.SendChatCompletionRequest
		      UserMessageTextField.Visible = False
		    Catch e As NilObjectException
		      MessageBox e.Message
		    End Try
		  Else
		    UserMessageTextField.SetFocus
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events ModelsPopupMenu
	#tag Event
		Sub SelectionChanged(item As DesktopMenuItem)
		  // Set the model to be used
		  Groq.Model = item.Text
		  // Set the max context tokens allowed by the model
		  Groq.max_context_tokens = item.Tag
		End Sub
	#tag EndEvent
#tag EndEvents
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
		Name="Interfaces"
		Visible=true
		Group="ID"
		InitialValue=""
		Type="String"
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
		Name="Width"
		Visible=true
		Group="Size"
		InitialValue="600"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=true
		Group="Size"
		InitialValue="400"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumWidth"
		Visible=true
		Group="Size"
		InitialValue=" 600"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumHeight"
		Visible=true
		Group="Size"
		InitialValue=" 400"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaximumWidth"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaximumHeight"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Type"
		Visible=true
		Group="Frame"
		InitialValue="0"
		Type="Types"
		EditorType="Enum"
		#tag EnumValues
			"0 - Document"
			"1 - Movable Modal"
			"2 - Modal Dialog"
			"3 - Floating Window"
			"4 - Plain Box"
			"5 - Shadowed Box"
			"6 - Rounded Window"
			"7 - Global Floating Window"
			"8 - Sheet Window"
			"9 - Modeless Dialog"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="Title"
		Visible=true
		Group="Frame"
		InitialValue="Untitled"
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasCloseButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasMaximizeButton"
		Visible=true
		Group="Frame"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasMinimizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasFullScreenButton"
		Visible=true
		Group="Frame"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Resizeable"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Composite"
		Visible=false
		Group="OS X (Carbon)"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MacProcID"
		Visible=false
		Group="OS X (Carbon)"
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="FullScreen"
		Visible=true
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="DefaultLocation"
		Visible=true
		Group="Behavior"
		InitialValue="2"
		Type="Locations"
		EditorType="Enum"
		#tag EnumValues
			"0 - Default"
			"1 - Parent Window"
			"2 - Main Screen"
			"3 - Parent Window Screen"
			"4 - Stagger"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="Visible"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="ImplicitInstance"
		Visible=true
		Group="Window Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasBackgroundColor"
		Visible=true
		Group="Background"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="BackgroundColor"
		Visible=true
		Group="Background"
		InitialValue="&cFFFFFF"
		Type="ColorGroup"
		EditorType="ColorGroup"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Backdrop"
		Visible=true
		Group="Background"
		InitialValue=""
		Type="Picture"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBar"
		Visible=true
		Group="Menus"
		InitialValue=""
		Type="DesktopMenuBar"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBarVisible"
		Visible=true
		Group="Deprecated"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
