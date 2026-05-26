
CREATE VIEW vw_registry_paths AS
SELECT
    rn.namespace_name,
    n.node_name,
    n.canonical_path,
    v.value_name,
    v.value_type,
    v.override_flag
FROM registry_namespace rn
JOIN registry_node n ON rn.namespace_id = n.namespace_id
LEFT JOIN registry_value v ON n.node_id = v.node_id;

CREATE VIEW vw_hot_graph_entities AS
SELECT *
FROM graph_entity
WHERE predictive_cache_score > 0.75
ORDER BY predictive_cache_score DESC;
