from typing import Any, Dict, List
from sqlalchemy import Column, Integer, String, DateTime
from sqlalchemy.sql import func
from ...Core.Data.BaseModel import BaseModel


class Obras(BaseModel):
    """Table Obrass Database model

    Args:
        BaseModel (ORMClass): Parent class

    Returns:
        Obras: Instance of model
    """

    __tablename__ = "obras"
    id = Column("id", Integer, primary_key=True)
    enterprise_name = Column("nombreEmpresa", String(191), nullable=False)
    project_code = Column("codigoObra", String(191), nullable=False)
    project_name = Column("nombreObra", String(191), nullable=False)
    status = Column("estatus", Integer, nullable=False)
    id_client = Column("id_cliente", Integer, nullable=False)
    created_at = Column(
        "created_at", DateTime(timezone=True), server_default=func.now()
    )
    updated_at = Column("updated_at", DateTime(timezone=True), onupdate=func.now())

    model_path_name = "obras"

    def property_map(self) -> Dict:
        return {
            "id": "id",
            "enterprise_name": "enterprise_name",
            "project_code": "project_code",
            "project_name": "project_name",
            "status": "status",
            "created_at": "created_at",
            "updated_at": "updated_at",
        }

    def display_members(self) -> List[str]:
        return [
            "id",
            "enterprise_name",
            "project_code",
            "project_name",
            "status",
            "created_at",
            "updated_at",
        ]

    @classmethod
    def rules_for_store(cls) -> Dict[str, List[Any]]:
        return {}
