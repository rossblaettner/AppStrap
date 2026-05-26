
# Database Data Dictionary

## registry_namespace
| Column | Description |
|---|---|
| namespace_id | Primary key UUID |
| namespace_name | Registry hive name |
| description | Namespace description |

## registry_node
| Column | Description |
|---|---|
| node_id | Registry node identifier |
| canonical_path | Fully-qualified registry path |
| node_type | DIRECTORY or VALUE |

## registry_value
| Column | Description |
|---|---|
| inherited_flag | Indicates inherited value |
| override_flag | Indicates local override |

## graph_entity
| Column | Description |
|---|---|
| predictive_cache_score | Cache optimization weighting |
