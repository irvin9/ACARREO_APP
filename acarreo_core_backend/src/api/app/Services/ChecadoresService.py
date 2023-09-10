from api.app.Core.Services.BaseService import BaseService
from api.app.Data.Models import Checadores


class ChecadoresService(BaseService):
    def __init__(self) -> None:
        super().__init__(Checadores)