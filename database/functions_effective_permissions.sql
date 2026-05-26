
CREATE OR REPLACE FUNCTION fn_calculate_effective_permissions(
    p_principal_id UUID,
    p_security_descriptor_id UUID
)
RETURNS TABLE (
    principal_id UUID,
    effective_permission_mask BIGINT,
    deny_permission_mask BIGINT,
    inheritance_depth INTEGER
)
AS $$
BEGIN
    RETURN QUERY
    WITH recursive_principals AS (
        SELECT
            sp.security_principal_id
        FROM security_principal sp
        WHERE sp.security_principal_id = p_principal_id

        UNION

        SELECT
            sgm.group_principal_id
        FROM security_group_membership sgm
        JOIN recursive_principals rp
            ON sgm.member_principal_id = rp.security_principal_id
    ),
    effective_aces AS (
        SELECT
            ace.principal_id,
            ace.permission_mask,
            ace.ace_type,
            ace.inherited_flag
        FROM access_control_entry ace
        JOIN recursive_principals rp
            ON ace.principal_id = rp.security_principal_id
        WHERE ace.security_descriptor_id = p_security_descriptor_id
    )
    SELECT
        p_principal_id,
        COALESCE(SUM(
            CASE
                WHEN ace_type = 'ALLOW'
                THEN permission_mask
                ELSE 0
            END
        ),0),
        COALESCE(SUM(
            CASE
                WHEN ace_type = 'DENY'
                THEN permission_mask
                ELSE 0
            END
        ),0),
        0
    FROM effective_aces;
END;
$$ LANGUAGE plpgsql;

COMMENT ON FUNCTION fn_calculate_effective_permissions(UUID, UUID)
IS 'Calculates effective NTFS-style permissions for a principal against an object.';
