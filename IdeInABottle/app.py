"""
This script runs the application using a development server.
"""
import bottle
from beaker.middleware import SessionMiddleware
from requestlogger import WSGILogger, ApacheFormatter
from logging.handlers import TimedRotatingFileHandler
import os
import sys
import json

app = bottle.default_app()     

# Load configuration from a json file
cfg_file = os.path.dirname(os.path.realpath(__file__)) + os.sep +'appcfg.json'
with open(cfg_file) as fp:
    app.config.load_dict(json.load(fp))

# Configure Beaker Session Middleware
app = SessionMiddleware(app, app.config.session_options)

# Configure wsgi-request-logger Middleware
handlers = [ TimedRotatingFileHandler('access.log', 'd', 7) , ]
app = WSGILogger(app, handlers, ApacheFormatter())

# routes contains the HTTP handlers for our server and must be imported.
import routes.login
import routes.ide

if '--debug' in sys.argv[1:] or 'SERVER_DEBUG' in os.environ:
    # Debug mode will enable more verbose output in the console window.
    # It must be set at the beginning of the script.
    bottle.debug(True)

def wsgi_app():
    """Returns the application to make available through wfastcgi. This is used
    when the site is published to Microsoft Azure."""
    return bottle.default_app()

if __name__ == '__main__':
    PROJECT_ROOT = os.path.abspath(os.path.dirname(__file__))
    STATIC_ROOT = os.path.join(PROJECT_ROOT, 'static').replace('\\', '/')
    HOST = os.environ.get('SERVER_HOST', 'localhost')
    try:
        PORT = int(os.environ.get('SERVER_PORT', '5555'))
    except ValueError:
        PORT = 5555

    @bottle.route('/static/<filepath:path>')
    def server_static(filepath):
        """Handler for static files, used with the development server.
        When running under a production server such as IIS or Apache,
        the server should be configured to serve the static files."""
        return bottle.static_file(filepath, root=STATIC_ROOT)

    # Starts a local test server.
    bottle.run(server='wsgiref', host=HOST, port=PORT,  app=app)
