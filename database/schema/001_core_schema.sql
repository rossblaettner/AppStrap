
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE registry_namespace (
    namespace_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    namespace_name VARCHAR(200) NOT NULL UNIQUE,
    description TEXT,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON TABLE registry_namespace IS 'Top-level registry namespace.';
COMMENT ON COLUMN registry_namespace.namespace_name IS 'Logical registry hive name.';

CREATE TABLE registry_node (
    node_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    namespace_id UUID NOT NULL REFERENCES registry_namespace(namespace_id),
    parent_node_id UUID REFERENCES registry_node(node_id),
    node_name VARCHAR(255) NOT NULL,
    canonical_path TEXT NOT NULL,
    node_type VARCHAR(100) NOT NULL DEFAULT 'DIRECTORY',
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON TABLE registry_node IS 'Hierarchical registry nodes.';
COMMENT ON COLUMN registry_node.canonical_path IS 'Fully-qualified registry path.';

CREATE TABLE registry_value (
    value_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    node_id UUID NOT NULL REFERENCES registry_node(node_id),
    value_name VARCHAR(255) NOT NULL,
    value_type VARCHAR(50) NOT NULL,
    value_json JSONB,
    inherited_flag BOOLEAN NOT NULL DEFAULT FALSE,
    override_flag BOOLEAN NOT NULL DEFAULT FALSE,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON TABLE registry_value IS 'Typed registry values.';
COMMENT ON COLUMN registry_value.override_flag IS 'True when locally overridden from inheritance chain.';

CREATE TABLE graph_entity (
    graph_entity_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    entity_type VARCHAR(100) NOT NULL,
    entity_reference_id UUID NOT NULL,
    reference_count BIGINT NOT NULL DEFAULT 0,
    read_count BIGINT NOT NULL DEFAULT 0,
    write_count BIGINT NOT NULL DEFAULT 0,
    predictive_cache_score NUMERIC(10,4) NOT NULL DEFAULT 0,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON TABLE graph_entity IS 'Canonical graph node abstraction.';
COMMENT ON COLUMN graph_entity.predictive_cache_score IS 'Calculated cache prediction score.';

CREATE TABLE event_stream (
    event_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    event_type VARCHAR(100) NOT NULL,
    transaction_id UUID,
    event_payload JSONB NOT NULL,
    emitted_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON TABLE event_stream IS 'Immutable event stream.';
COMMENT ON COLUMN event_stream.event_payload IS 'Serialized event payload.';
