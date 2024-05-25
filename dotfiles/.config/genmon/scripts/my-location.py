import geocoder

geo = geocoder.ip("me")
print(f"<icon>network-vpn-symbolic</icon><txt> {geo.city} / {geo.country} / {geo.latlng}</txt><tool></tool>")
