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
    created_at = Column(
        "created_at", DateTime(timezone=True), server_default=func.now()
    )
    updated_at = Column("updated_at", DateTime(timezone=True), onupdate=func.now())

    model_path_name = "ubicaciones"

    def property_map(self) -> Dict:
        return {
            "id": "id",
            "name": "name",
            "latitude": "latitude",
            "longitude": "longitude",
            "state": "state",
            "created_at": "created_at",
            "updated_at": "updated_at",
        }

    def display_members(self) -> List[str]:
        return [
            "id",
            "name",
            "latitude",
            "longitude",
            "state",
            "created_at",
            "updated_at",
        ]

    @classmethod
    def rules_for_store(cls) -> Dict[str, List[Any]]:
        return {}
