
CREATE OR REPLACE FUNCTION fn_increment_graph_reads(p_graph_entity_id UUID)
RETURNS VOID AS $$
BEGIN
    UPDATE graph_entity
    SET read_count = read_count + 1
    WHERE graph_entity_id = p_graph_entity_id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION fn_touch_registry_node()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_touch_registry_node
BEFORE UPDATE ON registry_node
FOR EACH ROW
EXECUTE FUNCTION fn_touch_registry_node();
