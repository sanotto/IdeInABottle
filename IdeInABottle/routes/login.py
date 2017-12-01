"""
Routes and views for login
"""

from bottle import route, view, request, redirect
from datetime import datetime
import json
from helpers.decorators import logged_in    

@route('/')
@route('/home')
@view('index')
def home():
    return dict(title="IDE In a Bottle")

@route('/login', method='POST')
def login():    
    data = json.loads(request.POST['request'])
    session  = request.environ.get('beaker.session')    
    session['user_name'] = ''
    if data['record']['user_name'] == "puca":
        #Acá, grabar en la "sesión" el nombre del usuario, si esta en blanco => no está logueado        
        session['user_name'] = data['record']['user_name']
        session.save()
        return {"status": "success", "redirect_to":"ide"}
    return {"status": "error",   "message": "Error message: " +data['record']['user_name']+' is not a valid user'  }

@route('/logout')
def logout():
    session=request.environ.get('beaker.session')    
    session.invalidate()
    redirect('/')


