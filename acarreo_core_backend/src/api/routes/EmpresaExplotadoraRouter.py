from flask import Blueprint
from api.app.Controllers.EmpresaExplotadoraController import index, find, store, update, delete
from api.app.Services.EmpresaExplotadoraService import EmpresaexplotadoraService

empresaexplotadora_router = Blueprint('empresaexplotadora', __name__)
empresaexplotadora_service = EmpresaexplotadoraService()

empresaexplotadora_router.route('/', methods=['GET'], defaults={'service': empresaexplotadora_service}) (index)
empresaexplotadora_router.route('/', methods=['POST'], defaults={'service': empresaexplotadora_service}) (store)
empresaexplotadora_router.route('/<id>', methods=['GET'], defaults={'service': empresaexplotadora_service}) (find)
empresaexplotadora_router.route('/<id>', methods=['PUT'], defaults={'service': empresaexplotadora_service}) (update)
empresaexplotadora_router.route('/<id>', methods=['DELETE'], defaults={'service': empresaexplotadora_service}) (delete)