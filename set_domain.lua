local token = found_token:match("^%w+://([^@]+)")
local domain = found_token:match("%w+@([^/]+)")
local index = string.find(found_token, "/", string.len(token));
local uri = string.sub(found_token, index)
-- ? add to uri "/info/refs?service=git-upload-pack"

ngx.req.set_uri(uri)
ngx.var.backend_host = "https://"..domain
