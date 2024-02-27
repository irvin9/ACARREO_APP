from typing import Any, Dict, List
from sqlalchemy import Column, Integer, String, DateTime
from sqlalchemy.sql import func
from ...Core.Data.BaseModel import BaseModel


class TicketMaterialSupplier(BaseModel):
    """ Table TicketsMaterialSuppliers Database model

    Args:
        BaseModel (ORMClass): Parent class

    Returns:
        TicketMaterialSupplier: Instance of model
    """
    __tablename__ = 'tickets_material_suppliers'
    id = Column("id", Integer, primary_key=True)
    folio_ticket = Column("folioId", String(191), nullable=True)
    date = Column("fecha", String(191), nullable=True)
    id_export_company = Column("id_empresa_explotadora", Integer, nullable=False)
    id_customer = Column("id_customer", Integer, nullable=False)
    folio_external_ticket = Column("folio_ticket_externo", Integer, nullable=False)
    id_truck = Column("id_camion", Integer, nullable=False)
    id_tracker = Column("id_checador", Integer, nullable=False)
    id_location = Column("id_ubicacion", Integer, nullable=False)
    id_material = Column("id_material", Integer, nullable=False)
    description = Column("nota", String(191), nullable=True)
    folio_bank = Column("folio_banco", String(191), nullable=True)
    id_client = Column("id_cliente", Integer, nullable=False)
    id_project = Column("id_obra", Integer, nullable=False)
    created_at = Column("created_at", DateTime(timezone=True), default=func.now())
    updated_at = Column("updated_at", DateTime(timezone=True), onupdate=func.now())

    model_path_name = "TicketMaterialSupplier"

    filter_columns = ["folio_ticket", "id_export_company", "id_customer", "folio_external_ticket", "id_tracker",
                      "id_location", "id_material", "id_material", "folio_bank", "id_client", "id_project"]

    def property_map(self) -> Dict:
        return {
            "id": "id",
            "folio_ticket": "folio_ticket",
            "date": "date",
            "id_export_company": "id_export_company",
            "id_customer": "id_customer",
            "folio_external_ticket": "folio_external_ticket",
            "id_truck": "id_truck",
            "id_tracker": "id_tracker",
            "id_location": "id_location",
            "id_material": "id_material",
            "description": "description",
            "folio_bank": "folio_bank",
            "id_client": "id_client",
            "id_project": "id_project",
            "created_at": "created_at",
            "updated_at": "updated_at",
        }

    @classmethod
    def display_members(cls) -> List[str]:
        return [
            "id",
            "folio_ticket",
            "date",
            "id_export_company",
            "id_customer",
            "folio_external_ticket",
            "id_tracker",
            "id_truck",
            "id_location",
            "id_material",
            "description",
            "folio_bank",
            "id_client",
            "id_project",
            "created_at",
            "updated_at",
        ]

    @classmethod
    def rules_for_store(cls) -> Dict[str, List[Any]]:
        return {
        }
