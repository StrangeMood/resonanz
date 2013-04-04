import logging
import os
from tornado import websocket, web, ioloop
from chat import Chat
from models import Session

os.environ['TZ'] = 'Europe/Moscow'

logging.basicConfig()
logging.getLogger('sqlalchemy.engine').setLevel(logging.INFO)

database_session = Session()

application = web.Application([
    (r'/conversations/([\w_-]+)', Chat, dict(db=database_session)),
], cookie_secret='SOME_SECRET_HERE', debug=True)

if __name__ == '__main__':
    application.listen(8888)
    ioloop.IOLoop.instance().start()
