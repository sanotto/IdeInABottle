from bottle import route, view, request, redirect
from datetime import datetime
import json
from helpers.decorators import logged_in

@route('/ide')
@view('ide')
@logged_in
def ide():
    session = request.environ.get('beaker.session')    
    logout = "<a href='/logout'> Cerrar sesi&oacute;n de:"+session['user_name']+'</a>'
    return {'session':session, 'title':'IDE In A Bottle'}

@route('/source_load')
def source_load():
    str = open('README.md', 'r').read()
    return str

@route('/source_save', method='POST')
def source_save():    
    body = request.body.read()
    f=open('README.md', 'w')
    f.write(body.decode("utf-8") )
    f.close()
    return ""
