from typing import Any, Dict, List
from sqlalchemy import Column, Integer, String, DateTime
from sqlalchemy.sql import func
from ...Core.Data.BaseModel import BaseModel


class Ubicaciones(BaseModel):
    """Table ubicacioness Database model

    Args:
        BaseModel (ORMClass): Parent class

    Returns:
        ubicaciones: Instance of model
    """

    __tablename__ = "ubicaciones"
    id = Column("id", Integer, primary_key=True)
    name = Column("nombre", String(191), nullable=False)
    latitude = Column("latitud", String(191), nullable=False)
    longitude = Column("longitud", String(191), nullable=False)
    state = Column("estatus", Integer, nullable=False)
    id_client = Column("id_cliente", Integer, nullable=False)
    id_project = Column("id_obra", Integer, nullable=False)
    created_at = Column("created_at", DateTime(timezone=True), default=func.now())
    updated_at = Column("updated_at", DateTime(timezone=True), onupdate=func.now())

    model_path_name = "ubicaciones"

    def property_map(self) -> Dict:
        return {
            "id": "id",
            "name": "name",
            "latitude": "latitude",
            "longitude": "longitude",
            "state": "state",
            "id_client": "id_client",
            "id_project": "id_project",
            "created_at": "created_at",
            "updated_at": "updated_at",
        }

    @classmethod
    def display_members(cls) -> List[str]:
        return [
            "id",
            "name",
            "latitude",
            "longitude",
            "state",
            "id_client",
            "id_project",
            "created_at",
            "updated_at",
        ]

    @classmethod
    def rules_for_store(cls) -> Dict[str, List[Any]]:
        return {}
