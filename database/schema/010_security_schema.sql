
CREATE TABLE tenant (
    tenant_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    tenant_name VARCHAR(255) NOT NULL UNIQUE,
    tenant_type VARCHAR(100),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON TABLE tenant IS 'Logical security tenant or forest root.';

CREATE TABLE tenant_trust_relationship (
    tenant_trust_relationship_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),

    source_tenant_id UUID NOT NULL REFERENCES tenant(tenant_id),
    target_tenant_id UUID NOT NULL REFERENCES tenant(tenant_id),

    trust_type VARCHAR(50) NOT NULL,
    transitive_flag BOOLEAN NOT NULL DEFAULT FALSE,
    active_flag BOOLEAN NOT NULL DEFAULT TRUE,

    established_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON TABLE tenant_trust_relationship IS 'Tenant forest trust relationships.';

CREATE TABLE security_principal (
    security_principal_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),

    tenant_id UUID NOT NULL REFERENCES tenant(tenant_id),

    principal_type VARCHAR(100) NOT NULL,
    principal_name VARCHAR(255) NOT NULL,

    sid VARCHAR(255) NOT NULL UNIQUE,

    active_flag BOOLEAN NOT NULL DEFAULT TRUE,

    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON TABLE security_principal IS 'Users, groups, roles, and service accounts.';

CREATE TABLE security_group_membership (
    security_group_membership_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),

    group_principal_id UUID NOT NULL REFERENCES security_principal(security_principal_id),
    member_principal_id UUID NOT NULL REFERENCES security_principal(security_principal_id),

    inherited_flag BOOLEAN NOT NULL DEFAULT FALSE,

    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON TABLE security_group_membership IS 'Principal group membership mapping.';

CREATE TABLE security_descriptor (
    security_descriptor_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),

    owner_principal_id UUID REFERENCES security_principal(security_principal_id),

    inheritance_enabled BOOLEAN NOT NULL DEFAULT TRUE,
    audit_enabled BOOLEAN NOT NULL DEFAULT TRUE,

    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON TABLE security_descriptor IS 'NTFS-style object security descriptor.';

CREATE TABLE access_control_entry (
    access_control_entry_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),

    security_descriptor_id UUID NOT NULL REFERENCES security_descriptor(security_descriptor_id),

    principal_id UUID NOT NULL REFERENCES security_principal(security_principal_id),

    ace_type VARCHAR(50) NOT NULL,
    permission_mask BIGINT NOT NULL,

    inherit_to_children BOOLEAN NOT NULL DEFAULT TRUE,
    inherit_to_values BOOLEAN NOT NULL DEFAULT TRUE,
    inherit_to_keys BOOLEAN NOT NULL DEFAULT TRUE,

    inherited_flag BOOLEAN NOT NULL DEFAULT FALSE,

    propagation_flags VARCHAR(255),

    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON TABLE access_control_entry IS 'NTFS-style ACE entries.';
COMMENT ON COLUMN access_control_entry.permission_mask IS 'Bitmask of effective permissions.';

ALTER TABLE registry_node
ADD COLUMN security_descriptor_id UUID REFERENCES security_descriptor(security_descriptor_id);

ALTER TABLE registry_value
ADD COLUMN security_descriptor_id UUID REFERENCES security_descriptor(security_descriptor_id);

CREATE TABLE security_audit_log (
    security_audit_log_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),

    principal_id UUID REFERENCES security_principal(security_principal_id),

    object_type VARCHAR(100),
    object_id UUID,

    action_type VARCHAR(100),

    allowed_flag BOOLEAN NOT NULL,

    permission_mask BIGINT,

    audit_timestamp TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    audit_payload JSONB
);

COMMENT ON TABLE security_audit_log IS 'Security access audit events.';
