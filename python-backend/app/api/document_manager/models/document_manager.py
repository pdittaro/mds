import uuid
from datetime import datetime

from sqlalchemy.dialects.postgresql import UUID
from sqlalchemy.schema import FetchedValue
from app.extensions import db

from ...utils.models_mixins import AuditMixin, Base

class DocumentManager(AuditMixin, Base):
    __tablename__ = 'document_manager'
    document_manager_id = db.Column(db.Integer, primary_key=True, server_default=FetchedValue())
    document_guid = db.Column(UUID(as_uuid=True), nullable=False)
    full_storage_path = db.Column(db.String(150), nullable=False)
    upload_started_date = db.Column(db.DateTime, nullable=False)
    upload_completed_date = db.Column(db.DateTime, nullable=True)
    file_display_name = db.Column(db.String(40), nullable=False)
    path_display_name = db.Column(db.String(150), nullable=False)

    def __repr__(self):
        return '<DocumentManager %r>' % self.document_manager_id

    def json(self):
        return {
            'document_manager_id': self.document_manager_id,
            'document_guid': str(self.document_guid),
            'full_storage_path': self.full_storage_path,
            'upload_started_date': str(self.upload_started_date),
            'upload_completed_date': str(self.upload_completed_date) if self.upload_completed_date else None,
            'file_display_name': self.file_display_name,
            'path_display_name': self.path_display_name
        }

    @classmethod
    def find_by_document_manager_guid(cls, document_guid):
        try:
            uuid.UUID(document_guid, version=4)
            return cls.query.filter_by(document_guid=document_guid).first()
        except ValueError:
            return None
