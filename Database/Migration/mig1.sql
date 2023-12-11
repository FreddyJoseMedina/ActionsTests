--liquibase formatted sql

SET search_path TO wbtvd_owner, public;

--comment:20211216_114500_video_partners_endpoints.sql

--changeset {AUTHOR}:1_{ID}  logicalFilePath:{migrations/seeders}/{FILENAME}
INSERT INTO wbtv_functions_permission (function_id, permission_name, sub_function_id, permission_type, display_order, is_default_selection, filter_id, uri_method, uri)
VALUES (
           (
               SELECT function_id
               FROM wbtv_function
               WHERE function_name = 'VIDEO API'
           ),
           'Update Video Partners', null, 3, 0, 0, null, 'PUT', '/asset/video/{videoId}/partner'
       ) ON CONFLICT DO NOTHING;

--changeset {AUTHOR}:2_{ID}  logicalFilePath:{migrations/seeders}/{FILENAME}
INSERT INTO wbtv_func_permission_role (role_id, function_permission_id, updated_by, updated_date, default_select)
VALUES (
           (
               SELECT role_id
               FROM wbtv_role
               WHERE name = 'API_ADMIN'
           ), (
               SELECT function_permission_id
               FROM wbtv_functions_permission
               WHERE permission_type = 3 AND uri_method='PUT' AND uri='/asset/video/{videoId}/partner'
           ),
           'B2B_OWNER', CURRENT_TIMESTAMP, 0
       ) ON CONFLICT DO NOTHING;