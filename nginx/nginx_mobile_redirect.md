# nginx_mobile_redirect

```bash
set $mobile_rewrite do_not_perform;

if ($http_user_agent ~* "android|ip(hone|od)|kindle") {
    set $mobile_rewrite perform;
}

if ($mobile_rewrite = perform) {
    rewrite ^ http://m.ishansong.com$request_uri? redirect;
    break;
}
```