
INSERT INTO security_principal (
    tenant_id,
    principal_type,
    principal_name,
    sid
)
VALUES
(uuid_generate_v4(), 'ROLE', 'DOMAIN_ADMINISTRATOR', 'S-1-APPSTRAP-500'),
(uuid_generate_v4(), 'ROLE', 'BACKUP_OPERATOR', 'S-1-APPSTRAP-551'),
(uuid_generate_v4(), 'ROLE', 'AUDITOR', 'S-1-APPSTRAP-552'),
(uuid_generate_v4(), 'ROLE', 'SECURITY_ADMINISTRATOR', 'S-1-APPSTRAP-553');
