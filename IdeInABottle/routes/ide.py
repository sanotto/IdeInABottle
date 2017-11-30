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

