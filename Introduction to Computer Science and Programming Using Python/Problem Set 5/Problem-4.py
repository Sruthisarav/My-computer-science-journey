def decrypt_story():
	story=get_story_string()
	decryptStory=CiphertextMessage(story)
	return decryptStory.decrypt_message()
	