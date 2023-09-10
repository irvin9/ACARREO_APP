from typing import Any, Dict, List
from sqlalchemy import Column, Integer, String, DateTime
from sqlalchemy.sql import func
from ...Core.Data.BaseModel import BaseModel


class Checadores(BaseModel):
    """Table Checadoress Database model

    Args:
        BaseModel (ORMClass): Parent class

    Returns:
        Checadores: Instance of model
    """

    __tablename__ = "checadores"
    id = Column("id", Integer, primary_key=True)
    user = Column("usuario", String(191), nullable=False)
    password = Column("password", String(191), nullable=False)
    name = Column("nombre", String(191), nullable=False)
    fathers_lastname = Column("apellidoPaterno", String(191), nullable=False)
    mothers_lastname = Column("apellidoMaterno", String(191), nullable=False)
    id_client = Column("id_cliente", Integer, nullable=False)
    id_project = Column("id_obra", Integer, nullable=False)
    created_at = Column("created_at", DateTime(timezone=True), default=func.now())
    updated_at = Column("updated_at", DateTime(timezone=True), onupdate=func.now())

    model_path_name = "checadores"

    def property_map(self) -> Dict:
        return {
            "id": "id",
            "user": "user",
            "password": "password",
            "name": "name",
            "fathers_lastname": "fathers_lastname",
            "mothers_lastname": "mothers_lastname",
            "id_client": "id_client",
            "id_project": "id_project",
            "created_at": "created_at",
            "updated_at": "updated_at",
        }

    @classmethod
    def display_members(cls) -> List[str]:
        return [
            "id",
            "user",
            "password",
            "name",
            "fathers_lastname",
            "mothers_lastname",
            "id_client",
            "id_project",
            "created_at",
            "updated_at",
        ]

    @classmethod
    def rules_for_store(cls) -> Dict[str, List[Any]]:
        return {}
