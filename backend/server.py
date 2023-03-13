import openai
import os
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from fastapi.staticfiles import StaticFiles
from pydantic import BaseModel

HOST_NAME = os.environ.get('TALK2ME_HOSTNAME')
openai.api_key = os.environ.get('OPENAI_APIKEY')

def setup_conversation(language='English', occupation='student', conversation_tone='casual', name=''):
    x = ""
    if name != '':
        x = f"Your name is {name}. "
    return f"{x}You are a {language} {occupation} who wants to have a {conversation_tone} conversation with the user. First you will introduce yourself. You will give yourself a name and backstory. Then, throughout the conversation, you will respond in {language}. You are not an AI model. Do not break character unless the user says you can.  Don't have a conversation with yourself. When the user ends the conversation, tell them how well they communicated. Finally, go into detail over the user's spelling and grammar mistakes."

conversations = {
    "ru-RU": [{"role": "system", "content": setup_conversation('Russian')}],
    "en-US": [{"role": "system", "content": setup_conversation('English')}],
    "fr-FR": [{"role": "system", "content": setup_conversation('French')}],
    "es-ES": [{"role": "system", "content": setup_conversation('Spanish')}],
    "Anastasia": [{"role": "system", "content": setup_conversation('Russian', 'student', 'intellectual', 'Anastasia')}],
    "Johnathan": [{"role": "system", "content": setup_conversation('Spanish', 'engineer', 'serious', 'Maria')}],
    "Adele": [{"role": "system", "content": setup_conversation('French', 'painting artist', 'casual', 'Adele')}],
}

app = FastAPI()

i = 0

origins = [
    "http://localhost",
    "http://localhost:8080",
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

class VoiceRequest(BaseModel):
    text: str
    language: str

@app.get("/")
async def root():
    return {"message": "Hello World"}

@app.post("/generate-response")
async def generate_response(req: VoiceRequest):
    '''
    m = r.get("messages")
    messages = json.dumps(m)
    r.set('session_1', messages)
    '''
    global conversations
    conversations[req.language].append({"role": "user", "content": req.text})

    response = openai.ChatCompletion.create(
        model="gpt-3.5-turbo",
        messages=conversations[req.language]
    )
    message_response = response['choices'][0]['message']['content']
    conversations[req.language].append({"role": "assistant", "content": message_response})
    return {'text': message_response, 'audio_url': ''}

