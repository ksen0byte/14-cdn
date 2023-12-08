$TTL    604800
@       IN      SOA     ns1.localtest.com. admin.localtest.com. (
                        20230104          ; Serial
                           3600           ; Refresh
                            600           ; Retry
                         604800           ; Expire
                          1800 )         ; Negative Cache TTL

; Name Server Information
@       IN      NS      ns1.localtest.com.

; IP address of ns1.localtest.com
ns1     IN      A       172.29.69.133     ; Use your BIND server's IP address

; Subdomain records
us      IN      A       172.29.69.133     ; Use your local HTTP server's IP
de      IN      A       172.29.69.133     ; Same as above
