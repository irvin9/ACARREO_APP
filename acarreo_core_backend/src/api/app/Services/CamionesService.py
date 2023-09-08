from api.app.Core.Services.BaseService import BaseService
from api.app.Data.Models import Camiones


class CamionesService(BaseService):
    def __init__(self) -> None:
        super().__init__(Camiones)