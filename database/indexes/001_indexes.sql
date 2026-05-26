
CREATE INDEX idx_registry_node_path
ON registry_node(canonical_path);

CREATE INDEX idx_registry_value_override
ON registry_value(override_flag);

CREATE INDEX idx_graph_entity_cache_score
ON graph_entity(predictive_cache_score DESC);

CREATE INDEX idx_event_stream_emitted_at
ON event_stream(emitted_at DESC);
