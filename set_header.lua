access_by_lua '
  local redis = require "redis"
  local red = redis:new()
  local ok, err = red:connect("172.24.0.1", 6379)
  if not ok then
    ngx.log(ngx.ERR, "failed to connect to redis: ", err)
    return ngx.exit(500)
  end

  local token = tostring(ngx.var.http_authorization)

  token = token:gsub("Basic ", "")
  token = ngx.decode_base64(token)
  token = token:gsub(":", "")

  local found_token, err = red:get(token)

  if (found_token == ngx.null and ngx.var.http_authorization ~= nil) then
    ngx.log(ngx.ERR, "Token not found or valid: ", token)
    return ngx.exit(403)
  end

  found_token = tostring(found_token) .. ":x-oauth-basic"

  local auth_header = "Basic " .. ngx.encode_base64(found_token)
  ngx.req.set_header("Authorization", auth_header)
  ';
