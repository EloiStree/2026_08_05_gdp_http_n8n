class_name N8nSendPostRequest
extends Node

@export var _n8n_post_http_url:String="https://eloistree.app.n8n.cloud/webhook/79df0e12-3bd5-483a-841c-456c0beb8be4"
@export var _user_name:String="HelloN8N"
@export var _user_password:String="12345678"
@export var _text_content:String="Hello N8N, this is a test message from Godot Engine."

func send_trigger_request():
	var http_request := HTTPRequest.new()
	add_child(http_request)
	http_request.request_completed.connect(_on_request_completed)

	var credentials := "%s:%s" % [_user_name, _user_password]
	var auth_header := "Authorization: Basic %s" % Marshalls.utf8_to_base64(credentials)
	var headers := ["Content-Type: application/json", auth_header]
	var body := {
		"text_content": _text_content
	}
	var json_body := JSON.stringify(body)

	var error := http_request.request(_n8n_post_http_url, headers, HTTPClient.METHOD_POST, json_body)
	if error != OK:
		push_error("An error occurred while sending the POST request: %s" % error)


func _on_request_completed(result: int, response_code: int, headers: PackedStringArray, body: PackedByteArray) -> void:
	if result != HTTPRequest.RESULT_SUCCESS:
		push_error("HTTP request failed with result: %s" % result)
		return

	var response_body := body.get_string_from_utf8()
	print("Response code: %s" % response_code)
	print("Response body: %s" % response_body)

	
