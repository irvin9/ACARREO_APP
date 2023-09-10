from typing import Any, Dict, List
from sqlalchemy import Column, Integer, String, DateTime
from sqlalchemy.sql import func
from ...Core.Data.BaseModel import BaseModel


class Ticketsrecepcion(BaseModel):
    """Table Ticketsrecepcions Database model

    Args:
        BaseModel (ORMClass): Parent class

    Returns:
        Ticketsrecepcion: Instance of model
    """

    __tablename__ = "ticketsrecepcion"
    id = Column("id", Integer, primary_key=True)
    folio_origin = Column("folioOrigen", String(191), nullable=False)
    folio = Column("folio", String(191), nullable=False)
    id_truck = Column("id_camion", Integer, nullable=False)
    id_tracker = Column("id_checador", Integer, nullable=False)
    id_end_travel = Column("id_ubicacionDestino", Integer, nullable=False)
    id_material = Column("id_material", Integer, nullable=False)
    description = Column("nota", String(191), nullable=False)
    project_unit = Column("unidadObra", String(191), nullable=False)
    id_client = Column("id_cliente", Integer, nullable=False)
    id_project = Column("id_obra", Integer, nullable=False)
    created_at = Column(
        "created_at", DateTime(timezone=True), server_default=func.now()
    )
    updated_at = Column("updated_at", DateTime(timezone=True), onupdate=func.now())

    model_path_name = "ticketsrecepcion"

    def property_map(self) -> Dict:
        return {
            "id": "id",
            "folio_origin": "folio_origin",
            "folio": "folio",
            "id_truck": "id_truck",
            "id_tracker": "id_tracker",
            "id_end_travel": "id_end_travel",
            "id_material": "id_material",
            "description": "description",
            "project_unit": "project_unit",
            "id_client": "id_client",
            "id_project": "id_project",
            "created_at": "created_at",
            "updated_at": "updated_at",
        }

    def display_members(self) -> List[str]:
        return [
            "id",
            "folio_origin",
            "folio",
            "id_truck",
            "id_travel",
            "id_end_travel",
            "id_material",
            "description",
            "project_unit",
            "id_client",
            "id_project",
            "created_at",
            "updated_at",
        ]

    @classmethod
    def rules_for_store(cls) -> Dict[str, List[Any]]:
        return {}
