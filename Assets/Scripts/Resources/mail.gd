extends Resource
class_name mail_resource

@export var senderName:String
@export var subject:String
@export_multiline var body:String



func sendMail(mail):
	pass
#	mailSystem.receiveMail(mail)

func receiveMail(mail:mail_resource):
	pass
