import os

from flask import Flask
from flask_migrate import Migrate
from flask_cors import CORS
from flask.json import jsonify

import api.database.DBConnection as DBConn
from api.app.Exceptions.APIException import APIException


def create_app():
    # create and configure the app
    app = Flask(__name__, instance_relative_config=True)
    app.config.from_pyfile(os.path.abspath("./Environment.py"))
    app.config["SQLALCHEMY_DATABASE_URI"] = DBConn.connect_url
    app.config["MAX_CONTENT_LENGTH"] = 150 * 1000 * 1000
    migrate = Migrate(app, DBConn.db, render_as_batch=True)

    @migrate.configure
    def configure_alembic(config):
        # modify config object
        return config

    DBConn.db.init_app(app)
    CORS(app)

    # ensure the instance folder exists
    try:
        os.makedirs(app.instance_path)
    except OSError:
        pass

    from .routes import auth_router
    from .routes import camiones_router
    from .routes import materiales_router
    from .routes import clientes_router
    from .routes import obras_router
    from .routes import transportistas_router
    from .routes import checadores_router
    from .routes import ubicaciones_router
    from .routes import tickets_router
    from .routes import ticketsrecepcion_router

    # replace this for add routes <-- NOT REMOVE THE COMMENT

    VERSION_API = "/api/v1.0.0"

    # app.register_blueprint(example_router, url_prefix='/example')
    app.register_blueprint(auth_router, url_prefix=f"{VERSION_API}/auth")
    app.register_blueprint(camiones_router, url_prefix=f"{VERSION_API}/camiones")
    app.register_blueprint(materiales_router, url_prefix=f"{VERSION_API}/materiales")
    app.register_blueprint(clientes_router, url_prefix=f"{VERSION_API}/clientes")
    app.register_blueprint(obras_router, url_prefix=f"{VERSION_API}/obras")
    app.register_blueprint(
        transportistas_router, url_prefix=f"{VERSION_API}/transportistas"
    )
    app.register_blueprint(checadores_router, url_prefix=f"{VERSION_API}/checadores")
    app.register_blueprint(ubicaciones_router, url_prefix=f"{VERSION_API}/ubicaciones")
    app.register_blueprint(tickets_router, url_prefix=f"{VERSION_API}/tickets")
    app.register_blueprint(
        ticketsrecepcion_router, url_prefix=f"{VERSION_API}/ticketsrecepcion"
    )
    # replace this for add blueprint <-- NOT REMOVE THE COMMENT

    @app.errorhandler(APIException)
    def handle_invalid_usage(error: APIException):
        response = jsonify(error.to_dict())
        response.status_code = error.status_code
        return response

    return app
