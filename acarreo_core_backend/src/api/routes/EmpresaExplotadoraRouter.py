from flask import Blueprint
from api.app.Controllers.EmpresaExplotadoraController import index, find, store, update, delete
from api.app.Services.EmpresaExplotadoraService import EmpresaexplotadoraService

empresaExplotadora_router = Blueprint('empresaexplotadora', __name__)
empresaexplotadora_service = EmpresaexplotadoraService()

empresaExplotadora_router.route('/', methods=['GET'], defaults={'service': empresaexplotadora_service}) (index)
empresaExplotadora_router.route('/', methods=['POST'], defaults={'service': empresaexplotadora_service}) (store)
empresaExplotadora_router.route('/<id>', methods=['GET'], defaults={'service': empresaexplotadora_service}) (find)
empresaExplotadora_router.route('/<id>', methods=['PUT'], defaults={'service': empresaexplotadora_service}) (update)
empresaExplotadora_router.route('/<id>', methods=['DELETE'], defaults={'service': empresaexplotadora_service}) (delete)