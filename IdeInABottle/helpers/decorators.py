from bottle import request, redirect

def logged_in(old_function):
    def new_function(*args, **kwds):                 
        session = request.environ.get('beaker.session')        
        if  not 'user_name' in session:
            redirect("/")  
        return old_function(*args, **kwds)

    return new_function